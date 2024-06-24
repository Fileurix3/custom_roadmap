import 'package:custom_roadmap/firebase_options.dart';
import 'package:custom_roadmap/pages/home_page.dart';
import 'package:custom_roadmap/pages/login_page.dart';
import 'package:custom_roadmap/pages/register_page.dart';
import 'package:custom_roadmap/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      home: const RegisterPage(),
      routes: {
        "/registerPage": (context) => const RegisterPage(),
        "/loginPage": (context) => const LoginPage(),
        "/homePage": (context) => const HomePage(),
      },
    );
  }
}
