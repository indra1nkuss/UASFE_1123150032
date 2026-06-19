import '../entities/payment_result_entity.dart';

abstract class PaymentRepository {
  Future<({double balance, double amount})> topup(double amount);

  Future<TransferResultEntity> transfer({
    required double amount,
    required String description,
    required String otpCode,
    required String otpType,
  });

  /// Memotong saldo lokal (SharedPreferences) untuk pembayaran Deep Link.
  /// Mengembalikan saldo tersisa setelah pemotongan.
  Future<double> deductBalance({
    required String trxId,
    required double amount,
    required String description,
    required String otpCode,
  });
}
