import 'package:flutter/material.dart';
import '../main.dart';
import '../widgets/shared_widgets.dart';

class ArchivePage extends StatefulWidget {
  const ArchivePage({super.key});

  @override
  State<ArchivePage> createState() => _ArchivePageState();
}

class _ArchivePageState extends State<ArchivePage> {
  bool showTrip = true;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 24),
      children: [
        PageCard(
          padding: const EdgeInsets.all(17),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SectionPill('Geçmiş Geziler Arşivi'),
              SizedBox(height: 8),
              Text(
                'Tamamlanmış Gezi Arşivi',
                style: TextStyle(color: AppColors.navy, fontSize: 21, fontWeight: FontWeight.w900),
              ),
              SizedBox(height: 5),
              Text(
                'Geçmiş seyahatlerinizin harcamalarını, gezilen yerlerini ve valiz kayıtlarını inceleyin ya da geziyi yeniden aktifleştirin.',
                style: TextStyle(color: AppColors.muted, fontSize: 11, height: 1.35),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        if (showTrip)
          ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      const PlaceholderPhoto(label: 'Barselona Yaz Tatili 2024', height: 155),
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
                          decoration: BoxDecoration(color: AppColors.navy, borderRadius: BorderRadius.circular(20)),
                          child: const Text('Tamamlandı', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const Positioned(
                        left: 13,
                        bottom: 10,
                        child: Text('📍 Barcelona, İspanya   ▢  2024-08-14 - 2024-08-20', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700, shadows: [Shadow(color: Colors.black87, blurRadius: 5)])),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(13),
                          decoration: BoxDecoration(color: const Color(0xFFF6F8FB), borderRadius: BorderRadius.circular(15)),
                          child: const Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('TOPLAM HARCAMA', style: TextStyle(color: AppColors.muted, fontSize: 9)),
                                    SizedBox(height: 4),
                                    Text('€920.00', style: TextStyle(color: AppColors.navy, fontSize: 14, fontWeight: FontWeight.w900)),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('GEZİLEN YER SAYISI', style: TextStyle(color: AppColors.muted, fontSize: 9)),
                                    SizedBox(height: 4),
                                    Text('2 Mekan', style: TextStyle(color: AppColors.tealDark, fontSize: 14, fontWeight: FontWeight.w900)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 13),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () => setState(() => showTrip = false),
                                icon: const Icon(Icons.history, size: 15),
                                label: const Text('Arşivden Çıkar', style: TextStyle(fontSize: 10)),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: AppColors.text,
                                  side: const BorderSide(color: AppColors.border),
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: FilledButton.icon(
                                onPressed: () => showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Gezi Detayları'),
                                    content: const Text('Barselona Yaz Tatili 2024\\n\\nToplam harcama: €920.00\\nGezilen yer: 2 Mekan'),
                                    actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Kapat'))],
                                  ),
                                ),
                                icon: const Icon(Icons.visibility_outlined, size: 15),
                                label: const Text('Detayları Gör', style: TextStyle(fontSize: 10)),
                                style: FilledButton.styleFrom(
                                  backgroundColor: AppColors.teal,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          const PageCard(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text('Arşivde gezi bulunmuyor.', style: TextStyle(color: AppColors.muted)),
              ),
            ),
          ),
      ],
    );
  }
}
