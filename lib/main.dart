import 'package:custom_roadmap/pages/home_page.dart';
import 'package:custom_roadmap/pages/roadmap_page.dart';
import 'package:custom_roadmap/provider/theme_provider.dart';
import 'package:custom_roadmap/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
      ],
      child: MyApp(
        sharedPreferences: prefs,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;

  const MyApp({super.key, required this.sharedPreferences});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Provider.of<ThemeProvider>(context).darkTheme == false
          ? lightTheme
          : darkTheme,
      home: const HomePage(),
      routes: {
        "/homePage": (context) => const HomePage(),
        "/roadmapPage": (context) => const RoadmapPage(),
      },
    );
  }
}
