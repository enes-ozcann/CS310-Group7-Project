import 'package:flutter/material.dart';
import '../models/place.dart';

// displays the place given by the parent screen
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
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              alignment: Alignment.center,
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Text(
                'Place image',
                style: TextStyle(
                  color: Theme.of(context)
                      .colorScheme
                      .onPrimaryContainer,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              place.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text('${place.city} - ${place.category}'),
            const SizedBox(height: 8),
            Text(place.description),
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