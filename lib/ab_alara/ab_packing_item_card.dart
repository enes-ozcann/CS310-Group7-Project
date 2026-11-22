import 'package:flutter/material.dart';
import 'ab_theme.dart';
import 'ab_general_style.dart';
import 'ab_ui_components.dart';
import 'ab_packing_item_model.dart';

class PackingItemCard extends StatelessWidget {
  const PackingItemCard(
      {super.key,
      required this.item,
      required this.onPacked,
      required this.onMinus,
      required this.onPlus,
      required this.onRemove});
  final PackingPreviewItem item;
  final void Function(bool?) onPacked;
  final void Function() onMinus;
  final void Function() onPlus;
  final void Function() onRemove;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: item.packed ? const Color(0xFFF1F8F5) : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Checkbox(
                  value: item.packed,
                  onChanged: onPacked,
                  activeColor: AppColors.teal),
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600)),
                            if (item.suggestion.isNotEmpty) ...[
                              const SizedBox(height: 6),
                              UiBadge(item.suggestion,
                                  icon: Icons.auto_awesome_outlined)
                            ],
                          ]))),
            ]),
            Row(children: [
              const SizedBox(width: 8),
              QuantityControl(
                  quantity: item.quantity, onMinus: onMinus, onPlus: onPlus),
              const Spacer(),
              IconButton(
                  tooltip: 'Remove item',
                  onPressed: onRemove,
                  icon: const Icon(Icons.delete_outline,
                      color: GeneralStyle.muted, size: 20)),
            ]),
          ])),
    );
  }
}
