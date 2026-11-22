import 'package:flutter/material.dart';
import '../../theme.dart';

class SectionHeading extends StatelessWidget {
  const SectionHeading(
      {super.key,
      required this.title,
      required this.action,
      required this.onPressed});
  final String title;
  final String action;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title,
            style: const TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: AppColors.navy)),
        const SizedBox(height: 10),
        ElevatedButton.icon(
            onPressed: onPressed,
            icon: const Icon(Icons.add, size: 18),
            label: Text(action)),
      ]);
}
