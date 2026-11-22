import 'package:flutter/material.dart';
import '../shared/general_style.dart';
import '../widgets/ui_components.dart';
import '../data/preview_data.dart';
import '../widgets/place_card.dart';
import '../widgets/activity_card.dart';

class PlacesActivitiesPage extends StatelessWidget {
  const PlacesActivitiesPage({super.key});

  void placeholder(BuildContext context, String title) {
    Navigator.push(
        context,
        MaterialPageRoute<void>(
            builder: (_) => Scaffold(appBar: AppBar(title: Text(title)))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Places & Activities')),
      body: SafeArea(
          child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionHeading(
                        title: 'Places & Activities',
                        action: 'Add Activity',
                        onPressed: () => placeholder(context, 'Add Activity')),
                    sectionGap,
                    UiPanel(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          const Text('Places on Your Itinerary (3)',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          const Text(
                              'Historic sites and attractions added to your trip from Explore.',
                              style: TextStyle(color: GeneralStyle.muted)),
                          TextButton.icon(
                              onPressed: () => placeholder(
                                  context, 'Add a Place from Explore'),
                              icon: const Icon(Icons.add_location_alt_outlined),
                              label: const Text('Add a Place from Explore')),
                          for (final place in previewPlaces)
                            PlacePreviewCard(place: place),
                        ])),
                    sectionGap,
                    UiPanel(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          const Text('Planned Daily Activities (4)',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          const Text(
                              'Daily plans and packing tips for your trip.',
                              style: TextStyle(color: GeneralStyle.muted)),
                          sectionGap,
                          for (final activity in previewActivities)
                            ActivityPreviewCard(activity: activity),
                        ])),
                  ]))),
    );
  }
}
