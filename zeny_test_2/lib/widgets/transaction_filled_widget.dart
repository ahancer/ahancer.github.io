import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeny/utils/local_provider.dart';
import 'package:zeny/utils/number.dart';

class TransactionFilledWidget extends StatelessWidget {
  const TransactionFilledWidget({super.key, required this.index, required this.basedId, required this.transactionId});

  final int index;
  final int basedId;
  final int transactionId;

  @override
  Widget build(BuildContext context) {
    
    final localProvider = Provider.of<LocalProvider>(context, listen: false);
    final transaction = localProvider.oneDayTransactions(basedId)[index];

    double screenWidth = MediaQuery.of(context).size.width;

    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        
        // Title
        SizedBox(
          width: screenWidth * 0.4,
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
            textAlign: TextAlign.start,
            formatNumber(transaction.transactionAmount),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 16),
          ),
        ),

        //Category
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () async {
            // Show a confirmation dialog
            final bool? confirmDelete = await showDialog<bool>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Confirm Delete'),
                  content: const Text('Are you sure you want to delete?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(false); // User cancels the action
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(true); // User confirms the action
                      },
                      child: const Text('Delete'),
                    ),
                  ],
                );
              },
            );

            // If the user confirms, delete the transaction
            if (confirmDelete == true) {
              await localProvider.deleteTransactionById(transactionId);
            }
          },
          child: SizedBox(
            width: screenWidth * 0.3,
            child: Padding(
              padding: const EdgeInsets.only(right:12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    textAlign: TextAlign.end,
                    transaction.transactionCategory,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 16),
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: const Icon(
                      Icons.cancel,
                      color: Colors.grey,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        
      ]
    );
  }
}