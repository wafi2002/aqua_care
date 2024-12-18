import 'package:aqua_care/base/bottom_nav_bar.dart';
import 'package:aqua_care/screens/login/widgets/login_input_fields.dart';
import 'package:aqua_care/screens/login/widgets/social_logins.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  Future<void> _signInWithGoogle() async {
    try {
      setState(() {
        _isLoading = true;
        _showSocialLogins = false; // Hide social logins during sign-in
      });

      // Trigger the Google Sign-In
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        // The user canceled the sign-in
        return;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential for Firebase
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the credential
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      // Navigate to the main screen on success
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BottomNavBar()),
      );
    } catch (e) {
      print("Google sign-in failed: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Google sign-in failed: ${e.toString()}")));
    } finally {
      setState(() {
        _isLoading = false;
        _showSocialLogins = true; // Show social logins again after sign-in
      });
    }
  }

  Future<void> _signInWithFacebook() async {
    try {
      setState(() {
        _isLoading = true;
        _showSocialLogins = false;
      });

      // Trigger the Facebook Login
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        // Get the user's access token
        final AccessToken accessToken = result.accessToken!;

        // Create a credential for Firebase
        final OAuthCredential credential = FacebookAuthProvider.credential(accessToken.tokenString); // Make sure accessToken is defined properly

        // Sign in to Firebase with the credential
        UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

        // Navigate to the main screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BottomNavBar()),
        );
      } else {
        print("Facebook sign-in failed: ${result.message}");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Facebook sign-in failed: ${result.message}")));
      }
    } catch (e) {
      print("Facebook sign-in failed: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Facebook sign-in failed: ${e.toString()}")));
    } finally {
      setState(() {
        _isLoading = false;
        _showSocialLogins = true;
      });
    }
  }


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
        _signInWithFacebook();
      },
      onGooglePressed: () {
        _signInWithGoogle();
      },
      onOtherPressed: () {

      },
    );
  }
}
