import 'package:flutter/material.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextTheme textTheme(Color color) {
    return TextTheme(
      displayLarge: TextStyle(
        fontSize: 44,
        fontWeight: FontWeight.w800,
        height: 1.1,
        letterSpacing: -1.2,
        color: color,
      ),
      displayMedium: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w700,
        height: 1.15,
        letterSpacing: -0.5,
        color: color,
      ),
      displaySmall: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w700,
        height: 1.2,
        color: color,
      ),
      headlineMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 1.3,
        color: color,
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.3,
        color: color,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        height: 1.7,
        letterSpacing: 0.1,
        color: color.withOpacity(0.9),
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        height: 1.6,
        letterSpacing: 0.1,
        color: color.withOpacity(0.7),
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.2,
        color: color,
      ),
    );
  }
}
