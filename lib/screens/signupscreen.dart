import 'package:enviroewatch/screens/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _handleSignUp() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

  try {
    final userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (userCredential.user != null) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text("Account created successfully!")),
      // );
      Get.to(ProfileScreen());
    }
  } on FirebaseAuthException catch (e) {
    String message = "Signup failed";
    if (e.code == 'email-already-in-use') {
      message = "This email is already in use.";
    } else if (e.code == 'weak-password') {
      message = "The password is too weak.";
    } else if (e.code == 'invalid-email') {
      message = "The email is invalid.";
    }

    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(content: Text(message)),
    // );
  } catch (e) {
    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(content: Text("An error occurred.")),
    // );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: "Password"),
                obscureText: true,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _handleSignUp,
                child: const Text("Sign Up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
