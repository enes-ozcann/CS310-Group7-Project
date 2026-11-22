import 'package:flutter/material.dart';
import 'ne_models.dart';
import 'ne_theme.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  const AuthHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(Icons.luggage, size: 65, color: AppColors.teal),
        const SizedBox(height: 15),
        Text(title, style: AppText.heading),
        const SizedBox(height: 20),
      ],
    );
  }
}

class DestinationImage extends StatelessWidget {
  final TouristPlace place;
  final double height;
  const DestinationImage({super.key, required this.place, required this.height});

  @override
  Widget build(BuildContext context) {
    if (place.isLocal) {
      return Image.asset(
        place.image,
        width: double.infinity,
        height: height,
        fit: BoxFit.cover,
      );
    }
    return Image.network(
      place.image,
      width: double.infinity,
      height: height,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          'assets/images/paris.png',
          width: double.infinity,
          height: height,
          fit: BoxFit.cover,
        );
      },
    );
  }
}

class DestinationCard extends StatelessWidget {
  final TouristPlace place;
  const DestinationCard({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DestinationImage(place: place, height: 185),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(place.name, style: AppText.subheading),
                const SizedBox(height: 8),
                Text(place.description),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => PlaceDetailsScreen(place: place),
                          ));
                        },
                        child: const Text('View Details'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('')),
                          );
                        },
                        child: const Text('Add to Trip'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PlaceDetailsScreen extends StatelessWidget {
  final TouristPlace place;
  const PlaceDetailsScreen({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(place.name)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          DestinationImage(place: place, height: 220),
          const SizedBox(height: 16),
          Text(place.name, style: AppText.heading),
          const SizedBox(height: 12),
          Text(place.description),
        ],
      ),
    );
  }
}
