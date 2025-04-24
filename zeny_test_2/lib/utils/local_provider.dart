import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:zeny/models/model_local.dart';
import 'dart:math'; 

class LocalProvider with ChangeNotifier {
  // Get the Hive box
  final Box<LocalModel> localBox = Hive.box<LocalModel>('local_box');

  // Getter to retrieve all transactions
  List<LocalModel> get transactions {
    return localBox.values.toList();
  }

  void addTransaction({required int transactionId}) {
    final random = Random();
    final tempTransaction = LocalModel(
      transactionId: transactionId,
      transactionDate: (DateTime.now().millisecondsSinceEpoch / 1000).round(), // UNIX timestamp in seconds
      transactionType: 'Expense', // Example type
      transactionAmount: random.nextDouble() * 99 + 1, // Random value between 1.00 and 100.00
      transactionCategory: 'Food', // Example category
      transactionCurrency: 'USD', // Example currency
    );

    localBox.add(tempTransaction);

    notifyListeners();
  }

  void deleteAllTransactions() {
    localBox.clear(); // Clears all data in the box
    notifyListeners(); 
  }
}
