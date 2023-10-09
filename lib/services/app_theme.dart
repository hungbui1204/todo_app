import 'package:flutter/material.dart';

enum AppTheme { lightTheme, darkTheme }

class AppThemes {
  static final appThemeData = {
    AppTheme.darkTheme: ThemeData(
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.teal,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
      primarySwatch: Colors.grey,
      primaryColor: Colors.black,
      brightness: Brightness.dark,
      backgroundColor: const Color(0xFF212121),
      dividerColor: Colors.black54,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.teal, foregroundColor: Colors.white),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.white),
        ),
      ),
      textTheme: const TextTheme(
        subtitle1: TextStyle(color: Colors.white),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.grey,
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.tealAccent),
    ),

    //
    //

    AppTheme.lightTheme: ThemeData(
      appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
      primarySwatch: Colors.lightBlue,
      primaryColor: Colors.white,
      brightness: Brightness.light,
      backgroundColor: const Color(0xFFE5E5E5),
      dividerColor: const Color(0xff757575),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.blueAccent),
        ),
      ),
      textTheme: const TextTheme(
        subtitle1: TextStyle(color: Colors.black),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.blue,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black),
    ),
  };
}
