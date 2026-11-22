import 'package:flutter/material.dart';
import 'ab_theme.dart';
import 'ab_general_style.dart';

// A normal Row replaces rich text and inline widget spans.
class UiBadge extends StatelessWidget {
  const UiBadge(this.label, {super.key, this.icon});
  final String label;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      decoration: BoxDecoration(
        color: GeneralStyle.mint,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        if (icon != null) ...[
          Icon(icon, size: 13, color: AppColors.teal),
          const SizedBox(width: 4),
        ],
        Flexible(
            child: Text(label,
                style: const TextStyle(color: AppColors.teal, fontSize: 11))),
      ]),
    );
  }
}
