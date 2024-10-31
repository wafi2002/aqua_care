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

            // Show success dialog
            _showSuccessDialog();
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
        } finally {
          setState(() {
            _isLoading = false; // Reset loading state after registration
          });
        }
      },
      onLoginPressed: () {
        Navigator.pop(context);
      },
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 80,
                ),
                const SizedBox(height: 16),
                const Text(
                  "Registration Successful",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Your account has been created successfully!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()), // Navigate to login screen
                    );
                  },
                  child: const Text(
                    "OK",
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        );
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
