import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:zeny/utils/notification_controller.dart';
import 'package:zeny/utils/local_provider.dart';
import 'package:provider/provider.dart';

class TodayScreen extends StatefulWidget {
  const TodayScreen({super.key});

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  int counter = 0;

  @override
  void initState() {
    setNotificaiton();
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod:
            NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:
            NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:
            NotificationController.onDismissActionReceivedMethod);
    super.initState();
  }

  void setNotificaiton() async {
    await AwesomeNotifications().initialize(null, [
      NotificationChannel(
        channelGroupKey: "basic_channel_group",
        channelKey: "basic_channel",
        channelName: "Basic Notification",
        channelDescription: "Basic notifications channel",
      )
    ], channelGroups: [
      NotificationChannelGroup(
        channelGroupKey: "basic_channel_group",
        channelGroupName: "Basic Group",
      )
    ]);
    bool isAllowedToSendNotification =
        await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowedToSendNotification) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    } 
  }


  @override
  Widget build(BuildContext context) {
    final localProvider = Provider.of<LocalProvider>(context);

    final String todayDate = DateFormat('d MMMM yyyy').format(DateTime.now());

    final int baseId = int.parse(DateFormat('yyyyMMdd').format(DateTime.now()));

    // Calculate the total expense
    final double totalExpense = localProvider.transactions.fold(
      0.0,
      (sum, transaction) => sum + transaction.transactionAmount,
    );

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(todayDate),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Total Expense: \$${totalExpense.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 99, // Keep the list at 99 items
                itemBuilder: (context, index) {
                  final number = index + 1;

                  // Check if a transaction exists for the current index
                  if (index < localProvider.transactions.length) {
                    final transaction = localProvider.transactions[index];
                    return Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 0.5), // Add bottom border
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'ID ${transaction.transactionId}',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '\$${transaction.transactionAmount.toStringAsFixed(2)}', // Display transaction amount
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    // Placeholder for unavailable transactions
                    return Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 0.5), // Add bottom border
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          number.toString(), // Placeholder number
                          style: const TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
    
          ],
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                counter = counter + 1; 
                final int transactionId = int.parse('$baseId${counter.toString().padLeft(2, '0')}'); 
                localProvider.addTransaction(
                  transactionId: transactionId
                );
                print('Number of transactions: ${localProvider.transactions.length}');
              },
              child: const Icon(Icons.add),
            ),
            const Gap(16),
            FloatingActionButton(
              onPressed: () {
                counter = 0;
                localProvider.deleteAllTransactions();
              },
              child: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}