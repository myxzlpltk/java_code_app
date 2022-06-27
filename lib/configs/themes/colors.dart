import 'package:flutter/material.dart';

class AppColor {
  AppColor._();

  /// Regular Color
  static const Color blueColor = Color(0xFF009AAD);
  static const Color darkBlueColor = Color(0xFF00717F);

  static const Color redColor = Color(0xFFE62129);
  static const Color darkRedColor = Color(0xFFD90000);

  static const Color greenColor = Color(0xFF009C48);

  static const Color yellowColor = Color(0xFFFFAC01);

  static const Color darkColor = Color(0xFF1E1E1E);
  static const Color darkColor2 = Color(0xFF2E2E2E);
  static const Color darkColor3 = Color(0xFF8D8D8D);
  static const Color darkColor4 = Color(0xFF929292);

  static const Color greyColor = Color(0xFFAFAFAF);
  static const Color greyColor2 = Color(0xFFC2C2C2);
  static const Color greyColor3 = Color(0xFFC4C4C4);

  static const Color lightColor = Color(0xFFDFDFDF);
  static const Color lightColor2 = Color(0xFFF6F6F6);
  static const Color lightColor3 = Color(0xFFF0F0F0);

  static const Color orangeColor = Color(0xFFFFC700);
  static const Color darkOrangeColor = Color(0xFFFF9900);

  /// Linear Gradient Color
  static const LinearGradient orangeGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColor.orangeColor,
      AppColor.darkOrangeColor,
    ],
  );
}
