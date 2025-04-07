import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Image.asset('/images/logo.png', height: 120),
            SizedBox(height: 20),
            Text(
              'About Enviro-Ewatch',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Enviro-Ewatch is an app that allows users to upload or take photos of their environment. '
              'These images are then analyzed to detect environmental hazards, pollution, or waste levels, and the results are displayed to help promote a cleaner environment.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
