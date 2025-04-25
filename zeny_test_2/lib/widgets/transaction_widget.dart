import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeny/utils/local_provider.dart';
import 'package:zeny/widgets/row_widget.dart';
import 'package:zeny/widgets/transaction_filled_widget.dart';
import 'package:zeny/widgets/transaction_input_widget.dart';

class TransactionWidget extends StatefulWidget {
  const TransactionWidget({super.key, required this.index, required this.baseId});

  final int index;
  final int baseId;

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
    final localProvider = Provider.of<LocalProvider>(context, listen: false);
    final int todayTransactionsLenght = localProvider.todayTransactions.length;


    if (widget.index < todayTransactionsLenght) {
      //Filled Row
      return RowWidget(
        children: [
          TransactionFilledWidget(index: widget.index)
        ],
      );
    } else if (todayTransactionsLenght == widget.index) {
      //Active Row
      return RowWidget(
        children: [
          TransactionInputWidget()
        ],
      );
    } else {
      //Empty Row
      return RowWidget(
        children: [
          SizedBox(width: 0)
        ],
      );
    }
  }
}

