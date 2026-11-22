import 'package:flutter/material.dart';

/// Centralized Theme & Colors for smartPack
/// Base Design & Palette: Alara Bilik (ab_)
/// Utilized across all screens for design consistency (CS 310 Rubric Criterion 3)
class AppColors {
  // Primary brand colors from Alara's palette
  static const Color teal = Color(0xFF167D82);
  static const Color primary = teal;
  static const Color primaryTeal = teal;
  static const Color tealLight = Color(0xFFE8F4F5);
  static const Color tealDark = Color(0xFF0F565A);
  static const Color navy = Color(0xFF19314A);
  static const Color background = Color(0xFFF5F8FA);
  
  // Neutral colors & utility shades
  static const Color cardBorder = Color(0xFFE2E8F0);
  static const Color border = cardBorder;
  static const Color muted = Color(0xFF64748B);
  static const Color textMuted = muted;
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color text = textPrimary;
  static const Color textSecondary = Color(0xFF475569);
  static const Color white = Colors.white;
  static const Color pale = Color(0xFFE8F4F5);

  // Semantic feedback colors
  static const Color error = Color(0xFFDC2626);
  static const Color success = Color(0xFF16A34A);
  static const Color warning = Color(0xFFD97706);
}

class AppSpacing {
  static const double xsmall = 4.0;
  static const double small = 8.0;
  static const double medium = 16.0;
  static const double large = 24.0;
  static const double xlarge = 32.0;
}

class AppText {
  static const TextStyle heading = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.navy,
  );
  static const TextStyle subheading = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.navy,
  );
  static const TextStyle body = TextStyle(
    fontSize: 14,
    color: AppColors.textPrimary,
  );
  static const TextStyle bodyBold = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    color: AppColors.muted,
  );
}

class AppTextStyles {
  static const TextStyle heading1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.navy,
  );
  static const TextStyle heading2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.navy,
  );
  static const TextStyle heading3 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.navy,
  );
  static const TextStyle body = TextStyle(
    fontSize: 14,
    color: AppColors.textPrimary,
  );
  static const TextStyle bodyBold = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    color: AppColors.muted,
  );
}

final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  primaryColor: AppColors.teal,
  scaffoldBackgroundColor: AppColors.background,
  fontFamily: 'SmartPackFont',
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.teal,
    primary: AppColors.teal,
    secondary: AppColors.navy,
    surface: AppColors.background,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: AppColors.navy,
    elevation: 0,
    centerTitle: false,
    titleTextStyle: TextStyle(
      fontFamily: 'SmartPackFont',
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: AppColors.navy,
    ),
  ),
  cardTheme: CardThemeData(
    color: Colors.white,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: const BorderSide(color: AppColors.cardBorder, width: 1),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.cardBorder),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.cardBorder),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.teal, width: 1.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.error),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.teal,
      foregroundColor: Colors.white,
      elevation: 0,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      textStyle: const TextStyle(
        fontFamily: 'SmartPackFont',
        fontWeight: FontWeight.w600,
        fontSize: 15,
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.teal,
      side: const BorderSide(color: AppColors.teal),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: AppColors.teal,
    unselectedItemColor: AppColors.muted,
    type: BottomNavigationBarType.fixed,
    elevation: 8,
  ),
);
