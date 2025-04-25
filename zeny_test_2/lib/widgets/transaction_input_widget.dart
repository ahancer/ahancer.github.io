import 'package:flutter/material.dart';

class TransactionInputWidget extends StatefulWidget {
  const TransactionInputWidget({super.key});

  @override
  State<TransactionInputWidget> createState() => _TransactionInputWidgetState();
}

class _TransactionInputWidgetState extends State<TransactionInputWidget> {
   final TextEditingController _titleController = TextEditingController();
   final TextEditingController _amountController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    double screenWidth =  MediaQuery.of(context).size.width;

    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        SizedBox(
          width: screenWidth * 0.3,
          child: Padding(
            padding: const EdgeInsets.only(left:12.0),
            child: TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: '+ Expense',
                hintStyle: TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.normal),
                border: InputBorder.none,
              ),
            ),
          ),
        ),

        SizedBox(
          width: screenWidth * 0.3,
          child: TextField(
            controller: _amountController,
            textAlign: TextAlign.end,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: '0.00',
              hintStyle: TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.normal),
            ),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            style: const TextStyle(fontSize: 16),
          ),
        ),

        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
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
                          ListTile(
                            title: const Text('Food'),
                            onTap: () {
                              Navigator.pop(context); // Close the bottom sheet
                              print('Food selected');
                            },
                          ),
                          ListTile(
                            title: const Text('Transport'),
                            onTap: () {
                              Navigator.pop(context); // Close the bottom sheet
                              print('Transport selected');
                            },
                          ),
                          ListTile(
                            title: const Text('Shopping'),
                            onTap: () {
                              Navigator.pop(context); // Close the bottom sheet
                              print('Shopping selected');
                            },
                          ),
                          ListTile(
                            title: const Text('Other'),
                            onTap: () {
                              Navigator.pop(context); // Close the bottom sheet
                              print('Other selected');
                            },
                          ),
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