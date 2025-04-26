import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zeny/utils/local_provider.dart';
import 'package:provider/provider.dart';
import 'package:zeny/utils/number.dart';
import 'package:zeny/widgets/category_list_widget.dart';
import 'package:zeny/widgets/transaction_widget.dart';

class TodayScreen extends StatefulWidget {
  const TodayScreen({super.key});

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  late String todayDate;
  late int baseId;

  @override
  void initState() {
    super.initState();
    final DateTime now = DateTime.now();
    todayDate = DateFormat('d MMMM yyyy').format(now); // Initialize todayDate
    baseId = int.parse(DateFormat('yyyyMMdd').format(now)); // Initialize baseId

    final localProvider = Provider.of<LocalProvider>(context, listen: false);

    // Add listener for titleFocusNode
    localProvider.titleFocusNode.addListener(() {
      localProvider.setTitleFocus(localProvider.titleFocusNode.hasFocus);
    });

    // Add listener for amountFocusNode
    localProvider.amountFocusNode.addListener(() {
      localProvider.setAmountFocus(localProvider.amountFocusNode.hasFocus);
    });

  }

  @override
  void dispose() {

    final localProvider = Provider.of<LocalProvider>(context, listen: false);
    
    localProvider.disposeResources();
    localProvider.titleFocusNode.dispose();
    localProvider.amountFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 0, bottom: 16),
                    child: Consumer<LocalProvider>(
                      builder: (context, localProvider, child) {
                        // Calculate the total expense dynamically
                        final double totalExpense = localProvider.getTotalExpenseByDate(baseId);
              
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                // Show the date picker
                                final DateTime? selectedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(), // Default to today's date
                                  firstDate: DateTime(2000), // Earliest selectable date
                                  lastDate: DateTime(2100), // Latest selectable date
                                );
              
                                if (selectedDate != null) {
                                  // Update the selected date
                                  setState(() {
                                    todayDate = DateFormat('d MMMM yyyy').format(selectedDate);
                                    baseId = int.parse(DateFormat('yyyyMMdd').format(selectedDate));
                                  });
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 4, bottom: 4),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      todayDate,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.arrow_drop_down, // Down arrow icon
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Expense: \$${formatNumber(totalExpense)}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Text(
                                  ' (฿${formatNumber(totalExpense * exchangeRateTHB)})',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  const Divider(color: Color(0xFFD0DEFF), thickness: 0.5, height: 1),
                  const Padding(
                    padding: EdgeInsets.only(top: 2.0),
                    child: Divider(color: Color(0xFFD0DEFF), thickness: 0.5, height: 1),
                  ),
                  Expanded(
                    child: Consumer<LocalProvider>(
                      builder: (context, localProvider, child) {
                        return ListView.builder(
                          itemCount: 99,
                          itemBuilder: (context, index) {
                            return TransactionWidget(
                              index: index,
                              baseId: baseId,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),

              // Floating "Next" Button
              Consumer<LocalProvider>(
                builder: (context, localProvider, child) {
                  if (localProvider.isTitleFocused) {
                    return Positioned(
                      bottom: 16,
                      right: 16,
                      child: FloatingActionButton(
                        shape: const CircleBorder(),
                        mini: true,
                        elevation: 2,
                        backgroundColor: Color(0xFF99B7FF),
                        onPressed: () {
                          FocusScope.of(context).requestFocus(localProvider.amountFocusNode);
                        },
                        child: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ),
                    );
                  } else if (localProvider.isAmountFocused) {
                    return Positioned(
                      bottom: 16,
                      right: 16,
                      child: FloatingActionButton(
                        shape: const CircleBorder(),
                        mini: true,
                        elevation: 2,
                        backgroundColor: Color(0xFF99B7FF),
                        onPressed: () {
                          FocusScope.of(context).unfocus(); // Close the keyboard
                          localProvider.setAmountFocus(false); 

                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              String transactionName = localProvider.titleController.text.trim().isNotEmpty
                                  ? localProvider.titleController.text.trim()
                                  : 'Expense';
                              double transactionAmount = double.tryParse(localProvider.amountController.text.trim()) ?? 0.00;
                  
                              return CategoryListWidget(
                                transactionId: localProvider.tempTransactionId ?? 0,
                                transactionName: transactionName,
                                transactionAmount: transactionAmount,
                                transactionDate: baseId,
                              );
                            },
                          );

                        },
                        child: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ), // "Next" icon for category selection
                      ),
                    );
                  } else{
                    return const SizedBox.shrink(); // Return an empty widget if no focus
                  }
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}