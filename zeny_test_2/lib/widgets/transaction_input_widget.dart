import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeny/utils/local_provider.dart';

class TransactionInputWidget extends StatefulWidget {
  const TransactionInputWidget({super.key});

  @override
  State<TransactionInputWidget> createState() => _TransactionInputWidgetState();
}

class _TransactionInputWidgetState extends State<TransactionInputWidget> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final FocusNode _titleFocusNode = FocusNode(); // FocusNode for title field
  final FocusNode _amountFocusNode = FocusNode(); // FocusNode for amount field

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _titleFocusNode.dispose(); // Dispose the FocusNode
    _amountFocusNode.dispose(); // Dispose the FocusNode
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Title TextField
        SizedBox(
          width: screenWidth * 0.3,
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: TextField(
              controller: _titleController,
              focusNode: _titleFocusNode, // Attach the FocusNode
              decoration: const InputDecoration(
                hintText: '+ Expense',
                hintStyle: TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.normal),
                border: InputBorder.none,
              ),
              onEditingComplete: () {
                _titleFocusNode.unfocus(); // Close the keyboard when editing is complete
              },
            ),
          ),
        ),

        // Amount TextField
        SizedBox(
          width: screenWidth * 0.3,
          child: TextField(
            controller: _amountController,
            focusNode: _amountFocusNode, // Attach the FocusNode
            textAlign: TextAlign.end,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: '0.00',
              hintStyle: TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.normal),
            ),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            style: const TextStyle(fontSize: 16),
            onEditingComplete: () {
              _amountFocusNode.unfocus(); // Close the keyboard when editing is complete
            },
          ),
        ),

        // Category Selector
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                String transactionName = _titleController.text.trim().isNotEmpty
                    ? _titleController.text.trim()
                    : 'Expense';
                double transactionAmount = double.tryParse(_amountController.text.trim()) ?? 0.00;

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
                            transactionId: 10001, // TODO: Change later
                            transactionName: transactionName,
                            transactionAmount: transactionAmount,
                          ),
                          //Transportation, Shopping, Gift, Other

                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: SizedBox(
            width: screenWidth * 0.4,
            child: Padding(
              padding: const EdgeInsets.only(top: 5, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Category',
                    textAlign: TextAlign.end,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const Icon(
                    Icons.arrow_drop_down, // Down arrow icon
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CategoryListItemWidget extends StatelessWidget {
  const CategoryListItemWidget({
    super.key, required this.categoryTitle, required this.transactionId, required this.transactionName, required this.transactionAmount,
  });

  final String categoryTitle;
  final int transactionId;
  final String transactionName;
  final double transactionAmount;

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
        );
        Navigator.pop(context);
      },
    );
  }
}