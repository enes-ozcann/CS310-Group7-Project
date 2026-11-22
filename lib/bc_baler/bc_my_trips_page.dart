import 'package:flutter/material.dart';
import '../ab_alara/ab_theme.dart';
import '../ab_alara/ab_preview_data.dart';
import 'bc_shared_widgets.dart';
import 'bc_trip_detail_hub_screen.dart';
import '../ss_seyma/ss_trip_model.dart';
import '../ss_seyma/ss_expense_model.dart';

class MyTripsPage extends StatefulWidget {
  final VoidCallback onCreateTrip;

  const MyTripsPage({super.key, required this.onCreateTrip});

  @override
  State<MyTripsPage> createState() => _MyTripsPageState();
}

class _MyTripsPageState extends State<MyTripsPage> {
  late final List<Trip> trips;

  @override
  void initState() {
    super.initState();
    // Default active trips connecting all member modules
    trips = [
      Trip(
        id: 'trip-antalya',
        title: 'Antalya Beach Holiday',
        destination: 'Antalya',
        country: 'Turkey',
        startDate: 'June 12',
        endDate: 'June 18',
        daysToGo: 14,
        imageUrl: 'assets/images/rome.png',
        totalBudget: 1500,
        currency: '€',
        expenses: [
          const Expense(
            id: 'e1',
            title: 'Hotel Reservation',
            amount: 600,
            category: ExpenseCategory.accommodation,
            date: 'May 10, 2026',
            notes: '4-Star Beachfront Hotel',
          ),
          const Expense(
            id: 'e2',
            title: 'Flight Ticket',
            amount: 280,
            category: ExpenseCategory.transport,
            date: 'May 12, 2026',
            notes: 'Round-Trip',
          ),
          const Expense(
            id: 'e3',
            title: 'Mediterranean Dinner',
            amount: 85,
            category: ExpenseCategory.food,
            date: 'Jun 13, 2026',
          ),
        ],
        packingList: createPackingItems(),
        savedPlaces: previewPlaces,
        itinerary: const [],
        currentTemp: 32,
        weatherCondition: 'Sunny / Clear',
        weatherTips: ['Remember to bring sunscreen and a hat.'],
      ),
      Trip(
        id: 'trip-paris',
        title: 'Paris Autumn Trip',
        destination: 'Paris',
        country: 'France',
        startDate: 'October 1',
        endDate: 'October 7',
        daysToGo: 45,
        imageUrl: 'assets/images/paris.png',
        totalBudget: 2000,
        currency: '€',
        expenses: [
          const Expense(
            id: 'e4',
            title: 'Boutique Hotel',
            amount: 750,
            category: ExpenseCategory.accommodation,
            date: 'Sep 01, 2026',
          ),
          const Expense(
            id: 'e5',
            title: 'Louvre Museum Ticket',
            amount: 45,
            category: ExpenseCategory.activities,
            date: 'Sep 15, 2026',
          ),
        ],
        packingList: createPackingItems(),
        savedPlaces: previewPlaces,
        itinerary: const [],
        currentTemp: 19,
        weatherCondition: 'Cloudy / Mild Rain',
        weatherTips: ['Umbrella and light jacket recommended.'],
      ),
    ];
  }

  void _openTripDetail(Trip trip) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TripDetailHubScreen(trip: trip),
      ),
    ).then((_) {
      setState(() {}); // Refresh upon return to update budget/pack counters
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 95),
          children: [
            PageCard(
              padding: const EdgeInsets.all(17),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionPill('My Trips', light: false),
                  const SizedBox(height: 8),
                  const Text(
                    'Planned & Active\nJourneys',
                    style: TextStyle(
                      color: AppColors.navy,
                      fontSize: 23,
                      height: 1.08,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 7),
                  const Text(
                    'Manage all your trips, packing progress, and budget from a single screen.',
                    style: TextStyle(color: AppColors.muted, fontSize: 12, height: 1.35),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: widget.onCreateTrip,
                      icon: const Icon(Icons.add, size: 17),
                      label: const Text('Plan New Trip'),
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.teal,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            for (final trip in trips) ...[
              _ActiveTripCard(
                trip: trip,
                onTap: () => _openTripDetail(trip),
              ),
              const SizedBox(height: 18),
            ],
          ],
        ),
        Positioned(
          right: 18,
          bottom: 20,
          child: FloatingActionButton(
            onPressed: widget.onCreateTrip,
            backgroundColor: AppColors.teal,
            foregroundColor: Colors.white,
            child: const Icon(Icons.add, size: 30),
          ),
        ),
      ],
    );
  }
}

class _ActiveTripCard extends StatelessWidget {
  final Trip trip;
  final VoidCallback onTap;

  const _ActiveTripCard({
    required this.trip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final packed = trip.packedCount;
    final totalPack = trip.packingList.length;
    final packRatio = totalPack > 0 ? (packed / totalPack) : 0.0;
    final budgetStr = '${trip.currency}${trip.totalSpent.toStringAsFixed(0)} / ${trip.currency}${trip.totalBudget.toStringAsFixed(0)}';

    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: onTap,
              child: Stack(
                children: [
                  PlaceholderPhoto(label: trip.title, height: 166),
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                      child: const Text('✦ Active Trip', style: TextStyle(color: AppColors.tealDark, fontSize: 10, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Positioned(
                    left: 13,
                    bottom: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${trip.destination}, ${trip.country}', style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700, shadows: [Shadow(color: Colors.black87, blurRadius: 5)])),
                        Text('${trip.startDate} - ${trip.endDate}', style: const TextStyle(color: Colors.white, fontSize: 11, shadows: [Shadow(color: Colors.black87, blurRadius: 5)])),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: const Color(0xFFF6F8FB), borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: 7,
                          runSpacing: 4,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            const Icon(Icons.luggage, color: AppColors.teal, size: 16),
                            const SizedBox(width: 7),
                            const Text('Packing Progress:', style: TextStyle(color: AppColors.muted, fontSize: 11)),
                            Text('$packed/$totalPack Items (${(packRatio * 100).round()}%)', style: const TextStyle(color: AppColors.tealDark, fontSize: 10, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 7),
                        LinearProgressIndicator(
                          value: packRatio,
                          minHeight: 6,
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.teal,
                          backgroundColor: const Color(0xFFDCEBE8),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Icon(Icons.account_balance_wallet_outlined, color: AppColors.teal, size: 17),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('BUDGET STATUS', style: TextStyle(color: AppColors.muted, fontSize: 9, fontWeight: FontWeight.bold)),
                          Text(budgetStr, style: const TextStyle(color: AppColors.navy, fontSize: 11, fontWeight: FontWeight.w800)),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
                        decoration: BoxDecoration(color: const Color(0xFFF0F4F8), borderRadius: BorderRadius.circular(20)),
                        child: Text('${trip.savedPlaces.length} Places • ${trip.weatherCondition}', style: const TextStyle(color: AppColors.muted, fontSize: 9, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: onTap,
                      icon: const Icon(Icons.arrow_forward, size: 16),
                      label: const Text('Open Trip Hub (Weather, Pack, Budget)', style: TextStyle(fontSize: 11)),
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.navy,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
