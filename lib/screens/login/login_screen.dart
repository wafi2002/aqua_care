import 'package:aqua_care/base/bottom_nav_bar.dart';
import 'package:aqua_care/screens/login/widgets/login_input_fields.dart';
import 'package:aqua_care/screens/login/widgets/social_logins.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore if needed
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;
  bool _showSocialLogins = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.78,
              width: double.infinity,
              child: _buildInputFields(),
            ),
            _buildSocialLogins(),
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
    return LoginInputFields(
      emailController: emailController,
      passwordController: passwordController,
      onRegisterPressed: () {
        // Navigate to the registration screen if needed
      },
      onLoginPressed: () async {
        setState(() {
          _isLoading = true;
          _showSocialLogins = false; // Hide social logins when login starts
        });

        // Handle login using Firebase Authentication
        try {
          UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );

          // Optionally, fetch user data from Firestore if needed
          DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).get();

          // Check if the document exists
          if (userDoc.exists) {
            print("User logged in: ${userDoc['email']}"); // Log user email

            // Navigate to the bottom navigation bar on successful login
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => BottomNavBar()),
            );
          } else {
            // Handle the case where the document does not exist
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('User data does not exist.')),
            );
          }
        } on FirebaseAuthException catch (e) {
          // Handle login errors
          print("Login failed: $e");
          // Optionally, show a snackbar or dialog with the error message
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message ?? "Login failed")));
        } finally {
          setState(() {
            _isLoading = false; // Reset loading state after login
            _showSocialLogins = true; // Show social logins again after login
          });
        }

      },
    );
  }

  Widget _buildSocialLogins() {
    if (!_showSocialLogins) {
      return const SizedBox.shrink(); // Hide social logins when _showSocialLogins is false
    }
    return SocialLogins(
      onFacebookPressed: () {
        // Add your Facebook login logic here
      },
      onGooglePressed: () {
        // Add your Google login logic here
      },
      onOtherPressed: () {
        // Add your other login logic here
      },
    );
  }
}
