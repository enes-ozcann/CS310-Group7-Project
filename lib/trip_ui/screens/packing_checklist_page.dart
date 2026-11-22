import 'package:flutter/material.dart';
import '../../theme.dart';
import '../shared/general_style.dart';
import '../widgets/ui_components.dart';
import '../models/packing_item.dart';
import '../data/preview_data.dart';
import 'add_item_page.dart';
import '../widgets/packing_item_card.dart';

class PackingChecklistPage extends StatefulWidget {
  const PackingChecklistPage({super.key});

  @override
  State<PackingChecklistPage> createState() => _PackingChecklistPageState();
}

class _PackingChecklistPageState extends State<PackingChecklistPage> {
  String category = 'All';
  String status = 'All';
  final items = createPackingItems();

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
                          Text('${(progress * 100).round()}% Packed',
                              style: const TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.teal)),
                          Text('$packed / ${items.length} items packed',
                              style:
                                  const TextStyle(color: GeneralStyle.muted)),
                          const SizedBox(height: 14),
                          // Row and Expanded draw the progress bar.
                          SizedBox(
                              height: 8,
                              child: Row(children: [
                                if (packed > 0)
                                  Expanded(
                                      flex: packed,
                                      child: Container(color: AppColors.teal)),
                                if (items.length - packed > 0)
                                  Expanded(
                                      flex: items.length - packed,
                                      child:
                                          Container(color: GeneralStyle.mint)),
                                if (items.isEmpty)
                                  Expanded(
                                      child:
                                          Container(color: GeneralStyle.mint)),
                              ])),
                        ])),
                    sectionGap,
                    Wrap(spacing: 8, runSpacing: 4, children: [
                      for (final name in ['All', ...packingCategories])
                        FilterButton(
                            label: name,
                            selected: category == name,
                            onPressed: () => setState(() => category = name)),
                    ]),
                    const SizedBox(height: 8),
                    Wrap(spacing: 8, children: [
                      for (final name in ['All', 'Missing', 'Packed'])
                        FilterButton(
                            label: name,
                            selected: status == name,
                            onPressed: () => setState(() => status = name)),
                    ]),
                    sectionGap,
                    if (visible.isEmpty)
                      const UiPanel(
                          child: Text('No items match these filters.')),
                    for (final group in packingCategories)
                      if (visible
                          .where((item) => item.category == group)
                          .isNotEmpty) ...[
                        UiPanel(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              Text(group,
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 12),
                              for (final item in visible
                                  .where((item) => item.category == group))
                                PackingItemCard(
                                  item: item,
                                  onPacked: (value) => setState(
                                      () => item.packed = value ?? false),
                                  onMinus: () => setState(() {
                                    if (item.quantity > 1) item.quantity--;
                                  }),
                                  onPlus: () => setState(() => item.quantity++),
                                  onRemove: () =>
                                      setState(() => items.remove(item)),
                                ),
                            ])),
                        sectionGap,
                      ],
                  ]))),
    );
  }
}
