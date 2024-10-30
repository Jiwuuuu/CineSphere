import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LocalStorageService {
  static const _transactionsKey = 'transactions';

  Future<List<Map<String, dynamic>>> getAllTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final String? transactionsJson = prefs.getString(_transactionsKey);
    if (transactionsJson == null) return [];
    return List<Map<String, dynamic>>.from(json.decode(transactionsJson));
  }

  Future<void> storeTransaction(Map<String, dynamic> transaction) async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> transactions = await getAllTransactions();

    // Set the unique_code as the local transaction_id
    transaction['unique_code'] = transaction['transaction_id'];

    transactions.add(transaction);
    await prefs.setString(_transactionsKey, json.encode(transactions));
  }

  Future<void> deleteTransaction(String uniqueCode) async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> transactions = await getAllTransactions();
    transactions.removeWhere((transaction) => transaction['unique_code'] == uniqueCode);
    await prefs.setString(_transactionsKey, json.encode(transactions));
  }

  Future<void> clearAllTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_transactionsKey);
  }
}