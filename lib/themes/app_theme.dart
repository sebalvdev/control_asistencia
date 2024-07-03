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
    primaryColor: primary,
    appBarTheme: const AppBarTheme(
      color: primary,
      foregroundColor: white,
      titleTextStyle: TextStyle(color: white, fontSize: 20),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primary,
      foregroundColor: black,
    ),
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(primary),
        foregroundColor: WidgetStatePropertyAll(white),
      )
    )
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(color: Colors.white),
      iconColor: Colors.white
    ),
    primaryColor: primary,
    appBarTheme: const AppBarTheme(
      color: primary,
      foregroundColor: Colors.white,
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primary,
      foregroundColor: white,
    ),
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(primary),
        foregroundColor: WidgetStatePropertyAll(white),
      )
    )
  );
}
