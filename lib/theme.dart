import 'package:flutter/material.dart';

class AppColors {
  static const Color teal = Color(0xFF167D82);
  static const Color navy = Color(0xFF19314A);
  static const Color background = Color(0xFFF5F8FA);
}

class AppSpacing {
  static const double small = 8;
  static const double medium = 16;
  static const double large = 24;
}

class AppText {
  static const TextStyle heading = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  static const TextStyle subheading = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
}

final ThemeData appTheme = ThemeData(
  primaryColor: AppColors.teal,
  scaffoldBackgroundColor: AppColors.background,
  fontFamily: 'SmartPackFont',
  appBarTheme: const AppBarTheme(backgroundColor: AppColors.background, foregroundColor: AppColors.navy),
  inputDecorationTheme: const InputDecorationTheme(border: OutlineInputBorder()),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(backgroundColor: AppColors.teal, foregroundColor: Colors.white,
      minimumSize: const Size(double.infinity, 48)),
  ),
);
