import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zeny/models/model_local.dart';
import 'package:zeny/screens/summary_screen.dart';
import 'package:zeny/screens/today_screen.dart';
import 'package:zeny/utils/local_provider.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Init Hive Model
  await Hive.initFlutter();
  Hive.registerAdapter(LocalModelAdapter());
  await Hive.openBox<LocalModel>('local_box');

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocalProvider())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0; // Track the selected tab

  final List<Widget> _screens = [
    const TodayScreen(), // Expense screen
    const SummaryScreen(), // Summary screen 
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaler: const TextScaler.linear(1.0), // Don't allow user to set their own font size
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Zeny Test',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        home: Scaffold(
          body: _screens[_selectedIndex], 
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.blue, 
            unselectedItemColor: Colors.grey,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.attach_money),
                label: 'Expense',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart), 
                label: 'Summary',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
