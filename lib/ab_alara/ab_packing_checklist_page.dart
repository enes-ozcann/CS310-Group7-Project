import 'package:flutter/material.dart';
import 'ab_theme.dart';
import 'ab_general_style.dart';
import 'ab_ui_components.dart';
import 'ab_packing_item_model.dart';
import 'ab_preview_data.dart';
import 'ab_add_item_page.dart';
import 'ab_packing_item_card.dart';

class PackingChecklistPage extends StatefulWidget {
  final List<PackingPreviewItem>? initialItems;

  const PackingChecklistPage({super.key, this.initialItems});

  @override
  State<PackingChecklistPage> createState() => _PackingChecklistPageState();
}

class _PackingChecklistPageState extends State<PackingChecklistPage> {
  String category = 'All';
  String status = 'All';
  late final List<PackingPreviewItem> items;

  @override
  void initState() {
    super.initState();
    items = widget.initialItems ?? createPackingItems();
  }

  Future<void> addItem() async {
    final item = await Navigator.push<PackingPreviewItem>(
        context, MaterialPageRoute(builder: (_) => const AddItemPage()));
    if (item != null && mounted) setState(() => items.add(item));
  }

  @override
  Widget build(BuildContext context) {
    final packed = items.where((item) => item.packed).length;
    final progress = items.isEmpty ? 0.0 : packed / items.length;
    final visible = items
        .where((item) =>
            (category == 'All' || item.category == category) &&
            (status == 'All' ||
                (status == 'Packed' ? item.packed : !item.packed)))
        .toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Packing Checklist')),
      body: SafeArea(
          child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionHeading(
                        title: 'Packing Checklist',
                        action: 'Add Item',
                        onPressed: addItem),
                    sectionGap,
                    UiPanel(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          const Text('PACKING PROGRESS',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: GeneralStyle.muted)),
                          const SizedBox(height: 8),
                          Row(children: [
                            Expanded(child: Text('$packed of ${items.length} packed',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold))),
                            Text('${(progress * 100).round()}%',
                                style: const TextStyle(
                                    color: AppColors.teal,
                                    fontWeight: FontWeight.w600)),
                          ]),
                          const SizedBox(height: 8),
                          ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                  value: progress,
                                  minHeight: 8,
                                  backgroundColor: const Color(0xFFE3EDE9),
                                  valueColor: const AlwaysStoppedAnimation(
                                      AppColors.teal))),
                        ])),
                    sectionGap,
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(children: [
                          for (final name in ['All', ...packingCategories])
                            Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: FilterButton(
                                    label: name,
                                    selected: category == name,
                                    onPressed: () =>
                                        setState(() => category = name)))
                        ])),
                    const SizedBox(height: 8),
                    Wrap(runSpacing: 8, children: [
                      for (final name in ['All', 'Packed', 'Unpacked'])
                        Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: FilterButton(
                                label: name,
                                selected: status == name,
                                onPressed: () => setState(() => status = name)))
                    ]),
                    sectionGap,
                    if (visible.isEmpty)
                      const UiPanel(
                          child: Center(
                              child: Text('No items match the selected filter.',
                                  style: TextStyle(color: GeneralStyle.muted))))
                    else
                      for (final item in visible)
                        Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: PackingItemCard(
                                item: item,
                                onPacked: (value) =>
                                    setState(() => item.packed = value ?? false),
                                onMinus: () => setState(() {
                                      if (item.quantity > 1) item.quantity--;
                                    }),
                                onPlus: () => setState(() => item.quantity++),
                                onRemove: () =>
                                    setState(() => items.remove(item)))),
                  ]))),
    );
  }
}
