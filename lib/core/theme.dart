import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: const Color(0xFFF5EEE8),
      primaryColor: const Color(0xFF000000),
      fontFamily: 'Poppins',
      errorColor: const Color(0xffe80202),
      colorScheme: ThemeData()
          .colorScheme
          .copyWith(primaryVariant: const Color(0xff14a69c),secondary: Colors.grey),
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.5,
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.black),
        ),
      ),
      textTheme: const TextTheme(
        bodyText1: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        bodyText2: TextStyle(
          color: Colors.grey,
          fontSize: 16.0
        ),
        headline4: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        headline6: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        button: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.black),
      primaryIconTheme: const IconThemeData(color: Colors.black, size: 30),
      checkboxTheme: CheckboxThemeData(
          checkColor: MaterialStateProperty.all(const Color(0xff4caf50))));
}
