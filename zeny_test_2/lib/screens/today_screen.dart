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
  @override
  Widget build(BuildContext context) {
    final String todayDate = DateFormat('d MMMM yyyy').format(DateTime.now());
    final int baseId = int.parse(DateFormat('yyyyMMdd').format(DateTime.now()));

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
                    final double totalExpense = localProvider.transactions.fold(
                      0.0,
                      (sum, transaction) => sum + transaction.transactionAmount,
                    );
                    return Column(
                      children: [
          
                        Padding(
                          padding: const EdgeInsets.only(top:4, bottom: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
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
                              ' (฿${formatNumber(totalExpense*exchangeRateTHB)})',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
              Divider(color: Color(0xFFD0DEFF), thickness: 0.5, height: 1,),
              Padding(
                padding: const EdgeInsets.only(top: 2.0,),
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