import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/transaction_model.dart';

class TransactionViewModel extends ChangeNotifier {
  List<TransactionModel> _transactions = [];
  static const String _prefsKey = 'transactions_list';

  List<TransactionModel> get transactions => _transactions;

  TransactionViewModel() {
    _loadTransactionsFromPrefs();
  }

  double get totalBalance {
    return totalIncome - totalExpense;
  }

  double get totalIncome {
    return _transactions
        .where((t) => t.type == TransactionType.income)
        .fold(0.0, (sum, item) => sum + item.amount);
  }

  double get totalExpense {
    return _transactions
        .where((t) => t.type == TransactionType.expense)
        .fold(0.0, (sum, item) => sum + item.amount);
  }

  void addTransaction(TransactionModel transaction) {
    _transactions.add(transaction);
    _saveTransactionsToPrefs();
    notifyListeners();
  }

  void deleteTransaction(String id) {
    _transactions.removeWhere((t) => t.id == id);
    _saveTransactionsToPrefs();
    notifyListeners();
  }

  Future<void> _loadTransactionsFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final String? transactionsString = prefs.getString(_prefsKey);
    if (transactionsString != null) {
      final List<dynamic> decodedList = json.decode(transactionsString);
      _transactions = decodedList
          .map((item) => TransactionModel.fromMap(item))
          .toList();
      notifyListeners();
    }
  }

  Future<void> _saveTransactionsToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedList = json.encode(
      _transactions.map((t) => t.toMap()).toList(),
    );
    await prefs.setString(_prefsKey, encodedList);
  }
}
