import 'package:aqua_care/base/bottom_nav_bar.dart';
import 'package:aqua_care/screens/login/login_screen.dart';
import 'package:aqua_care/screens/login/widgets/register_input_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.78,
              width: double.infinity,
              child: _buildInputFields(),
            ),
            TextButton(
              onPressed: onLoginPressed,
              child: const Text(
                "Already have an account? Login",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputFields() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return RegisterInputFields(
      emailController: emailController,
      passwordController: passwordController,
      confirmPasswordController: confirmPasswordController,
      onRegisterPressed: () async {
        setState(() {
          _isLoading = true;
        });

        // Register the user
        try {
          if (passwordController.text == confirmPasswordController.text) {
            UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim(),
            );

            // Save user data to Firestore
            await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
              'email': emailController.text.trim(),
              // Add any additional fields here
            });

            print("User registered: ${emailController.text}");

            // Show success message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Registration successful!")),
            );

            // Navigate to another screen (update to your desired screen)
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          } else {
            // Handle password mismatch
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Passwords do not match")),
            );
          }
        } catch (e) {
          print("Registration failed: $e");
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Registration failed: ${e.toString()}")),
          );
        }

      },
      onLoginPressed: () {
        Navigator.pop(context);
      },
    );
  }

  void onLoginPressed() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
