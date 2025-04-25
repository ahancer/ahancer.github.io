import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:zeny/models/model_local.dart';

class LocalProvider with ChangeNotifier {
  // Get the Hive box
  final Box<LocalModel> localBox = Hive.box<LocalModel>('local_box');

  // Getter to retrieve all transactions
  List<LocalModel> get transactions {
    return localBox.values.toList();
  }

  // Getter to retrieve transactions for today
  List<LocalModel> oneDayTransactions(int date) {
    return transactions.where((transaction) {
      return transaction.transactionDate == date;
    }).toList();
  }


  double get getTotalExpense {
    return transactions.fold(
      0.0,
      (sum, transaction) => sum + transaction.transactionAmount,
    );
  }

  double getCategoryExpense(String transactionCategory) {
    return transactions
        .where((transaction) => transaction.transactionCategory == transactionCategory)
        .fold(0.0, (sum, transaction) => sum + transaction.transactionAmount);
  }

  void initTransaction({required int transactionId, required String transactionName, required double transactionAmount, required String transactionCategory, required int transactionDate}) {
    final tempTransaction = LocalModel(
      transactionId: transactionId,
      transactionName: transactionName,
      transactionDate: transactionDate,
      transactionType: 'Expense', // Fix at expense for now
      transactionAmount: transactionAmount, 
      transactionCategory: transactionCategory,
      transactionCurrency: 'USD', // Fix at USD at first
    );

    localBox.add(tempTransaction);

    notifyListeners();
  }


  Future<void> updateTransactionAmount({required int transactionId, required double newAmount}) async {
    
    // Find the key for the transaction with the given transactionId
    final key = localBox.keys.firstWhere(
      (k) => localBox.get(k)?.transactionId == transactionId,
      orElse: () => null,
    );

    final currentTransaction = localBox.get(key);

      if (currentTransaction != null) {
        // Update the transaction amount
        final updatedTransaction = LocalModel(
        transactionId: currentTransaction.transactionId,
        transactionName: currentTransaction.transactionName,
        transactionDate: currentTransaction.transactionDate,
        transactionType: currentTransaction.transactionType,
        transactionAmount: newAmount, // Update the amount
        transactionCategory: currentTransaction.transactionCategory,
        transactionCurrency: currentTransaction.transactionCurrency,
      );

      // Save the updated transaction back to the box
      await localBox.put(key, updatedTransaction);
    }

    notifyListeners(); 
  }

  Future<void> deleteTransactionById(int transactionId) async {
    // Find the key for the transaction with the given transactionId
    final key = localBox.keys.firstWhere(
      (k) => localBox.get(k)?.transactionId == transactionId,
      orElse: () => null,
    );

    if (key != null) {
      // Delete the transaction from the box
      await localBox.delete(key);
      notifyListeners(); // Notify listeners about the change
    }
  }


  void deleteAllTransactions() {
    localBox.clear(); // Clears all data in the box
    notifyListeners(); 
  }
}
