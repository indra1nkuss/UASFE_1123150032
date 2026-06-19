import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/services/updated_deep_link_handler.dart';
import '../../blocs/payment/payment_bloc.dart';
import '../../widgets/pin_pad.dart';

class PinPage extends StatefulWidget {
  final Map<String, dynamic> flowData;
  const PinPage({super.key, required this.flowData});

  @override
  State<PinPage> createState() => _PinPageState();
}

class _PinPageState extends State<PinPage> {
  String _pin = '';
  bool _busy = false;
  bool _hasError = false;

  void _onComplete(String pin) {
    setState(() {
      _pin = pin;
      _busy = true;
    });
    _processPayment();
  }

  void _processPayment() {
    final flow = widget.flowData;
    final kind = flow['kind'] as String? ?? '';

    if (kind == 'transfer') {
      // Use OTP from 2FA — for demo we use a hardcoded type
      context.read<PaymentBloc>().add(PaymentTransferRequested(
        amount: (flow['amount'] as num).toDouble(),
        description: flow['note'] as String? ?? 'Transfer',
        otpCode: '000000', // In production: get from actual 2FA
        otpType: AppConstants.otpTypeTotp,
      ));
    } else if (kind == 'topup') {
      context.read<PaymentBloc>().add(PaymentTopupRequested(
        (flow['amount'] as num).toDouble(),
      ));
    } else if (kind == 'payment' || kind == 'deeplink_dummy') {
      // QRIS payment → also uses transfer endpoint
      context.read<PaymentBloc>().add(PaymentTransferRequested(
        amount: (flow['amount'] as num).toDouble(),
        description: flow['description'] as String? ?? 'Pembayaran QRIS',
        otpCode: '000000',
        otpType: AppConstants.otpTypeTotp,
      ));
    } else if (kind == 'deeplink_real') {
      context.read<PaymentBloc>().add(ProcessDeepLinkPaymentEvent(
        trxId: flow['trxId'] as String,
        amount: (flow['amount'] as num).toDouble(),
        description: flow['description'] as String? ?? '',
        sourceApp: flow['sourceApp'] as String? ?? 'rentbike',
        otpCode: _pin, // Kode TOTP Google Authenticator yang diketik user
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PaymentBloc, PaymentState>(
      listener: (context, state) {
        if (state is DeepLinkPaymentSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('✅ Pembayaran berhasil! Sisa saldo: ${CurrencyFormatter.format(state.remainingBalance)}'),
              backgroundColor: AppColors.primary,
              duration: const Duration(seconds: 2),
            ),
          );
          Future.delayed(const Duration(milliseconds: 1500), () async {
            // Kembali ke aplikasi pemanggil (RentBike)
            await DeepLinkHandler.returnToRentBike(
              trxId: widget.flowData['trxId'] ?? '',
              success: true,
            );
            if (context.mounted) context.go('/home');
          });
        } else if (state is PaymentTransferSuccess) {
          final result = state.result;
          context.go('/success', extra: {
            'title': 'Transfer berhasil',
            'subtitle': result.description,
            'amount': result.amount,
            'lines': [
              ['Jumlah', CurrencyFormatter.format(result.amount)],
              ['Saldo setelah', CurrencyFormatter.format(result.balanceAfter)],
              ['Ref', 'DKG${result.transactionId}'],
            ],
          });
        } else if (state is PaymentTopupSuccess) {
          context.go('/success', extra: {
            'title': 'Top up berhasil',
            'subtitle': 'Saldo kamu bertambah',
            'amount': state.amount,
            'lines': [
              ['Jumlah', CurrencyFormatter.format(state.amount)],
              ['Saldo sekarang', CurrencyFormatter.format(state.balance)],
            ],
          });
        } else if (state is PaymentInvalidOtp) {
          setState(() { _busy = false; _hasError = true; _pin = ''; });
          Future.delayed(const Duration(milliseconds: 800), () {
            if (mounted) setState(() => _hasError = false);
          });
        } else if (state is PaymentError) {
          setState(() => _busy = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: AppColors.red),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.close_rounded, color: AppColors.ink),
                  onPressed: () {
                    if (widget.flowData['kind'] == 'deeplink_real') {
                      DeepLinkHandler.returnToRentBike(
                        trxId: widget.flowData['trxId'] ?? '',
                        success: false,
                      );
                    }
                    context.go('/home');
                  },
                ),
              ),
              if (_busy) ...[
                const Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(color: AppColors.primary),
                      SizedBox(height: 18),
                      Text('Memproses transaksi…',
                          style: TextStyle(
                            fontFamily: 'PlusJakartaSans',
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: AppColors.slate600,
                          )),
                    ],
                  ),
                ),
              ] else ...[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 10, 24, 24),
                    child: Column(
                      children: [
                        Container(
                          width: 54,
                          height: 54,
                          decoration: BoxDecoration(
                            color: AppColors.primarySurface,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Center(child: Icon(Icons.lock_outline_rounded, size: 26, color: AppColors.primary)),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          widget.flowData['kind'] == 'deeplink_real'
                              ? 'Konfirmasi Pembayaran'
                              : 'Masukkan PIN',
                          style: const TextStyle(
                            fontFamily: 'PlusJakartaSans',
                            fontSize: 21,
                            fontWeight: FontWeight.w800,
                            color: AppColors.ink,
                          )),
                        const SizedBox(height: 6),
                        Text(
                          widget.flowData['kind'] == 'deeplink_real'
                              ? 'Masukkan kode 6 digit dari Google Authenticator'
                              : 'Masukkan 6 digit PIN keamanan kamu',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 13.5, color: AppColors.slate500)),
                        const Spacer(),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 80),
                          transform: _hasError ? (Matrix4.translationValues(10.0, 0, 0)) : Matrix4.identity(),
                          child: PinPad(
                            value: _pin,
                            onChanged: (v) => setState(() => _pin = v),
                            onComplete: _onComplete,
                          ),
                        ),
                        const SizedBox(height: 18),
                        const Text.rich(TextSpan(
                          text: 'Lupa PIN? ',
                          style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 12.5, color: AppColors.slate400),
                          children: [
                            TextSpan(
                              text: 'Reset',
                              style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700),
                            ),
                          ],
                        )),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
