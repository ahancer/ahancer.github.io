import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeny/utils/local_provider.dart';
import 'package:zeny/utils/number.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  bool isInUSD = true; // Track whether the currency is in USD or THB
  double exchangeRate = 1; // Default exchange rate for USD
  String currency = '\$'; // Default currency symbol for USD

  @override
  Widget build(BuildContext context) {
    final localProvider = Provider.of<LocalProvider>(context, listen: false);

    double totalExpense = localProvider.getTotalExpense;
    double foodExpense = localProvider.getCategoryExpense('Food');
    double transportExpense = localProvider.getCategoryExpense('Transport');
    double shoppingExpense = localProvider.getCategoryExpense('Shopping');
    double giftExpense = localProvider.getCategoryExpense('Gift');
    double otherExpense = localProvider.getCategoryExpense('Other');

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Summary"),
          actions: [
            IconButton(
              icon: const Icon(Icons.delete),
              color: const Color(0xFF99B7FF),
              onPressed: () {
                localProvider.deleteAllTransactions();
                setState(() {});
              },
            ),
          ],
        ),
        body: Column(
          children: [
            const Divider(color: Color(0xFFD0DEFF), thickness: 0.5, height: 1),
            Padding(
              padding: const EdgeInsets.only(top: 2.0, bottom: 16.0),
              child: const Divider(color: Color(0xFFD0DEFF), thickness: 0.5, height: 1),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  SummaryRowWidget(
                    label: 'Food',
                    currency: currency,
                    amount: foodExpense * exchangeRate,
                  ),
                  SummaryRowWidget(
                    label: 'Transport',
                    currency: currency,
                    amount: transportExpense * exchangeRate,
                  ),
                  SummaryRowWidget(
                    label: 'Shopping',
                    currency: currency,
                    amount: shoppingExpense * exchangeRate,
                  ),
                  SummaryRowWidget(
                    label: 'Gift',
                    currency: currency,
                    amount: giftExpense * exchangeRate,
                  ),
                  SummaryRowWidget(
                    label: 'Other',
                    currency: currency,
                    amount: otherExpense * exchangeRate,
                  ),
                  SummaryRowWidget(
                    label: 'Total Expense',
                    currency: currency,
                    amount: totalExpense * exchangeRate,
                    isBold: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0, bottom: 24.0),
                    child: const Divider(color: Color(0xFFD0DEFF), thickness: 0.5, height: 1),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (isInUSD) {
                          // Convert to Thai Baht
                          exchangeRate = exchangeRateTHB;
                          currency = '฿';
                          isInUSD = false;
                        } else {
                          // Convert back to USD
                          exchangeRate = 1;
                          currency = '\$';
                          isInUSD = true;
                        }
                      });
                    },
                    child: Text(
                      isInUSD ? 'Convert to THB' : 'Convert to USD',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SummaryRowWidget extends StatelessWidget {
  const SummaryRowWidget({
    super.key,
    required this.label,
    required this.currency,
    required this.amount,
    this.isBold = false, // Optional parameter with default value
  });

  final String label;
  final String currency;
  final double amount;
  final bool isBold; // New optional parameter

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isBold ? FontWeight.bold : FontWeight.normal, // Set fontWeight based on isBold
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  "$currency${formatNumber(amount)}",
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isBold ? FontWeight.bold : FontWeight.normal, // Set fontWeight based on isBold
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(color: Color(0xFFD0DEFF), thickness: 0.5, height: 1),
      ],
    );
  }
}

