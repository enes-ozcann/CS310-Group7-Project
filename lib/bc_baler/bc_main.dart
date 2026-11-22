import 'package:flutter/material.dart';
import 'bc_app_shell.dart';

// Baler Çekmece's standalone app wrapper (Kept for reference & author attribution)
class SmartPackBalerApp extends StatelessWidget {
  const SmartPackBalerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'smartPack (Baler Part)',
      home: AppShell(),
    );
  }
}
