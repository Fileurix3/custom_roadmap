import 'package:custom_roadmap/pages/home_page.dart';
import 'package:custom_roadmap/pages/roadmap_page.dart';
import 'package:custom_roadmap/theme.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      home: const HomePage(),
      routes: {
        "/roadmapPage": (context) => const RoadmapPage(),
      },
    );
  }
}
