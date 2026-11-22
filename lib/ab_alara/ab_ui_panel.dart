import 'package:flutter/material.dart';

class UiPanel extends StatelessWidget {
  const UiPanel({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: child,
      );
}
