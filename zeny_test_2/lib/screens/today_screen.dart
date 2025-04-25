import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zeny/utils/local_provider.dart';
import 'package:provider/provider.dart';
import 'package:zeny/utils/number.dart';
import 'package:zeny/widgets/transaction_widget.dart';

class TodayScreen extends StatefulWidget {
  const TodayScreen({super.key});

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  @override
  Widget build(BuildContext context) {
    final String todayDate = DateFormat('d MMMM yyyy').format(DateTime.now());
    final int baseId = int.parse(DateFormat('yyyyMMdd').format(DateTime.now()));

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(todayDate),
          actions: [
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                Provider.of<LocalProvider>(context, listen: false).deleteAllTransactions();
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey, width: 0.5), // Add bottom border
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 0, bottom: 24),
                child: Consumer<LocalProvider>(
                  builder: (context, localProvider, child) {
                    // Calculate the total expense dynamically
                    final double totalExpense = localProvider.transactions.fold(
                      0.0,
                      (sum, transaction) => sum + transaction.transactionAmount,
                    );
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Expense: \$${formatNumber(totalExpense)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: Consumer<LocalProvider>(
                builder: (context, localProvider, child) {
                  return ListView.builder(
                    itemCount: 99,
                    itemBuilder: (context, index) {
                      return TransactionWidget(
                        index: index,
                        baseId: baseId,
                      );
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