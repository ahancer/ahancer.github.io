import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zeny/utils/local_provider.dart';
import 'package:provider/provider.dart';
import 'package:zeny/widgets/transaction_widget.dart';

class TodayScreen extends StatefulWidget {
  const TodayScreen({super.key});

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {

  @override
  Widget build(BuildContext context) {
    final localProvider = Provider.of<LocalProvider>(context, listen: false);
    final String todayDate = DateFormat('d MMMM yyyy').format(DateTime.now());
    final int baseId = int.parse(DateFormat('yyyyMMdd').format(DateTime.now()));

    // Calculate the total expense
    final double totalExpense = localProvider.transactions.fold(
      0.0,
      (sum, transaction) => sum + transaction.transactionAmount,
    );

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(todayDate),
          actions: [
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                localProvider.deleteAllTransactions();
                setState(() {}); // Refresh the screen after deletion
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Total Expense: \$${totalExpense.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 99, // Keep the list at 99 items
                itemBuilder: (context, index) {                  
                  return TransactionWidget(
                    index: index,
                    baseId: baseId,
                    onTransactionChanged: () {
                      setState(() {}); // Refresh when there is changed
                    },
                  );
                },
              ),
            ),
    
          ],
        ),
      ),
    );
  }
}