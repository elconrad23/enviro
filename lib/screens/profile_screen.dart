import 'package:enviroewatch/screens/login_screen.dart';
import 'package:enviroewatch/screens/signupscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: isLoggedIn
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Enviroewatch user',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isLoggedIn = false;
                        });
                      },
                      child: const Text('Logout'),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('You are not logged in.',
                        style: TextStyle(fontSize: 18)),
                    const SizedBox(height: 20),
                    OutlinedButton(
                      onPressed: () {
                        Get.to(LoginScreen());
                      },
                      child: const Text('Login'),
                    ),
                    const SizedBox(height: 10),
                    OutlinedButton(
                      onPressed: () {
                        Get.to(SignUpScreen());
                      },
                      child: const Text('Sign Up'),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
