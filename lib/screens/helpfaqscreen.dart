import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpScreen extends StatelessWidget {
  HelpScreen({super.key});
  final List<Map<String, String>> faqs = [
    {
      "question": "What is the prurpose of Enviro-ewatch?",
      "answer": "Enviro-ewatch is an AI-powered app that analyzes environmental images to detect and monitor conditions like crop health, pollution, and land use, helping the communities and the government to plan for sustainable land use."
    },
    {
      "question": "How do I contribute an image?",
      "answer": "Tap the upload or camera button on the home screen, then select or capture an image. It will automatically be analyzed and results will be shown."
    },
    {
      "question": "What types of images work best?",
      "answer": "Clear, well-lit images taken outdoors with visible land, crops, or natural features yield the best results."
    },
    {
      "question": "Is internet required for analysis?",
      "answer": "Yes, internet is required as the app sends the image to a backend server for AI-based analysis."
    },
    {
      "question": "Where can I see the analysis results?",
      "answer": "After uploading, you're taken to the Analysis screen which displays both the image and the AI’s prediction."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      appBar: AppBar(
        title: Text('Echo-tourism'),
        leading: OutlinedButton(onPressed: () => {Get.back()}, 
          child: Icon(Icons.arrow_back_ios_new_outlined)),
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: faqs.length,
          itemBuilder: (context, index) {
            final faq = faqs[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 6),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ExpansionTile(
                tilePadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                title: Text(
                  faq["question"]!,
                  style: TextStyle(
                    fontFamily: 'RobotoMono',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Text(
                      faq["answer"]!,
                      style: TextStyle(fontFamily: 'RobotoMono', fontSize: 14),
                    ),
                  ),
                ],
              ),
        );}
      )),
    );
  }
}