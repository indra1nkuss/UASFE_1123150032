import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/services/updated_deep_link_handler.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../domain/entities/deeplink_payment_entity.dart';
import '../../../injection/injection_container.dart';
import '../../blocs/payment/payment_bloc.dart';
import '../../widgets/app_button.dart';

class DeepLinkPaymentPage extends StatefulWidget {
  final DeepLinkPaymentEntity paymentData;

  const DeepLinkPaymentPage({
    super.key,
    required this.paymentData,
  });

  @override
  State<DeepLinkPaymentPage> createState() => _DeepLinkPaymentPageState();
}

class _DeepLinkPaymentPageState extends State<DeepLinkPaymentPage> {
  late PaymentBloc _paymentBloc;

  @override
  void initState() {
    super.initState();
    _paymentBloc = sl<PaymentBloc>();
  }

  @override
  void dispose() {
    _paymentBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        title: const Text('Konfirmasi Pembayaran'),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColors.ink),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocProvider.value(
        value: _paymentBloc,
        child: BlocListener<PaymentBloc, PaymentState>(
          listener: (context, state) {
            if (state is DeepLinkPaymentSuccess) {
              _onPaymentSuccess(state);
            } else if (state is PaymentInsufficientBalance) {
              _showErrorSnackBar(
                'Saldo tidak cukup. Saldo Anda: ${CurrencyFormatter.format(state.balance)}',
              );
            } else if (state is PaymentError) {
              _showErrorSnackBar(state.message);
            }
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPaymentInfo(),
                const SizedBox(height: 30),
                _buildPaymentDetails(),
                const SizedBox(height: 30),
                BlocBuilder<PaymentBloc, PaymentState>(
                  builder: (context, state) {
                    return AppButton(
                      label: 'Bayar Sekarang',
                      onPressed: state is PaymentLoading
                          ? null
                          : () => _processPayment(context),
                      isLoading: state is PaymentLoading,
                    );
                  },
                ),
                const SizedBox(height: 12),
                // Tombol batal
                BlocBuilder<PaymentBloc, PaymentState>(
                  builder: (context, state) {
                    return state is PaymentLoading
                        ? const SizedBox.shrink()
                        : TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Center(
                              child: Text(
                                'Batalkan',
                                style: TextStyle(
                                  color: AppColors.slate500,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentInfo() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppColors.shadowSoft,
      ),
      child: Column(
        children: [
          // Icon sumber pembayaran
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.primarySurface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.pedal_bike_rounded, color: AppColors.primary, size: 28),
          ),
          const SizedBox(height: 12),
          const Text(
            'Pembayaran dari',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.slate500,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'RentBike',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: 16),
          Container(height: 1, color: AppColors.line2),
          const SizedBox(height: 16),
          Text(
            CurrencyFormatter.format(widget.paymentData.amount),
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w800,
              color: AppColors.primary,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Total yang akan dibayar',
            style: TextStyle(
              fontSize: 12,
              color: AppColors.slate400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentDetails() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppColors.shadowSoft,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Detail Transaksi',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: 12),
          _buildDetailRow('Nama Bike', widget.paymentData.bikeName),
          const SizedBox(height: 12),
          Container(height: 1, color: AppColors.line2),
          const SizedBox(height: 12),
          _buildDetailRow('ID Transaksi', widget.paymentData.trxId),
          const SizedBox(height: 12),
          Container(height: 1, color: AppColors.line2),
          const SizedBox(height: 12),
          _buildDetailRow('Jumlah', CurrencyFormatter.format(widget.paymentData.amount)),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.slate500,
            fontWeight: FontWeight.w600,
          ),
        ),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.ink,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  void _processPayment(BuildContext context) {
    context.read<PaymentBloc>().add(
          ProcessDeepLinkPaymentEvent(
            trxId: widget.paymentData.trxId,
            amount: widget.paymentData.amount,
            description: 'Sewa Sepeda: ${widget.paymentData.bikeName}',
            sourceApp: widget.paymentData.sourceApp,
            otpCode: '000000', // Dummy OTP
          ),
        );
  }

  void _onPaymentSuccess(DeepLinkPaymentSuccess state) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Pembayaran berhasil! Sisa saldo: ${CurrencyFormatter.format(state.remainingBalance)}',
        ),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );

    // Tunggu snackbar sebentar lalu kembali ke RentBike
    Future.delayed(const Duration(seconds: 2), () async {
      await DeepLinkHandler.returnToRentBike(
        trxId: widget.paymentData.trxId,
        success: true,
      );
      if (mounted) {
        Navigator.pop(context, true);
      }
    });
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
