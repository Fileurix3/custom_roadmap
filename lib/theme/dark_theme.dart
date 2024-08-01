import 'package:custom_roadmap/theme/other_theme.dart';
import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  appBarTheme: AppBarTheme(
    color: Colors.grey[900],
    titleTextStyle: const TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
    centerTitle: true,
  ),
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.indigo,
    accentColor: Colors.indigoAccent,
    cardColor: Colors.grey[850],
    backgroundColor: Colors.grey[900],
    brightness: Brightness.dark,
  ),
  inputDecorationTheme: inputDecoration(Colors.grey[350]),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: elevationButtonStyle(Colors.indigo, Colors.white),
  ),
  textTheme: textTheme,
);
