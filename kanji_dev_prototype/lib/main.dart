import 'package:flutter/material.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import './home.dart';
import './sign_in.dart';
import './update_password.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://ltlgpkvbizdjzniuwvui.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imx0bGdwa3ZiaXpkanpuaXV3dnVpIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTYyMzc0MzgsImV4cCI6MjAxMTgxMzQzOH0.MxZ_SDg55mh6EdYTUErRQ2b5T98p0GiyI_v6c6dTXCw',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kanji Demo',
      theme: ThemeData(
        primaryColor: const Color(0xff38B2AC),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SignUp(),
        '/update_password': (context) => const UpdatePassword(),
        '/home': (context) => const Home(),
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (BuildContext context) => const Scaffold(
            body: Center(
              child: Text(
                'Not Found',
                style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      },
    );
  }
}
