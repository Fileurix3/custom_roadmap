import 'package:flutter/material.dart';

const TextTheme textTheme = TextTheme(
  headlineSmall: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
  titleLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
  titleMedium: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
  titleSmall: TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.lineThrough,
  ),
  labelMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
  bodyMedium: TextStyle(fontSize: 18),
);

ButtonStyle elevationButtonStyle(Color mainColor, Color textColor) =>
    ButtonStyle(
      textStyle: WidgetStateProperty.all<TextStyle>(
        const TextStyle(fontSize: 20),
      ),
      foregroundColor: WidgetStateProperty.all<Color>(textColor),
      backgroundColor: WidgetStateProperty.all<Color>(mainColor),
      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
        const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      ),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );

InputDecorationTheme inputDecoration(Color? mainColor) => InputDecorationTheme(
      prefixIconColor: mainColor,
      suffixIconColor: mainColor,
      labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: mainColor!),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: mainColor,
        ),
      ),
    );

ThemeData lightTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    color: Color.fromRGBO(235, 231, 227, 1),
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

ThemeData darkTheme = ThemeData(
  appBarTheme: AppBarTheme(
    color: Colors.grey[900],
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
