import 'package:flutter/material.dart';
import 'ab_general_style.dart';
import 'ab_ui_components.dart';
import 'ab_packing_item_model.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({super.key});

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String category = packingCategories.first;
  int quantity = 1;

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Item')),
      body: SafeArea(
          child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Add a Packing Item',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          sectionGap,
          Form(
              key: formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('ITEM NAME',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: GeneralStyle.muted,
                            fontSize: 12)),
                    const SizedBox(height: 8),
                    TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(
                            hintText: 'e.g. Raincoat, Sunglasses'),
                        validator: (value) =>
                            value == null || value.trim().isEmpty
                                ? 'Please enter an item name.'
                                : null),
                    sectionGap,
                    const Text('CATEGORY',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: GeneralStyle.muted,
                            fontSize: 12)),
                    const SizedBox(height: 8),
                    Wrap(spacing: 6, runSpacing: 4, children: [
                      for (final name in packingCategories)
                        FilterButton(
                            label: name,
                            selected: category == name,
                            onPressed: () => setState(() => category = name))
                    ]),
                    sectionGap,
                    const Text('QUANTITY',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: GeneralStyle.muted,
                            fontSize: 12)),
                    const SizedBox(height: 8),
                    QuantityControl(
                        quantity: quantity,
                        onMinus: () => setState(() {
                              if (quantity > 1) quantity--;
                            }),
                        onPlus: () => setState(() => quantity++)),
                  ])),
          sectionGap,
          Wrap(spacing: 12, runSpacing: 12, children: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel')),
            ElevatedButton.icon(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    Navigator.pop(
                        context,
                        PackingPreviewItem(nameController.text.trim(), category,
                            quantity: quantity));
                  }
                },
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Add to List')),
          ]),
        ]),
      )),
    );
  }
}
