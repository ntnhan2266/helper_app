import 'package:flutter/material.dart';
class Constants{

  static String appName = "Smart Rabbit";

  //Colors for theme
  static Color primaryColor = Color(0xff5cc7c1);
  static Color textColor = Color(0xff13918C);
  static Color lightAccent = Colors.blueGrey[900];
  static Color lightBG = Color(0xfffcfcff);
  static Color darkBG = Colors.black;

  static ThemeData lightTheme = ThemeData(
    backgroundColor: lightBG,
    primaryColor: primaryColor,
    accentColor:  lightAccent,
    cursorColor: lightAccent,
    scaffoldBackgroundColor: lightBG,
    appBarTheme: AppBarTheme(
      elevation: 0,
      textTheme: TextTheme(
        title: TextStyle(
          color: darkBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ),
//      iconTheme: IconThemeData(
//        color: lightAccent,
//      ),
    ),
  );

}