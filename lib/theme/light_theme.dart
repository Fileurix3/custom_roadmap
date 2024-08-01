import 'package:custom_roadmap/theme/other_theme.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    color: Color.fromRGBO(235, 231, 227, 1),
    titleTextStyle: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
    centerTitle: true,
  ),
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.orange,
    accentColor: Colors.orangeAccent,
    cardColor: const Color.fromRGBO(215, 215, 215, 0.9),
    backgroundColor: const Color.fromRGBO(235, 231, 227, 1),
    brightness: Brightness.light,
  ),
  inputDecorationTheme: inputDecoration(Colors.black),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: elevationButtonStyle(Colors.orange, Colors.black),
  ),
  textTheme: textTheme,
);
