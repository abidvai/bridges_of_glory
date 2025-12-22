import 'package:flutter/cupertino.dart';

class AppColors {
  AppColors._();

  static const Color black = Color(0xFF070709);
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFFD53F33), Color(0xFF990B00)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.5, 1],
  );
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceBg = Color(0xFFFBFBFB);
  static const Color secondary = Color(0xFFFBECEB);
  static const Color text = Color(0xFF202020);
  static const Color textSecondary = Color(0xFF4A4A4A);
  static const Color hintText = Color(0xFFAEAEAE);
  static const Color border = Color(0xFF919191);
  static const Color red = Color(0xFFD53F33);
  static const Color surfaceSecondary = Color(0xFFFBFBFB);
  static const Color containerBg = Color(0xFFFBEDE6);
  static const Color yellowish = Color(0xFFECA7A1);
  static const Color blueish = Color(0xFFF2F6FF);
}
