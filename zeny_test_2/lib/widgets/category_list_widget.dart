import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeny/utils/local_provider.dart';

class CategoryListWidget extends StatelessWidget {
  const CategoryListWidget({super.key, required this.transactionId, required this.transactionName, required this.transactionAmount, required this.transactionDate});

  final int transactionId;
  final String transactionName;
  final double transactionAmount;
  final int transactionDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Select Category',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ListView(
            shrinkWrap: true,
            children: [
              CategoryListItemWidget(
                categoryTitle: 'Food',
                transactionId: transactionId,
                transactionName: transactionName,
                transactionAmount: transactionAmount,
                transactionDate: transactionDate,
              ),
              CategoryListItemWidget(
                categoryTitle: 'Transport',
                transactionId: transactionId,
                transactionName: transactionName,
                transactionAmount: transactionAmount,
                transactionDate: transactionDate,
              ),
              CategoryListItemWidget(
                categoryTitle: 'Shopping',
                transactionId: transactionId,
                transactionName: transactionName,
                transactionAmount: transactionAmount,
                transactionDate: transactionDate,
              ),
              CategoryListItemWidget(
                categoryTitle: 'Gift',
                transactionId: transactionId,
                transactionName: transactionName,
                transactionAmount: transactionAmount,
                transactionDate: transactionDate,
              ),
              CategoryListItemWidget(
                categoryTitle: 'Other',
                transactionId: transactionId,
                transactionName: transactionName,
                transactionAmount: transactionAmount,
                transactionDate: transactionDate,
              ),
            ],
          ),
        ],
      ),
    );
  }
}


class CategoryListItemWidget extends StatelessWidget {
  const CategoryListItemWidget({
    super.key, required this.categoryTitle, required this.transactionId, required this.transactionName, required this.transactionAmount, required this.transactionDate,
  });

  final String categoryTitle;
  final int transactionId;
  final String transactionName;
  final double transactionAmount;
  final int transactionDate;

  @override
  Widget build(BuildContext context) {
    final localProvider = Provider.of<LocalProvider>(context, listen: false);

    return ListTile(
      title: Text(categoryTitle),
      onTap: () {
        localProvider.initTransaction(
          transactionId: transactionId,
          transactionName: transactionName,
          transactionAmount: transactionAmount,
          transactionCategory: categoryTitle,
          transactionDate: transactionDate,
        );
        Navigator.pop(context);
      },
    );
  }
}