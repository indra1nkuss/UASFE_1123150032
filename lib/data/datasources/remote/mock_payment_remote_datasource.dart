import '../../../domain/entities/payment_result_entity.dart';

abstract class PaymentRemoteDatasource {
  Future<({double balance, double amount})> topup(double amount);
  Future<TransferResultEntity> transfer({
    required double amount,
    required String description,
    required String otpCode,
    required String otpType,
  });
}

class MockPaymentRemoteDatasourceImpl implements PaymentRemoteDatasource {
  @override
  Future<({double balance, double amount})> topup(double amount) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    return (balance: 250000 + amount, amount: amount);
  }

  @override
  Future<TransferResultEntity> transfer({
    required double amount,
    required String description,
    required String otpCode,
    required String otpType,
  }) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    // Auto-approve transfer with any OTP code for mock

    return TransferResultEntity(
      transactionId: DateTime.now().millisecondsSinceEpoch,
      amount: amount,
      description: description,
      balanceBefore: 250000,
      balanceAfter: 250000 - amount,
      createdAt: DateTime.now(),
    );
  }
}
