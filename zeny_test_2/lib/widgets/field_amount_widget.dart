import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeny/utils/local_provider.dart';

class FieldAmountWidget extends StatefulWidget {
  const FieldAmountWidget({super.key, required this.index, required this.onTransactionChanged, required this.enabled});

  final int index;
  final VoidCallback onTransactionChanged; // Callback to notify parent
  final bool enabled;
  

  @override
  State<FieldAmountWidget> createState() => _FieldAmountWidgetState();
}

class _FieldAmountWidgetState extends State<FieldAmountWidget> {
  final TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final localProvider = Provider.of<LocalProvider>(context, listen: false);
    if (widget.index < localProvider.todayTransactions.length) {
      final transaction = localProvider.todayTransactions[widget.index];
      _amountController.text = transaction.transactionAmount == 0.00
          ? '' // Leave empty if amount is 0.00
          : transaction.transactionAmount.toStringAsFixed(2); // Show value otherwise
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localProvider = Provider.of<LocalProvider>(context, listen: false);

    return Focus(
      onFocusChange: (hasFocus) {
        if (!hasFocus) {
          // Retrieve the value from the persistent controller
          final transaction = localProvider.todayTransactions[widget.index];
          final value = _amountController.text.trim();
          print("Amount out of focus: $value");
          final newAmount = double.tryParse(value);
          if (newAmount != null) {
            localProvider.updateTransactionAmount(
              transactionId: transaction.transactionId,
              newAmount: newAmount,
            );
            widget.onTransactionChanged(); // Notify the parent
            setState(() {}); // Refresh the widget
          }
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: SizedBox(
          width: 120,
          child: TextField(
            controller: _amountController,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: '0.00',
              hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            keyboardType: TextInputType.numberWithOptions(decimal: true), // Explicitly allow decimals
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}