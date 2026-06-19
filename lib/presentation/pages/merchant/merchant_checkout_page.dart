import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/services/updated_deep_link_handler.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../domain/entities/deeplink_payment_entity.dart';
import '../../blocs/account/account_bloc.dart';
import '../../blocs/payment/payment_bloc.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_logo.dart';

const _orange = Color(0xFFFF6A2B);

class MerchantCheckoutPage extends StatefulWidget {
  /// Jika [paymentData] tidak null, page ini diisi dari deep link RentBike.
  /// Jika null, tampilkan contoh order statis (dibuka dari banner).
  final DeepLinkPaymentEntity? paymentData;
  const MerchantCheckoutPage({super.key, this.paymentData});

  @override
  State<MerchantCheckoutPage> createState() => _MerchantCheckoutPageState();
}

class _MerchantCheckoutPageState extends State<MerchantCheckoutPage> {
  bool _isFromRentBike = false;
  List<Map<String, dynamic>> _items = [];
  double _total = 0;
  String _orderId = '';
  String _merchantName = 'TokoBelanja';

  @override
  void initState() {
    super.initState();
    final pd = widget.paymentData;
    if (pd != null) {
      // Data dari deep link RentBike
      _isFromRentBike = true;
      _orderId = pd.trxId;
      _merchantName = pd.bikeName;
      if (pd.itemsJson != null && pd.itemsJson!.isNotEmpty) {
        try {
          final List<dynamic> decoded = jsonDecode(pd.itemsJson!);
          _items = decoded.map((e) => {
            'name': e['name'],
            'qty': e['qty'],
            'price': (e['price'] as num).toDouble(),
          }).toList();
        } catch (e) {
          _items = [
            {'name': 'Sewa Sepeda', 'qty': 1, 'price': pd.amount},
          ];
        }
      } else {
        _items = [
          {'name': 'Sewa Sepeda', 'qty': 1, 'price': pd.amount},
        ];
      }
      _total = pd.amount;
    } else {
      // Contoh statis (dibuka dari banner home) disimulasikan sebagai RentBike
      _isFromRentBike = true;
      _orderId = 'RB-DUMMY-${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}';
      _merchantName = 'RentBike';
      _items = [
        {'name': 'Sewa Sepeda Listrik (2 Jam)', 'qty': 1, 'price': 50000.0},
        {'name': 'Helm Pengaman (Opsional)', 'qty': 1, 'price': 15000.0},
      ];
      final subtotal = _items.fold(0.0, (s, i) => s + (i['price'] as double) * (i['qty'] as int));
      _total = subtotal; // Gratis ongkir untuk sewa sepeda
    }

    // Trigger ambil saldo terbaru
    context.read<AccountBloc>().add(AccountLoadRequested());
  }

