import 'package:flutter/material.dart';
import '../widgets/weather_card.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({
    super.key,
    this.onPackTap,
    this.onBudgetTap,
  });

  // these functions will open the other trip screens
  final void Function()? onPackTap;
  final void Function()? onBudgetTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Antalya Trip'),
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
                    'Overview',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: onPackTap,
                    child: const Text('Pack'),
                  ),
                  ElevatedButton(
                    onPressed: onBudgetTap,
                    child: const Text('Budget'),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Trip Overview',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              const Card(
                elevation: 3,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('June 12 - June 18'),
                      SizedBox(height: 12),
                      Text('Destination: Antalya Coast'),
                      SizedBox(height: 12),
                      Text('Status: 40% Packed'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Weather Forecast',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              const WeatherCard(),
              const SizedBox(height: 16),
              const Text(
                'Weather data influences your packing suggestions. '
                'For example, sunscreen is recommended for sunny weather.',
              ),
              const SizedBox(height: 12),
              const Text(
                'Sample data for the UI prototype.',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}