import 'package:flutter/material.dart';

const TextTheme textTheme = TextTheme(
  headlineLarge: TextStyle(
    fontSize: 40,
  ),
  titleSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
);

ButtonStyle elevationButtonStyle = ButtonStyle(
  textStyle: WidgetStateProperty.all<TextStyle>(const TextStyle(fontSize: 20)),
  foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
  backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),
  overlayColor:
      WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
    if (states.contains(WidgetState.hovered)) {
      return Colors.blueAccent.withOpacity(0.7);
    }
    return null;
  }),
  padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
    const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
  ),
  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
  ),
);

InputDecorationTheme inputDecoration(Color? mainColor, Color errorColor) =>
    InputDecorationTheme(
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
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: errorColor),
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: errorColor),
      ),
    );

ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.blue,
    accentColor: Colors.blueAccent,
    cardColor: Colors.grey[300],
    backgroundColor: Colors.grey[100],
    brightness: Brightness.light,
  ),
  inputDecorationTheme: inputDecoration(Colors.black, Colors.red),
  elevatedButtonTheme: ElevatedButtonThemeData(style: elevationButtonStyle),
  textTheme: textTheme,
);

ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.blue,
    accentColor: Colors.blueAccent,
    cardColor: Colors.grey[800],
    backgroundColor: Colors.grey[900],
    brightness: Brightness.dark,
  ),
  inputDecorationTheme: inputDecoration(Colors.grey[350], Colors.red),
  elevatedButtonTheme: ElevatedButtonThemeData(style: elevationButtonStyle),
  textTheme: textTheme,
);