  @override
  Widget build(BuildContext context) {
    final subtotal = _items.fold(
        0.0, (s, i) => s + (i['price'] as double) * (i['qty'] as int));
    final double ship = _isFromRentBike ? 0 : 12000.0;
    final double total = _isFromRentBike ? _total : subtotal + ship;

    return BlocListener<PaymentBloc, PaymentState>(
      listener: (context, state) {
        if (state is PaymentInsufficientBalance) {
          _showError(
            'Saldo tidak cukup. Saldo Anda: ${CurrencyFormatter.format(state.balance)}',
          );
        } else if (state is PaymentError) {
          _showError(state.message);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.bg,
        body: Column(
          children: [
            // Header
            Container(
              color: _isFromRentBike ? AppColors.primary : _orange,
              padding: EdgeInsets.fromLTRB(
                  16, MediaQuery.of(context).padding.top + 6, 16, 14),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_rounded,
                        color: Colors.white, size: 20),
                    onPressed: () => context.go('/home'),
                  ),
                  const Expanded(
                    child: Text('Konfirmasi Pembayaran',
                        style: TextStyle(
                          fontFamily: 'PlusJakartaSans',
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 17,
                        )),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          _isFromRentBike
                              ? Icons.pedal_bike_rounded
                              : Icons.storefront_outlined,
                          size: 14,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 6),
                        Text(_merchantName,
                            style: const TextStyle(
                              fontFamily: 'PlusJakartaSans',
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Body
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 20),
                child: Column(
                  children: [
                    // Order items
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: AppColors.shadowSoft,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text('Pesanan #$_orderId',
                                style: const TextStyle(
                                  fontFamily: 'PlusJakartaSans',
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.slate400,
                                )),
                          ),
                          ..._items.asMap().entries.map((e) {
                            final i = e.key;
                            final item = e.value;
                            return Column(
                              children: [
                                if (i > 0)
                                  const Divider(
                                      height: 1, color: AppColors.line2),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 11),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 46,
                                        height: 46,
                                        decoration: BoxDecoration(
                                          color: _isFromRentBike
                                              ? AppColors.primarySurface
                                              : const Color(0xFFFFF1E9),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Center(
                                          child: Icon(
                                            _isFromRentBike
                                                ? Icons.pedal_bike_rounded
                                                : Icons.shopping_bag_outlined,
                                            size: 22,
                                            color: _isFromRentBike
                                                ? AppColors.primary
                                                : _orange,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(item['name'] as String,
                                                maxLines: 2,
                                                overflow:
                                                    TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontFamily:
                                                      'PlusJakartaSans',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColors.ink,
                                                )),
                                            Text(
                                                '${item['qty']} × ${CurrencyFormatter.format(item['price'] as double)}',
                                                style: const TextStyle(
                                                    fontSize: 12.5,
                                                    color:
                                                        AppColors.slate400)),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        CurrencyFormatter.format(
                                            (item['price'] as double) *
                                                (item['qty'] as int)),
                                        style: const TextStyle(
                                          fontFamily: 'PlusJakartaSans',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w800,
                                          color: AppColors.ink,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }),
                        ],
                      ),
                    ),

                    const SizedBox(height: 14),

                    // Payment Method
                    const Padding(
                      padding: EdgeInsets.only(left: 4, bottom: 8),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Metode pembayaran',
                            style: TextStyle(
                              fontFamily: 'PlusJakartaSans',
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: AppColors.slate400,
                            )),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: AppColors.shadowSoft,
                        border:
                            Border.all(color: AppColors.primaryLight, width: 1.8),
                      ),
                      child: Row(
                        children: [
                          const AppLogo(size: 40),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Dompet Kampus Global',
                                    style: TextStyle(
                                      fontFamily: 'PlusJakartaSans',
                                      fontSize: 14.5,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.ink,
                                    )),
                                BlocBuilder<AccountBloc, AccountState>(
                                  builder: (context, state) {
                                    if (state is AccountLoading) {
                                      return const Text('Memuat saldo...',
                                          style: TextStyle(
                                              fontSize: 12.5,
                                              color: AppColors.slate400));
                                    } else if (state is AccountLoaded) {
                                      return Text(
                                          'Saldo: ${CurrencyFormatter.format(state.account.balance)}',
                                          style: TextStyle(
                                              fontSize: 12.5,
                                              fontWeight: FontWeight.w600,
                                              color: state.account.balance >= total
                                                  ? AppColors.primary
                                                  : Colors.red));
                                    }
                                    return const Text('Saldo · pembayaran instan',
                                        style: TextStyle(
                                            fontSize: 12.5,
                                            color: AppColors.slate400));
                                  },
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.check_rounded,
                              size: 20, color: AppColors.primary),
                        ],
                      ),
                    ),

                    const SizedBox(height: 14),

                    // Totals
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: AppColors.shadowSoft,
                      ),
                      child: Column(
                        children: [
                          _TotalLine(
                              label: 'Subtotal',
                              value: CurrencyFormatter.format(subtotal)),
                    if (!_isFromRentBike) ...[
                            const Divider(height: 1, color: AppColors.line2),
                            const _TotalLine(
                                label: 'Ongkos kirim',
                                value: 'Rp 12.000'),
                          ],
                          const Divider(height: 1, color: AppColors.line2),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(vertical: 12),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Total',
                                    style: TextStyle(
                                      fontFamily: 'PlusJakartaSans',
                                      fontSize: 15.5,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.slate600,
                                    )),
                                Text(
                                  CurrencyFormatter.format(total),
                                  style: TextStyle(
                                    fontFamily: 'PlusJakartaSans',
                                    fontSize: 15.5,
                                    fontWeight: FontWeight.w800,
                                    color: _isFromRentBike
                                        ? AppColors.primary
                                        : _orange,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Pay Bar
            Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(
                  16, 12, 16, MediaQuery.of(context).padding.bottom + 16),
              child: BlocBuilder<AccountBloc, AccountState>(
                builder: (context, accountState) {
                  final balance = accountState is AccountLoaded ? accountState.account.balance : 0.0;
                  // Abaikan validasi saldo khusus untuk demo RentBike
                  final isInsufficient = !_isFromRentBike && accountState is AccountLoaded && balance < total;

                  return BlocBuilder<PaymentBloc, PaymentState>(
                    builder: (context, state) {
                      return AppButton(
                        label: state is PaymentLoading
                            ? 'Memproses...'
                            : isInsufficient
                                ? 'Saldo Tidak Cukup'
                                : 'Bayar ${CurrencyFormatter.format(total)}',
                        onPressed: (state is PaymentLoading || isInsufficient)
                            ? null
                            : () => _onBayar(context),
                        isLoading: state is PaymentLoading,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onBayar(BuildContext context) {
    if (_isFromRentBike) {
      context.go('/pin', extra: {
        'kind': 'deeplink_real',
        'trxId': _orderId,
        'description': 'Sewa Sepeda: $_merchantName',
        'amount': _total,
        'sourceApp': widget.paymentData?.sourceApp ?? 'rentbike',
      });
    } else {
      // Flow statis: ke halaman PIN
      context.go('/pin', extra: {
        'kind': 'deeplink_dummy',
        'description': '$_merchantName #$_orderId',
        'amount': _total,
      });
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}

class _TotalLine extends StatelessWidget {
  final String label;
  final String value;
  const _TotalLine({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 11),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.slate500,
                  fontFamily: 'PlusJakartaSans')),
          Text(value,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.ink,
                  fontFamily: 'PlusJakartaSans')),
        ],
      ),
    );
  }
}
