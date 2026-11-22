import 'package:flutter/material.dart';

class QuantityControl extends StatelessWidget {
  const QuantityControl(
      {super.key,
      required this.quantity,
      required this.onMinus,
      required this.onPlus});
  final int quantity;
  final void Function() onMinus;
  final void Function() onPlus;
  @override
  Widget build(BuildContext context) =>
      Row(mainAxisSize: MainAxisSize.min, children: [
        IconButton(
            tooltip: 'Decrease quantity',
            onPressed: onMinus,
            icon: const Icon(Icons.remove, size: 18)),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text('$quantity',
                style: const TextStyle(fontWeight: FontWeight.bold))),
        IconButton(
            tooltip: 'Increase quantity',
            onPressed: onPlus,
            icon: const Icon(Icons.add, size: 18)),
      ]);
}
