import 'package:flutter/material.dart';
import '../ab_alara/ab_theme.dart';
import '../ab_alara/ab_packing_checklist_page.dart';
import '../ab_alara/ab_places_activities_page.dart';
import '../eo_enes/eo_overview_screen.dart';
import '../ss_seyma/ss_budget_tab.dart';
import '../ss_seyma/ss_trip_model.dart';

/// Unified Trip Detail Hub Screen
/// Connects all core features inside a single active journey:
/// - Overview & Weather (Enes Özcan - eo_)
/// - Packing Checklist (Alara Bilik - ab_)
/// - Budget & Expenses (Şeyma Şahin - ss_)
class TripDetailHubScreen extends StatefulWidget {
  final Trip trip;
  final int initialIndex;

  const TripDetailHubScreen({
    super.key,
    required this.trip,
    this.initialIndex = 0,
  });

  @override
  State<TripDetailHubScreen> createState() => _TripDetailHubScreenState();
}

class _TripDetailHubScreenState extends State<TripDetailHubScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: widget.initialIndex,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _goToTab(int index) {
    _tabController.animateTo(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.trip.title,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: AppColors.navy,
              ),
            ),
            Text(
              '${widget.trip.destination}, ${widget.trip.country}',
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.teal,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Places & Activities',
            icon: const Icon(Icons.place_outlined, color: AppColors.teal),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PlacesActivitiesPage(),
                ),
              );
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.teal,
          unselectedLabelColor: AppColors.muted,
          indicatorColor: AppColors.teal,
          indicatorWeight: 3,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          tabs: const [
            Tab(
              icon: Icon(Icons.cloud_queue_rounded, size: 20),
              text: 'Overview & Weather',
            ),
            Tab(
              icon: Icon(Icons.checklist_rounded, size: 20),
              text: 'Packing Checklist',
            ),
            Tab(
              icon: Icon(Icons.account_balance_wallet_outlined, size: 20),
              text: 'Budget Tracking',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // 1. Overview & Weather Screen (Enes)
          OverviewScreen(
            trip: widget.trip,
            onPackTap: () => _goToTab(1),
            onBudgetTap: () => _goToTab(2),
          ),

          // 2. Packing Checklist Screen (Alara)
          PackingChecklistPage(
            initialItems: widget.trip.packingList,
          ),

          // 3. Budget & Expenses Screen (Şeyma)
          BudgetTab(
            trip: widget.trip,
          ),
        ],
      ),
    );
  }
}
