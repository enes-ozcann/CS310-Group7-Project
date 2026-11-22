import 'package:flutter/material.dart';
import 'eo_place_model.dart';
import 'eo_place_card.dart';
import '../ab_alara/ab_theme.dart';
import '../ne_nehir/ne_widgets.dart';

// Unified sample places incorporating local and network images (Rubric Constraint 5)
const List<Place> samplePlaces = [
  Place(
    id: 'colosseum',
    name: 'Colosseum & Roman Forum',
    city: 'Rome',
    category: 'Historical',
    description: 'Explore the ancient amphitheatre and historic ruins in Rome.',
    image: 'assets/images/rome.png',
    isLocal: true,
  ),
  Place(
    id: 'eiffel-tower',
    name: 'Eiffel Tower',
    city: 'Paris',
    category: 'Landmark',
    description: 'Enjoy the iconic city views and gardens around the Eiffel Tower.',
    image: 'assets/images/paris.png',
    isLocal: true,
  ),
  Place(
    id: 'louvre-museum',
    name: 'Louvre Museum',
    city: 'Paris',
    category: 'Museum',
    description: 'Discover famous artworks and historic galleries in the Louvre Museum.',
    image: 'https://picsum.photos/id/1031/900/500',
    isLocal: false, // Network image demonstration
  ),
  Place(
    id: 'park-guell',
    name: 'Park Güell',
    city: 'Barcelona',
    category: 'Architecture',
    description: 'See colorful Gaudi architecture and panoramic views of Barcelona.',
    image: 'assets/images/barcelona.png',
    isLocal: true,
  ),
  Place(
    id: 'senso-ji',
    name: 'Senso-ji Temple',
    city: 'Tokyo',
    category: 'Cultural',
    description: 'Explore a historic Buddhist temple and traditional market in Tokyo.',
    image: 'assets/images/tokyo.png',
    isLocal: true,
  ),
];

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({
    super.key,
    this.onPlaceSelected,
  });

  final void Function(Place)? onPlaceSelected;

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String _searchText = '';
  String _selectedCategory = 'All';

  final List<String> _categories = [
    'All',
    'Historical',
    'Landmark',
    'Museum',
    'Architecture',
    'Cultural',
  ];

  List<Place> _getFilteredPlaces() {
    List<Place> results = [];

    for (Place place in samplePlaces) {
      bool matchesSearch =
          place.name.toUpperCase().contains(_searchText) ||
          place.city.toUpperCase().contains(_searchText);

      bool matchesCategory =
          _selectedCategory == 'All' ||
          place.category == _selectedCategory;

      if (matchesSearch && matchesCategory) {
        results.add(place);
      }
    }

    return results;
  }

  void _openDetails(Place place) {
    if (widget.onPlaceSelected != null) {
      widget.onPlaceSelected!(place);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PlaceDetailsScreen(place: place),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Place> places = _getFilteredPlaces();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore Destinations'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Discover Places',
                style: AppText.heading,
              ),
              const SizedBox(height: 6),
              const Text(
                'Find attractions and monuments for your next journey.',
                style: AppText.body,
              ),
              const SizedBox(height: 14),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search places or cities...',
                  prefixIcon: const Icon(Icons.search, color: AppColors.teal),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.cardBorder),
                  ),
                ),
                onChanged: (String value) {
                  setState(() {
                    _searchText = value.trim().toUpperCase();
                  });
                },
              ),
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _categories.map((String category) {
                    final isSelected = _selectedCategory == category;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        selected: isSelected,
                        label: Text(category),
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : AppColors.textPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                        selectedColor: AppColors.teal,
                        backgroundColor: Colors.white,
                        checkmarkColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: isSelected ? AppColors.teal : AppColors.cardBorder,
                          ),
                        ),
                        onSelected: (selected) {
                          setState(() {
                            _selectedCategory = category;
                          });
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '${places.length} places found',
                style: AppText.caption,
              ),
              const SizedBox(height: 8),
              Expanded(
                child: places.isEmpty
                    ? const Center(
                        child: Text(
                          'No places match your search.\nTry another query or category.',
                          textAlign: TextAlign.center,
                          style: AppText.body,
                        ),
                      )
                    : ListView.builder(
                        itemCount: places.length,
                        itemBuilder: (context, index) {
                          final place = places[index];
                          return PlaceCard(
                            place: place,
                            onDetailsTap: () => _openDetails(place),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
