import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:transaction_management_app/business/model/transactionmodel.dart';

class TransactionService {
  final String baseUrl = 'https://infra.devskills.app/api/transaction-management';

  Future<List<Transactions>> getTransactions() async {
    final response = await http.get(Uri.parse('$baseUrl/transactions'));
    if (response.statusCode == 200) {
      // Parse the response body
      return (json.decode(response.body) as List)
          .map((data) => Transactions.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load transactions');
    }
  }
 static Future<void> createTransaction(accountId, amount) async {
  final Map databody = {
    'account_id': accountId,
    'amount': amount.toString(),
  };
  

  final response = await http.post(
    Uri.parse('https://infra.devskills.app/api/transaction-management/transactions'),
    headers: {
      "Content-Type": "application/json",// Correct content type for JSON
    },
    body: databody);


  if (response.statusCode != 200) {
    throw Exception('Failed to create transaction: ${response.body}');
  }
}
}
