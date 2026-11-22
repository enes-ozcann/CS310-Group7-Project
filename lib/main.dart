import 'package:flutter/material.dart';
import 'app_shell.dart';

void main() {
  runApp(const SmartPackApp());
}

class SmartPackApp extends StatelessWidget {
  const SmartPackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'smartPack',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.teal),
        fontFamily: 'Roboto',
      ),
      home: const AppShell(),
    );
  }
}

class AppColors {
  static const teal = Color(0xFF009F91);
  static const tealDark = Color(0xFF007F76);
  static const navy = Color(0xFF172033);
  static const text = Color(0xFF334155);
  static const muted = Color(0xFF718096);
  static const background = Color(0xFFB8BBBE);
  static const border = Color(0xFFDCE4ED);
  static const pale = Color(0xFFF2FBF9);
  static const white = Colors.white;
}
