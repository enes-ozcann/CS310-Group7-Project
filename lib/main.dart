import 'package:flutter/material.dart';
import 'ab_alara/ab_theme.dart';
import 'ne_nehir/ne_main.dart';

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
      theme: appTheme,
      home: const LoginScreen(),
    );
  }
}
