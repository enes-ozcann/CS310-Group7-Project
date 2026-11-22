import 'package:flutter/material.dart';
import '../../theme.dart';
import '../shared/general_style.dart';
import '../widgets/ui_components.dart';
import '../models/activity.dart';

class ActivityPreviewCard extends StatelessWidget {
  const ActivityPreviewCard({super.key, required this.activity});
  final ActivityPreview activity;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0,
        color: const Color(0xFFF7FAF9),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Icon(
                  activity.done
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked,
                  color: AppColors.teal),
              const SizedBox(width: 10),
              Expanded(
                  child: Text(activity.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15))),
            ]),
            const SizedBox(height: 10),
            Wrap(spacing: 8, runSpacing: 8, children: [
              UiBadge(activity.type),
              UiBadge(activity.time, icon: Icons.calendar_today_outlined)
            ]),
            const SizedBox(height: 8),
            Text(activity.location,
                style: const TextStyle(color: GeneralStyle.muted, fontSize: 12)),
            const SizedBox(height: 12),
            Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: GeneralStyle.mint,
                    borderRadius: BorderRadius.circular(10)),
                child: Text('Packing Tip: ${activity.tip}',
                    style:
                        const TextStyle(fontSize: 12, color: AppColors.teal))),
          ]),
        ));
  }
}
