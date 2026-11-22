import 'package:flutter/material.dart';
import '../main.dart';
import '../widgets/shared_widgets.dart';

class MyTripsPage extends StatelessWidget {
  final VoidCallback onCreateTrip;

  const MyTripsPage({super.key, required this.onCreateTrip});

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
                  const SectionPill('Gezilerim', light: false),
                  const SizedBox(height: 8),
                  const Text(
                    'Planlanan & Aktif\\nSeyahatlerim',
                    style: TextStyle(
                      color: AppColors.navy,
                      fontSize: 23,
                      height: 1.08,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 7),
                  const Text(
                    'Tüm seyahatlerinizi, valiz hazırlık durumunuzu ve bütçenizi tek ekrandan yönetin.',
                    style: TextStyle(color: AppColors.muted, fontSize: 12, height: 1.35),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: onCreateTrip,
                      icon: const Icon(Icons.add, size: 17),
                      label: const Text('Yeni Gezi Planla'),
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
            const _ActiveTripCard(
              city: 'Roma, İtalya',
              title: 'Roma Kaçamağı 2025',
              dates: '2025-05-10  -  2025-05-16',
              progress: 0.73,
              progressText: '%73 Hazır (11/15 Eşya)',
              budget: '€878 / €1200',
              places: '3 Mekan • 4 Aktivite',
            ),
            const SizedBox(height: 18),
            const _ActiveTripCard(
              city: 'Paris, Fransa',
              title: 'Paris Yaz Tatili',
              dates: '2025-07-01  -  2025-07-07',
              progress: 0.40,
              progressText: '%40 Hazır (6/15 Eşya)',
              budget: '€450 / €1000',
              places: '2 Mekan • 3 Aktivite',
            ),
          ],
        ),
        Positioned(
          right: 18,
          bottom: 20,
          child: FloatingActionButton(
            onPressed: onCreateTrip,
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
  final String city;
  final String title;
  final String dates;
  final double progress;
  final String progressText;
  final String budget;
  final String places;

  const _ActiveTripCard({
    required this.city,
    required this.title,
    required this.dates,
    required this.progress,
    required this.progressText,
    required this.budget,
    required this.places,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                PlaceholderPhoto(label: title, height: 166),
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                    child: const Text('✦ Devam Ediyor / Geçmiş', style: TextStyle(color: AppColors.tealDark, fontSize: 10, fontWeight: FontWeight.bold)),
                  ),
                ),
                Positioned(
                  right: 12,
                  top: 12,
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.black45,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      icon: const Icon(Icons.archive_outlined, color: Colors.white, size: 17),
                    ),
                  ),
                ),
                Positioned(
                  left: 13,
                  bottom: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(city, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700, shadows: [Shadow(color: Colors.black87, blurRadius: 5)])),
                      Text(dates, style: const TextStyle(color: Colors.white, fontSize: 10, shadows: [Shadow(color: Colors.black87, blurRadius: 5)])),
                    ],
                  ),
                ),
              ],
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
                        Row(
                          children: [
                            const Icon(Icons.luggage, color: AppColors.teal, size: 16),
                            const SizedBox(width: 7),
                            const Text('Valiz Hazırlığı:', style: TextStyle(color: AppColors.muted, fontSize: 11)),
                            const Spacer(),
                            Text(progressText, style: const TextStyle(color: AppColors.tealDark, fontSize: 10, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 7),
                        LinearProgressIndicator(value: progress, minHeight: 6, borderRadius: BorderRadius.circular(10), color: AppColors.teal, backgroundColor: const Color(0xFFDCEBE8)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.account_balance_wallet_outlined, color: AppColors.teal, size: 17),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('BÜTÇE DURUMU', style: TextStyle(color: AppColors.muted, fontSize: 9, fontWeight: FontWeight.bold)),
                          Text(budget, style: const TextStyle(color: AppColors.navy, fontSize: 11, fontWeight: FontWeight.w800)),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
                        decoration: BoxDecoration(color: const Color(0xFFF0F4F8), borderRadius: BorderRadius.circular(20)),
                        child: Text(places, style: const TextStyle(color: AppColors.muted, fontSize: 9, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_forward, size: 16),
                      label: const Text('Gezi Detay Merkezini Aç (Hava, Valiz, Bütçe)', style: TextStyle(fontSize: 10)),
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
