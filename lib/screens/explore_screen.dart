import 'package:flutter/material.dart';
import '../models/place.dart';
import '../widgets/place_card.dart';

// sample data without an API or database
const List<Place> samplePlaces = [
  Place(
    id: 'colosseum',
    name: 'Colosseum',
    city: 'Rome',
    category: 'Historical',
    description: 'Explore the ancient amphitheatre in Rome.',
  ),
  Place(
    id: 'eiffel-tower',
    name: 'Eiffel Tower',
    city: 'Paris',
    category: 'Landmark',
    description: 'Enjoy the city views around the Eiffel Tower.',
  ),
  Place(
    id: 'historic-istanbul',
    name: 'Historic Istanbul',
    city: 'Istanbul',
    category: 'Historical',
    description: 'Discover historic streets and architecture.',
  ),
];

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({
    super.key,
    this.onPlaceSelected,
  });

  // passes the selected place to the details screen
  final void Function(Place)? onPlaceSelected;

  @override
  State<ExploreScreen> createState() {
    return _ExploreScreenState();
  }
}

class _ExploreScreenState extends State<ExploreScreen> {
  String _searchText = '';
  String _selectedCategory = 'All';

  final List<String> _categories = [
    'All',
    'Historical',
    'Landmark',
  ];

  // searches the beginning of the place name or city name
  List<Place> _getFilteredPlaces() {
    List<Place> results = [];

    for (Place place in samplePlaces) {
      bool matchesSearch =
          place.name.toUpperCase().startsWith(_searchText) ||
          place.city.toUpperCase().startsWith(_searchText);

      bool matchesCategory =
          _selectedCategory == 'All' ||
          place.category == _selectedCategory;

      if (matchesSearch && matchesCategory) {
        results.add(place);
      }
    }

    return results;
  }

  @override
  Widget build(BuildContext context) {
    List<Place> places = _getFilteredPlaces();

    // a local variable allows a normal null check
    final openDetails = widget.onPlaceSelected;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Explore Destinations',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Find places to visit on your next trip.',
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Search places or cities',
                  border: OutlineInputBorder(),
                ),
                onChanged: (String value) {
                  setState(() {
                    _searchText = value.trim().toUpperCase();
                  });
                },
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _categories.map((String category) {
                  return ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                    child: Text(
                      _selectedCategory == category
                          ? '$category (selected)'
                          : category,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 12),
              Text('${places.length} places found'),
              const SizedBox(height: 8),

              // the list uses the remaining screen height
              Expanded(
                child: places.isEmpty
                    ? const Center(
                        child: Text(
                          'No places match your search.\n'
                          'Try another search or category.',
                          textAlign: TextAlign.center,
                        ),
                      )
                    : ListView.builder(
                        itemCount: places.length,
                        itemBuilder: (context, index) {
                          Place place = places[index];

                          return PlaceCard(
                            place: place,
                            onDetailsTap: openDetails == null
                                ? null
                                : () {
                                    openDetails(place);
                                  },
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