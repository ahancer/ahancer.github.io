import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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

  double getTotalExpenseByDate(int date) {
    return transactions
        .where((transaction) => transaction.transactionDate == date && !transaction.isDelete) // Filter by date and exclude deleted transactions
        .fold(0.0, (sum, transaction) => sum + transaction.transactionAmount); // Sum up the amounts
  }

  initTransaction({required int transactionId, required String transactionName, required double transactionAmount, required String transactionCategory, required int transactionDate}) {
    final tempTransaction = LocalModel(
      transactionId: transactionId,
      transactionName: transactionName,
      transactionDate: transactionDate,
      transactionType: 'Expense', // Fix at expense for now
      transactionAmount: transactionAmount, 
      transactionCategory: transactionCategory,
      transactionCurrency: 'USD', // Fix at USD at first
      isDelete: false,
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
        isDelete: false,
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

    final currentTransaction = localBox.get(key);

    if (currentTransaction != null) {
      // Update the isDelete field to true
      final updatedTransaction = LocalModel(
        transactionId: currentTransaction.transactionId,
        transactionName: currentTransaction.transactionName,
        transactionDate: currentTransaction.transactionDate,
        transactionType: currentTransaction.transactionType,
        transactionAmount: 0,
        transactionCategory: 'Deleted',
        transactionCurrency: currentTransaction.transactionCurrency,
        isDelete: true, // Mark the transaction as deleted
      );

      // Save the updated transaction back to the box
      await localBox.put(key, updatedTransaction);
      notifyListeners(); // Notify listeners about the change
    }
  }


  void deleteAllTransactions() {
    localBox.clear(); // Clears all data in the box
    notifyListeners(); 
  }


  bool _isTitleFocused = false;
  bool _isAmountFocused = false;

  bool get isTitleFocused => _isTitleFocused;
  bool get isAmountFocused => _isAmountFocused;

  void setTitleFocus(bool isFocused) {
    _isTitleFocused = isFocused;
    print('Title Focus: $_isTitleFocused');
    notifyListeners();
  }

  void setAmountFocus(bool isFocused) {
    _isAmountFocused = isFocused;
    print('Amount Focus: $_isAmountFocused');
    notifyListeners();
  }


  // Controllers
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  // Focus Nodes
  final FocusNode titleFocusNode = FocusNode();
  final FocusNode amountFocusNode = FocusNode();

  // Dispose resources
  void disposeResources() {
    titleController.dispose();
    amountController.dispose();
    titleFocusNode.dispose();
    amountFocusNode.dispose();
  }

  // Temporary transaction ID
  int? _tempTransactionId;

  int? get tempTransactionId => _tempTransactionId;

  setTempTransactionId(int transactionId) async {
    _tempTransactionId = transactionId;
    print('Set Temp ID to: $transactionId');
    notifyListeners(); // Notify listeners about the change
  }

  void clearTempTransactionId() {
    _tempTransactionId = null;
    notifyListeners(); // Notify listeners about the change
  }

}
