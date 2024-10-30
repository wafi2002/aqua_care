import 'package:aqua_care/base/res/styles/app_styles.dart';
import 'package:flutter/material.dart';

class AppDoubleText extends StatelessWidget {
  const AppDoubleText({
    super.key,
    required this.bigText,
    required this.smallText,
    required this.func,
  });

  final String bigText;
  final String smallText;
  final VoidCallback? func;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(bigText, style: AppStyles.headLineStyle3),
        InkWell(
          onTap: func,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), // Add padding around the text
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8), // Rounded corners
            ),
            child: Text(
              smallText,
              style: AppStyles.textStyle.copyWith(
                color: AppStyles.primaryColor, // Text color
              ),
            ),
          ),
        ),
      ],
    );
  }
}
