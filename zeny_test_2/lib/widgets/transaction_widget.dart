import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeny/utils/local_provider.dart';
import 'package:zeny/widgets/field_amount_widget.dart';

class TransactionWidget extends StatefulWidget {
  const TransactionWidget({super.key, required this.index, required this.baseId, required this.onTransactionChanged});

  final int index;
  final int baseId;
  final VoidCallback onTransactionChanged; // Callback to notify parent


  @override
  State<TransactionWidget> createState() => _TransactionWidgetState();
}

class _TransactionWidgetState extends State<TransactionWidget> {
  final TextEditingController _titleController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int number = widget.index + 1;
    final localProvider = Provider.of<LocalProvider>(context, listen: false);
    final int todayTransactionsLenght = localProvider.todayTransactions.length;
    final int transactionId = int.parse('${widget.baseId}${number.toString().padLeft(2, '0')}');

    double transactionNameWidth = 96;

    if (widget.index < todayTransactionsLenght) {
      final transaction = localProvider.todayTransactions[widget.index];
      return Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey, width: 0.5), // Add bottom border
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, top:8.0, bottom: 8.0, right: 8.0),
              child: SizedBox(
                width: transactionNameWidth,
                child: Text(
                  transaction.transactionName,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            FieldAmountWidget(
              index: widget.index,
              onTransactionChanged: () {
                widget.onTransactionChanged();
                setState(() {});
              },
              enabled: true, 
            )
          ],
        ),
      );
    } else if (todayTransactionsLenght == widget.index) {
      return Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey, width: 0.5), // Add bottom border
          ),
        ),
        child: Row(
          children: [
            Focus(
              onFocusChange: (hasFocus) {
                if (!hasFocus) {
                  final value = _titleController.text.trim();
                  print("Name out of focus: $value");
                  if (value.isNotEmpty) {
                    localProvider.initTransaction(
                      transactionId: transactionId,
                      transactionName: value,
                    );
                    _titleController.clear(); // Clear the text field
                    widget.onTransactionChanged(); // Notify the parent
                    setState(() {}); // Refresh the widget
                  }
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                child: SizedBox(
                  width: transactionNameWidth,
                  child: TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      hintText: '+ Expense',
                      hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
        
            Expanded(
              child: FieldAmountWidget(
                index: widget.index,
                onTransactionChanged: () {
                  widget.onTransactionChanged();
                  setState(() {});
                },
                enabled: true, 
              ),
            ),
            // Text('ssss'),
            // SizedBox(
            //   width: 140,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     mainAxisSize: MainAxisSize.min,
            //     children: [
            //       Text(
            //         'Category',
            //         textAlign: TextAlign.end,
            //         overflow: TextOverflow.ellipsis,
            //         style: const TextStyle(fontSize: 16, color: Colors.grey),
            //       ),
            //       const Icon(
            //         Icons.arrow_drop_down, // Down arrow icon
            //         color: Colors.grey,
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      );
    } else {
      return Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey, width: 0.5), // Add bottom border
          ),
        ),
        child: const SizedBox(height: 44),
      );
    }
  }
}