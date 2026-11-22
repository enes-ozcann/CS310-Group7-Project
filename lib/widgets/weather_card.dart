import 'package:flutter/material.dart';

// sample weather information for the UI
class WeatherCard extends StatelessWidget {
  const WeatherCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              '☀',
              style: TextStyle(fontSize: 56),
            ),
            SizedBox(height: 12),
            Text(
              'Sunny / Clear',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            Wrap(
              spacing: 20,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: [
                Text('High: 32°C'),
                Text('Low: 22°C'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}