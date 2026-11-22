import 'package:flutter/material.dart';
import '../main.dart';

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
          onPressed: () {},
          icon: const Icon(Icons.layers_outlined, color: AppColors.muted),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: CircleAvatar(
            radius: 15,
            backgroundColor: const Color(0xFFE9EEF7),
            child: const Icon(Icons.person, color: AppColors.navy, size: 19),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.logout, color: AppColors.muted, size: 19),
        ),
        const SizedBox(width: 5),
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
      height: 64,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 4,
      selectedIndex: selectedIndex.clamp(0, 2),
      onDestinationSelected: onTap,
      indicatorColor: const Color(0xFFE3F7F3),
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.explore_outlined),
          selectedIcon: Icon(Icons.explore, color: AppColors.teal),
          label: 'Keşfet',
        ),
        NavigationDestination(
          icon: Icon(Icons.luggage_outlined),
          selectedIcon: Icon(Icons.luggage, color: AppColors.teal),
          label: 'Gezilerim',
        ),
        NavigationDestination(
          icon: Icon(Icons.archive_outlined),
          selectedIcon: Icon(Icons.archive, color: AppColors.teal),
          label: 'Arşiv',
        ),
      ],
    );
  }
}

class SectionPill extends StatelessWidget {
  final String text;
  final bool light;

  const SectionPill(this.text, {super.key, this.light = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
      decoration: BoxDecoration(
        color: light ? Colors.white : AppColors.navy,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: light ? AppColors.tealDark : Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class PlaceholderPhoto extends StatelessWidget {
  final String label;
  final double height;

  const PlaceholderPhoto({
    super.key,
    required this.label,
    this.height = 160,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF8CCDD7), Color(0xFF477F99), Color(0xFF243B55)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          const Positioned(
            right: 22,
            top: 20,
            child: Icon(Icons.location_city, color: Colors.white24, size: 92),
          ),
          Positioned(
            left: 14,
            bottom: 12,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 19,
                shadows: [Shadow(color: Colors.black54, blurRadius: 8)],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PageCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const PageCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(color: Color(0x18000000), blurRadius: 12, offset: Offset(0, 5)),
        ],
      ),
      child: child,
    );
  }
}
