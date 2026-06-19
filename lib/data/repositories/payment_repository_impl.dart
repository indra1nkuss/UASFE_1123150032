import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/payment_result_entity.dart';
import '../../domain/repositories/payment_repository.dart';
import '../datasources/local/balance_preferences_datasource.dart';
import '../datasources/remote/payment_remote_datasource.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentRemoteDatasource _remote;
  final BalancePreferencesDataSource _balanceLocal;

  PaymentRepositoryImpl(this._remote, this._balanceLocal);

  @override
  Future<({double balance, double amount})> topup(double amount) async {
    try {
      return await _remote.topup(amount);
    } on InvalidOtpException catch (e) {
      throw InvalidOtpFailure(e.message);
    } on InsufficientBalanceException catch (e) {
      throw InsufficientBalanceFailure(
        balance: e.balance ?? 0,
        amount: e.amount ?? 0,
        message: e.message,
      );
    } on ServerException catch (e) {
      throw ServerFailure(e.message, errorCode: e.errorCode, statusCode: e.statusCode);
    } on NetworkException catch (e) {
      throw NetworkFailure(e.message);
    }
  }

  @override
  Future<TransferResultEntity> transfer({
    required double amount,
    required String description,
    required String otpCode,
    required String otpType,
  }) async {
    try {
      return await _remote.transfer(
        amount: amount,
        description: description,
        otpCode: otpCode,
        otpType: otpType,
      );
    } on InvalidOtpException catch (e) {
      throw InvalidOtpFailure(e.message);
    } on InsufficientBalanceException catch (e) {
      throw InsufficientBalanceFailure(
        balance: e.balance ?? 0,
        amount: e.amount ?? 0,
        message: e.message,
      );
    } on ServerException catch (e) {
      throw ServerFailure(e.message, errorCode: e.errorCode, statusCode: e.statusCode);
    } on NetworkException catch (e) {
      throw NetworkFailure(e.message);
    }
  }

  /// Memotong saldo via API transfer backend untuk pembayaran Deep Link RentBike.
  @override
  Future<double> deductBalance({
    required String trxId,
    required double amount,
    required String description,
    required String otpCode,
  }) async {
    try {
      final result = await _remote.transferForDeepLink(
        amount: amount,
        description: '$description (TRX: $trxId)',
        otpCode: otpCode,
      );
      return result.balanceAfter;
    } on InvalidOtpException catch (e) {
      throw InvalidOtpFailure(e.message);
    } on InsufficientBalanceException catch (e) {
      throw InsufficientBalanceFailure(
        balance: e.balance ?? 0,
        amount: e.amount ?? 0,
        message: e.message,
      );
    } on ServerException catch (e) {
      throw ServerFailure(e.message, errorCode: e.errorCode, statusCode: e.statusCode);
    } on NetworkException catch (e) {
      throw NetworkFailure(e.message);
    }
  }
}
