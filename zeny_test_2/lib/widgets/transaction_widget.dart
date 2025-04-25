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
    final int todayTransactionsLenght = localProvider.oneDayTransactions(widget.baseId).length;
    final int transactionId = (widget.baseId*1000)+ widget.index+1;


    if (widget.index < todayTransactionsLenght) {
      
      final transaction = localProvider.oneDayTransactions(widget.baseId)[widget.index];
      bool isDelete = transaction.isDelete;

      //Filled Row
      if(!isDelete){
        return RowWidget(
          children: [
            TransactionFilledWidget(index: widget.index, basedId: widget.baseId, transactionId: transactionId,)
          ],
        );
      } else {
        return SizedBox(height: 0);
      }
    } else if (todayTransactionsLenght == widget.index) {
      //Active Row
      return RowWidget(
        children: [
          TransactionInputWidget(basedId: widget.baseId, transactionId: transactionId,)
        ],
      );
    } else {
      //Empty Row
      return RowWidget(
        children: [
          // Text(transactionId.toString()),
          SizedBox(width: 0)
        ],
      );
    }
  }
}

