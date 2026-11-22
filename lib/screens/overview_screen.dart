import 'package:flutter/material.dart';
import 'eo_weather_card.dart';
import '../ab_alara/ab_theme.dart';
import '../ss_seyma/ss_trip_model.dart';

class OverviewScreen extends StatelessWidget {
  final Trip? trip;
  final void Function()? onPackTap;
  final void Function()? onBudgetTap;

  const OverviewScreen({
    super.key,
    this.trip,
    this.onPackTap,
    this.onBudgetTap,
  });

  @override
  Widget build(BuildContext context) {
    final title = trip?.title ?? 'Antalya Trip';
    final dates = trip != null ? '${trip!.startDate} - ${trip!.endDate}' : 'June 12 - June 18';
    final destination = trip != null ? '${trip!.destination}, ${trip!.country}' : 'Antalya Coast';
    final packedStatus = trip != null ? '${trip!.packedCount}/${trip!.packingList.length} Items Packed' : '40% Packed';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  const Text(
                    'Trip Tabs:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.navy,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: onPackTap,
                    icon: const Icon(Icons.luggage_outlined, size: 16),
                    label: const Text('Pack'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: onBudgetTap,
                    icon: const Icon(Icons.attach_money_rounded, size: 16),
                    label: const Text('Budget'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Trip Overview',
                style: AppText.heading,
              ),
              const SizedBox(height: 12),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.calendar_month, color: AppColors.teal, size: 18),
                          const SizedBox(width: 8),
                          Text(dates, style: AppText.bodyBold),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(Icons.location_on, color: AppColors.teal, size: 18),
                          const SizedBox(width: 8),
                          Text('Destination: $destination', style: AppText.body),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(Icons.check_circle_outline, color: AppColors.teal, size: 18),
                          const SizedBox(width: 8),
                          Text('Status: $packedStatus', style: AppText.body),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Weather Forecast',
                style: AppText.heading,
              ),
              const SizedBox(height: 12),
              const WeatherCard(),
              const SizedBox(height: 16),
              const Text(
                'Weather data influences your packing suggestions. '
                'For example, sunscreen is recommended for sunny weather.',
                style: AppText.body,
              ),
              const SizedBox(height: 12),
              const Text(
                'Sample data for the UI prototype.',
                style: TextStyle(fontSize: 12, color: AppColors.muted),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
