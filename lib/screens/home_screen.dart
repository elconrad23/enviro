import 'package:enviroewatch/app_constants/fancybutton.dart';
import 'package:enviroewatch/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as g;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as p;
import '../app_constants/aichatbutton.dart';
import '../app_constants/docbutton.dart';
import '../app_constants/fancybuttoy.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ImagePicker _picker = ImagePicker();

  Future<String?> uploadImageToBackend(File imageFile) async {
    Dio dio = Dio();

    String fileName = p.basename(imageFile.path);

    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(imageFile.path, filename: fileName),
    });

    try {
      final response = await dio.post(
        "http://www.enviroewatch.com/upload", // Firebase function or your Node backend
        data: formData,
        options: Options(
          headers: {
            "Content-Type": "multipart/form-data",
            // You can pass a Firebase Auth token if needed
          },
        ),
      );

      if (response.statusCode == 200) {
        final result = response.data['prediction'] as String?;
        return result;
      }
    } catch (e) {
      // print("Upload error: $e");
    }
    return null;
  }

  Future<void> _pickAndAnalyze() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked == null || !mounted) return;

    final file = File(picked.path);
    final prediction = await uploadImageToBackend(file);

    if (prediction != null && mounted) {
      Navigator.pushNamed(
        context,
        '/analysis',
        arguments: {
          'imagePath': file.path,
          'result': prediction,
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to get prediction.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 15),
              Image.asset('/images/logo.png', height: 100),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GradientUploadButton(onPressed: _pickAndAnalyze),
                  SizedBox(width: 15),
                  FloatingActionButton(
                    onPressed: _pickAndAnalyze,
                    tooltip: 'Pick Image',
                    child: Icon(Icons.camera_alt),
                  ),
                  SizedBox(width: 15),
                  GradientUploadButto(onPressed: _pickAndAnalyze),
                ],
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DocumentUploadButton(onPressed: _pickAndAnalyze),
                  SizedBox(width: 15),
                  FloatingActionButton(
                    onPressed: _pickAndAnalyze,
                    tooltip: 'Pick Document',
                    child: Icon(Icons.description_outlined),
                  ),
                  SizedBox(width: 15),
                  Aichatbutton(
                    onPressed:() => { g.Get.to(ChatBotScreen())}),
                ],
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
