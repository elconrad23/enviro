import 'package:flutter/material.dart';
import 'package:flutter_image_widget/flutter_image_widget.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Image.asset('/images/logo.png',
            height: 80,
            width: 80,),
            SizedBox(height: 20),
            Text(
              'About Enviro-ewatch',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Enviro-ewatch is an app that allows users to upload or take photos of landscapes for monitoring. '
              'These images are then analyzed to detect environmental hazards, pollution, or waste levels, and the results are displayed to help promote a cleaner environment.',
              style: TextStyle(fontFamily: 'RobotoMono', fontSize: 16),
            ),
            SizedBox(height: 10),
            FlutterImageWidget(
              height: 100,
              width: 100,
              imageAssetPath: "/images/rec.png",
              radius: BorderRadius.circular(20),
            ),
            SizedBox(height: 10),
            FlutterImageWidget(
              height: 100,
              width: 100,
              imageAssetPath: "/images/getsteps.png",
              radius: BorderRadius.circular(20),
            ),
          ],
        ),
      ),
    );
  }
}
