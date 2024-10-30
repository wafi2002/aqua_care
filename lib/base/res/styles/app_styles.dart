import 'package:flutter/material.dart';

Color deepSkyBlue = const Color(0xFF00BFFF);

class AppStyles {
  static Color primaryColor = deepSkyBlue;
  static Color skyBlue = const Color(0xFF87CEEB);
  static Color textColor = const Color(0xFFFFFFFF);
  static Color mintGreen = const Color(0xFF3EB489);
  static Color lightMint = const Color(0xFF76E2C6);

  static TextStyle textStyle =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: textColor);

  static TextStyle headLineStyle1 =
      TextStyle(fontSize: 19, fontWeight: FontWeight.w800, color: textColor);

  static TextStyle headLineStyle2 =
      TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: textColor);

  static TextStyle headLineStyle3 =
      TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textColor);

  static TextStyle headLineStyle4 =
      TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: textColor);

  static TextStyle headLineStyle5 =
      TextStyle(fontSize: 21, fontWeight: FontWeight.bold, color: textColor);
}
