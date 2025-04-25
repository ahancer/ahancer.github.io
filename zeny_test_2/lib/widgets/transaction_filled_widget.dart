import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeny/utils/local_provider.dart';

class TransactionFilledWidget extends StatelessWidget {
  const TransactionFilledWidget({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    
    final localProvider = Provider.of<LocalProvider>(context, listen: false);
    final transaction = localProvider.todayTransactions[index];

    double screenWidth = MediaQuery.of(context).size.width;

    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        
        // Title
        SizedBox(
          width: screenWidth * 0.3,
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text(
              transaction.transactionName,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),

        // Title
        SizedBox(
          width: screenWidth * 0.3,
          child: Text(
            textAlign: TextAlign.end,
            transaction.transactionAmount.toStringAsFixed(2),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 16),
          ),
        ),

        //Category
        SizedBox(
          width: screenWidth * 0.4,
          child: Padding(
            padding: const EdgeInsets.only(right:16.0),
            child: Text(
              textAlign: TextAlign.end,
              transaction.transactionCategory,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
        
      ]
    );
  }
}