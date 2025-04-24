import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zeny/models/model_local.dart';
import 'package:zeny/screens/home_screen.dart';
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
          textScaler: const TextScaler.linear(1.0)
        ), //Don't allow user to set their own font size
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Zeny Test',
        home: HomeScreen(),
      ),
    );
  }
}
