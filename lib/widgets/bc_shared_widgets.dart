import 'package:flutter/material.dart';
import '../ab_alara/ab_theme.dart';
import '../ne_nehir/ne_main.dart';

class SmartPackAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SmartPackAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(58);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 0,
      titleSpacing: 16,
      title: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: AppColors.teal,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.luggage, color: Colors.white, size: 21),
          ),
          const SizedBox(width: 9),
          const Text(
            'smartPack',
            style: TextStyle(
              color: AppColors.tealDark,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          tooltip: 'Log Out',
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false,
            );
          },
          icon: const Icon(Icons.logout_rounded, color: AppColors.muted),
        ),
      ],
    );
  }
}

class SmartPackBottomNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const SmartPackBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: onTap,
      backgroundColor: Colors.white,
      indicatorColor: AppColors.tealLight,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.explore_outlined),
          selectedIcon: Icon(Icons.explore, color: AppColors.teal),
          label: 'Explore',
        ),
        NavigationDestination(
          icon: Icon(Icons.luggage_outlined),
          selectedIcon: Icon(Icons.luggage, color: AppColors.teal),
          label: 'My Trips',
        ),
        NavigationDestination(
          icon: Icon(Icons.archive_outlined),
          selectedIcon: Icon(Icons.archive, color: AppColors.teal),
          label: 'Archive',
        ),
      ],
    );
  }
}

class PageCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const PageCard({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: AppColors.cardBorder, width: 1),
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}

class SectionPill extends StatelessWidget {
  final String text;
  final bool light;

  const SectionPill(this.text, {super.key, this.light = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: light ? AppColors.tealLight : AppColors.teal,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: light ? AppColors.tealDark : Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class PlaceholderPhoto extends StatelessWidget {
  final String label;
  final double height;

  const PlaceholderPhoto({super.key, required this.label, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.tealLight,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Icon(Icons.landscape, size: 64, color: AppColors.teal),
          Positioned(
            bottom: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                label,
                style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
