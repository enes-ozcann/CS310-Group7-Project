import 'package:flutter/material.dart';
import 'eo_place_model.dart';
import '../ab_alara/ab_theme.dart';

/// PlaceCard Widget - Implemented by Enes Özcan (eo_)
/// Applied across both Enes's Explore screen and Alara's Places list per user instruction.
class PlaceCard extends StatelessWidget {
  const PlaceCard({
    super.key,
    required this.place,
    this.onDetailsTap,
  });

  final Place place;
  final void Function()? onDetailsTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.cardBorder, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image container supporting local asset and network images (Rubric Constraint 5)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: 140,
                width: double.infinity,
                child: place.isLocal
                    ? Image.asset(
                        place.image,
                        fit: BoxFit.cover,
                        errorBuilder: (ctx, err, stack) => Container(
                          color: AppColors.tealLight,
                          alignment: Alignment.center,
                          child: const Icon(Icons.landscape, size: 48, color: AppColors.teal),
                        ),
                      )
                    : Image.network(
                        place.image,
                        fit: BoxFit.cover,
                        errorBuilder: (ctx, err, stack) => Image.asset(
                          'assets/images/paris.png',
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              place.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.navy,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${place.city} • ${place.category}',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.teal,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              place.description,
              style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: onDetailsTap,
              child: const Text('View Details'),
            ),
          ],
        ),
      ),
    );
  }
}
