import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeny/utils/local_provider.dart';

class TransactionWidget extends StatefulWidget {
  const TransactionWidget({super.key, required this.index, required this.baseId});

  final int index;
  final int baseId;

  @override
  State<TransactionWidget> createState() => _TransactionWidgetState();
}

class _TransactionWidgetState extends State<TransactionWidget> {
  @override
  Widget build(BuildContext context) {
    final number = widget.index + 1;
    final localProvider = Provider.of<LocalProvider>(context, listen: false);
    int todayTransactionsLenght = localProvider.todayTransactions.length;

    // Check if a transaction exists for the current index
    if (widget.index < todayTransactionsLenght) {
      final transaction = localProvider.todayTransactions[widget.index];
      return Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey, width: 0.5), // Add bottom border
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'ID ${transaction.transactionId}',
                style: const TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '\$${transaction.transactionAmount.toStringAsFixed(2)}', // Display transaction amount
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      );
    } else if (todayTransactionsLenght == widget.index){
      // Clickable state
      return GestureDetector(
        onTap: (){
            // final int transactionId = int.parse('${widget.baseId}${number.toString().padLeft(2, '0')}'); 
            // localProvider.addTransaction(
            //   transactionId: transactionId
            // );
        },
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey, width: 0.5), // Add bottom border
            ),
          ),
          child: TextField(
              decoration: const InputDecoration(
                hintText: '+ Add new expense',
                hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  final int transactionId = int.parse('${widget.baseId}${number.toString().padLeft(2, '0')}');
                  localProvider.addTransaction(
                    transactionId: transactionId,
                    transactionName: value,
                  );
                }
              },
          )
        ),
      );
    } else {
       // Placeholder for empty transactions
      return Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey, width: 0.5), // Add bottom border
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              number.toString(), // Placeholder number
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
        );
    }

  }
}