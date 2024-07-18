import 'package:flutter/material.dart';

class AppTheme {

  static const Color primary = Colors.grey;
  static const Color black = Colors.black;
  static const Color white = Colors.white;

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(color: black),
      iconColor: black
    ),
    primaryColor: white,
    appBarTheme: const AppBarTheme(
      color: white,
      foregroundColor: black,
      titleTextStyle: TextStyle(color: black, fontSize: 20),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: white,
      foregroundColor: black,
    ),
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(white),
        foregroundColor: WidgetStatePropertyAll(black),
      )
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: black,
    ),
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(color: Colors.black),
      iconColor: Colors.black
    ),
    primaryColor: white,
    appBarTheme: const AppBarTheme(
      color: white,
      foregroundColor: Colors.black,
      titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: white,
      foregroundColor: black,
    ),
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(white),
        foregroundColor: WidgetStatePropertyAll(black),
      )
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: white,
    ),
  );
}
