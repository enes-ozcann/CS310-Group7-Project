import 'package:flutter/material.dart';
import '../eo_enes/eo_explore_screen.dart';
import 'bc_my_trips_page.dart';
import 'bc_archive_page.dart';
import 'bc_new_trip_page.dart';
import 'bc_shared_widgets.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int selectedIndex = 1;

  void openTab(int index) {
    setState(() => selectedIndex = index);
  }

  void _openNewTrip() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: const Text('Plan New Trip')),
          body: NewTripPage(onBack: () => Navigator.pop(context)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      // 0: Explore (Enes & Nehir)
      const ExploreScreen(),
      // 1: My Trips (Baler, leading to Hub)
      MyTripsPage(onCreateTrip: _openNewTrip),
      // 2: Archive (Baler)
      const ArchivePage(),
    ];

    return Scaffold(
      appBar: const SmartPackAppBar(),
      body: SafeArea(
        top: false,
        child: IndexedStack(
          index: selectedIndex.clamp(0, pages.length - 1),
          children: pages,
        ),
      ),
      bottomNavigationBar: SmartPackBottomNav(
        selectedIndex: selectedIndex.clamp(0, 2),
        onTap: openTab,
      ),
    );
  }
}
