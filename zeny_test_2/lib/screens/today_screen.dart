import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zeny/utils/local_provider.dart';
import 'package:provider/provider.dart';
import 'package:zeny/utils/number.dart';
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
  }

  @override
  Widget build(BuildContext context) {

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: Column(
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
        ),
      ),
    );
  }
}