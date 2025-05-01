import 'package:flutter/material.dart';
import 'dart:io';

class AnalysisScreen extends StatelessWidget {
  const AnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
 // Safely retrieve the arguments
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    // Check if arguments are passed properly
    if (args == null || !args.containsKey('imagePath') || !args.containsKey('result')) {
      return Scaffold(
        body: Center(
          child: Text('No data found. Please try again.'),
        ),
      );
    }
    final String imagePath = args['imagePath'];
    final String result = args['result'];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.file(File(imagePath), height: 250),
            const SizedBox(height: 20),
            const Text('Prediction:',
              style: TextStyle(
                fontFamily: 'RobotoMono', fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: TextEditingController(text: result),
              readOnly: true,
              maxLines: null,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
