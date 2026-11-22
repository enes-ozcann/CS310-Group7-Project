import 'package:flutter/material.dart';
import '../../theme.dart';
import '../shared/general_style.dart';
import '../widgets/ui_components.dart';
import '../models/place.dart';

class PlacePreviewCard extends StatelessWidget {
  const PlacePreviewCard({super.key, required this.place});
  final PlacePreview place;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0,
        color: const Color(0xFFF7FAF9),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Image.network(place.image,
                width: 64,
                height: 72,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                    width: 64,
                    height: 72,
                    color: GeneralStyle.mint,
                    child: const Icon(Icons.account_balance,
                        color: AppColors.teal))),
            const SizedBox(width: 12),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(place.name,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Text('Rome · ${place.category}',
                      style: const TextStyle(
                          color: GeneralStyle.muted, fontSize: 12)),
                  const SizedBox(height: 8),
                  UiBadge(place.visited ? 'Visited' : 'To Visit',
                      icon: place.visited
                          ? Icons.check_circle_outline
                          : Icons.schedule),
                ])),
            // These are visual placeholders; this page has no backend mutations.
            IconButton(
                tooltip: 'Remove from trip',
                onPressed: () {},
                icon: const Icon(Icons.delete_outline,
                    size: 18, color: GeneralStyle.muted)),
          ]),
        ));
  }
}
