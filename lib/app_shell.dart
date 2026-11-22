import 'package:flutter/material.dart';
import 'main.dart';
import 'screens/my_trips_page.dart';
import 'screens/archive_page.dart';
import 'screens/new_trip_page.dart';
import 'widgets/shared_widgets.dart';

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

  @override
  Widget build(BuildContext context) {
    final pages = [
      const ExplorePlaceholderPage(),
      MyTripsPage(onCreateTrip: () => openTab(3)),
      const ArchivePage(),
      NewTripPage(onBack: () => openTab(1)),
    ];

    return Scaffold(
      appBar: const SmartPackAppBar(),
      body: SafeArea(
        top: false,
        child: IndexedStack(
          index: selectedIndex,
          children: pages,
        ),
      ),
      bottomNavigationBar: SmartPackBottomNav(
        selectedIndex: selectedIndex == 3 ? 1 : selectedIndex,
        onTap: openTab,
      ),
    );
  }
}

class ExplorePlaceholderPage extends StatelessWidget {
  const ExplorePlaceholderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Keşfet',
        style: TextStyle(
          color: AppColors.navy,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
