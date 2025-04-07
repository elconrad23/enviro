import 'package:enviroewatch/app_constants/fancybutton.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as p;
import '../app_constants/fancybuttoy.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ImagePicker _picker = ImagePicker();

Future<void> uploadImageToBackend(File imageFile) async {
  Dio dio = Dio();

  String fileName = p.basename(imageFile.path);

  FormData formData = FormData.fromMap({
    "file": await MultipartFile.fromFile(imageFile.path, filename: fileName),
  });

  try {
    final response = await dio.post(
      "https://your-backend-api.com/upload", // Firebase function or your Node backend
      data: formData,
      options: Options(
        headers: {
          "Content-Type": "multipart/form-data",
          // You can pass a Firebase Auth token if needed
        },
      ),
    );

    print("Upload success: ${response.data}");
  } catch (e) {
    print("Upload error: $e");
  }
}

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null && mounted) {
    File imageFile = File(pickedFile.path);
    await uploadImageToBackend(imageFile);
      Navigator.pushNamed(context, '/analysis', arguments: pickedFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('/images/logo.png', height: 100),
            SizedBox(height: 20),
            Text(
              'Welcome to Enviro-Ewatch',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20,),
            GradientUploadButton(onPressed: _pickImage),
            SizedBox(height: 30),
            GradientUploadButto(onPressed: _pickImage),
            SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                // Optional: trigger camera here
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, // text/icon color
                backgroundColor: Color.fromARGB(255, 11, 159, 6), // button background
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              icon: Icon(Icons.upload),
              label: Text('Upload Document'),
            ),
          ],
        ),
      ),
    );
  }
}
