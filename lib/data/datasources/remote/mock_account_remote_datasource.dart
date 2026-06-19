import '../../models/account_model.dart';
import '../../models/transaction_model.dart';
import '../../../domain/entities/transaction_entity.dart';

abstract class AccountRemoteDatasource {
  Future<AccountModel> getAccount();
  Future<List<TransactionModel>> getTransactions();
}

class MockAccountRemoteDatasourceImpl implements AccountRemoteDatasource {
  @override
  Future<AccountModel> getAccount() async {
    await Future.delayed(const Duration(milliseconds: 600));

    return AccountModel(
      id: 1,
      userId: 1,
      balance: 250000.0,
      createdAt: DateTime(2024, 1, 15),
    );
  }

  @override
  Future<List<TransactionModel>> getTransactions() async {
    await Future.delayed(const Duration(milliseconds: 800));

    final now = DateTime.now();
    return [
      TransactionModel(
        id: 5,
        accountId: 1,
        amount: 50000,
        type: TransactionType.debit,
        description: 'Transfer ke Budi',
        balanceBefore: 300000,
        balanceAfter: 250000,
        createdAt: now.subtract(const Duration(hours: 2)),
      ),
      TransactionModel(
        id: 4,
        accountId: 1,
        amount: 100000,
        type: TransactionType.credit,
        description: 'Top-up bank transfer',
        balanceBefore: 200000,
        balanceAfter: 300000,
        createdAt: now.subtract(const Duration(days: 1)),
      ),
      TransactionModel(
        id: 3,
        accountId: 1,
        amount: 25000,
        type: TransactionType.debit,
        description: 'Bayar kantin',
        balanceBefore: 225000,
        balanceAfter: 200000,
        createdAt: now.subtract(const Duration(days: 2)),
      ),
      TransactionModel(
        id: 2,
        accountId: 1,
        amount: 500000,
        type: TransactionType.credit,
        description: 'Terima transfer dari Ayah',
        balanceBefore: -275000,
        balanceAfter: 225000,
        createdAt: now.subtract(const Duration(days: 3)),
      ),
    ];
  }
}
