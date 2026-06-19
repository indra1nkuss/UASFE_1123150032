import 'package:shared_preferences/shared_preferences.dart';

class BalancePreferencesDataSource {
  static const String _balanceKey = 'app_balance';
  static const double _initialBalance = 250000.0;

  final SharedPreferences _prefs;

  BalancePreferencesDataSource(this._prefs);

  Future<double> getBalance() async {
    return _prefs.getDouble(_balanceKey) ?? _initialBalance;
  }

  Future<void> setBalance(double balance) async {
    await _prefs.setDouble(_balanceKey, balance);
  }

  Future<void> deductBalance(double amount) async {
    final current = await getBalance();
    final newBalance = current - amount;
    await setBalance(newBalance);
  }

  Future<void> addBalance(double amount) async {
    final current = await getBalance();
    final newBalance = current + amount;
    await setBalance(newBalance);
  }

  Future<void> resetBalance() async {
    await setBalance(_initialBalance);
  }
}
