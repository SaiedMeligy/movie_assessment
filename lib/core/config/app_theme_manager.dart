import 'package:flutter/material.dart';

class AppThemeManager{
  static const Color primaryColor=Color(0xff121312); //(0xff282A28)
  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,

    appBarTheme: const AppBarTheme(
        color: Color(0xffFFA90A),
        iconTheme: IconThemeData(
            color: Colors.white
        )
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontFamily: "Cairo",
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 24,
      ),
      bodyLarge: TextStyle(
        fontFamily: "Cairo",
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 22,
      ),
      bodyMedium: TextStyle(
        fontFamily: "Cairo",
        fontWeight: FontWeight.w500,
        color: Colors.white,
        fontSize: 18,
      ),
      bodySmall: TextStyle(
        fontFamily: "Cairo",
        fontWeight: FontWeight.w300,
        color: Colors.white,
        fontSize: 14,
      ),
    ),

  );

}