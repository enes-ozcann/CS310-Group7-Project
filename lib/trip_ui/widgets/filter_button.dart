import 'package:flutter/material.dart';
import '../../theme.dart';
import '../shared/general_style.dart';

// The same ordinary button is reused for category and packed-status filters.
class FilterButton extends StatelessWidget {
  const FilterButton(
      {super.key,
      required this.label,
      required this.selected,
      required this.onPressed});
  final String label;
  final bool selected;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: selected ? AppColors.teal : GeneralStyle.mint,
        foregroundColor: selected ? Colors.white : AppColors.navy,
        minimumSize: const Size(0, 40),
      ),
      child: Text(label),
    );
  }
}
