import 'package:flutter/material.dart';

class SocialLogins extends StatelessWidget {
  final VoidCallback onFacebookPressed;
  final VoidCallback onGooglePressed;
  final VoidCallback onOtherPressed;

  const SocialLogins({
    super.key,
    required this.onFacebookPressed,
    required this.onGooglePressed,
    required this.onOtherPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Or sign in with",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 20),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: onFacebookPressed,
                  icon: Image.asset(
                    "assets/images/facebook.png",
                    height: 60,
                    width: 60,
                  ),
                ),
                const SizedBox(width: 20),
                IconButton(
                  onPressed: onGooglePressed,
                  icon: Image.asset(
                    "assets/images/google.png",
                    height: 45,
                    width: 45,
                  ),
                ),
                const SizedBox(width: 20),
                IconButton(
                  onPressed: onOtherPressed,
                  icon: Image.asset(
                    "assets/images/x.png",
                    height: 60,
                    width: 60,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
