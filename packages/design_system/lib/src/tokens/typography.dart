import 'package:flutter/material.dart';

import 'fonts.dart';

abstract final class AppTypography {
  static const FontWeight WEIGHT_REGULAR = FontWeight.w400;
  static const FontWeight WEIGHT_MEDIUM = FontWeight.w500;
  static const FontWeight WEIGHT_SEMI_BOLD = FontWeight.w600;
  static const FontWeight WEIGHT_BOLD = FontWeight.w700;

  static TextTheme createTextTheme({
    String displayFontFamily = AppFonts.displayFont,
    String bodyFontFamily = AppFonts.bodyFont,
    Color? defaultColor,
  }) {
    return TextTheme(
      displayLarge: TextStyle(
        fontFamily: displayFontFamily,
        fontSize: 57,
        fontWeight: WEIGHT_BOLD,
        letterSpacing: -0.25,
        height: 1.12,
        color: defaultColor,
      ),
      displayMedium: TextStyle(
        fontFamily: displayFontFamily,
        fontSize: 45,
        fontWeight: WEIGHT_BOLD,
        letterSpacing: 0,
        height: 1.15,
        color: defaultColor,
      ),
      displaySmall: TextStyle(
        fontFamily: displayFontFamily,
        fontSize: 36,
        fontWeight: WEIGHT_SEMI_BOLD,
        letterSpacing: 0,
        height: 1.22,
        color: defaultColor,
      ),

      headlineLarge: TextStyle(
        fontFamily: displayFontFamily,
        fontSize: 32,
        fontWeight: WEIGHT_SEMI_BOLD,
        letterSpacing: 0,
        height: 1.25,
        color: defaultColor,
      ),
      headlineMedium: TextStyle(
        fontFamily: displayFontFamily,
        fontSize: 28,
        fontWeight: WEIGHT_SEMI_BOLD,
        letterSpacing: 0,
        height: 1.28,
        color: defaultColor,
      ),
      headlineSmall: TextStyle(
        fontFamily: displayFontFamily,
        fontSize: 24,
        fontWeight: WEIGHT_SEMI_BOLD,
        letterSpacing: 0,
        height: 1.33,
        color: defaultColor,
      ),

      titleLarge: TextStyle(
        fontFamily: displayFontFamily,
        fontSize: 22,
        fontWeight: WEIGHT_SEMI_BOLD,
        letterSpacing: 0,
        height: 1.27,
        color: defaultColor,
      ),
      titleMedium: TextStyle(
        fontFamily: displayFontFamily,
        fontSize: 16,
        fontWeight: WEIGHT_SEMI_BOLD,
        letterSpacing: 0.15,
        height: 1.5,
        color: defaultColor,
      ),
      titleSmall: TextStyle(
        fontFamily: displayFontFamily,
        fontSize: 14,
        fontWeight: WEIGHT_MEDIUM,
        letterSpacing: 0.1,
        height: 1.43,
        color: defaultColor,
      ),

      bodyLarge: TextStyle(
        fontFamily: bodyFontFamily,
        fontSize: 16,
        fontWeight: WEIGHT_REGULAR,
        letterSpacing: 0.5,
        height: 1.5,
        color: defaultColor,
      ),
      bodyMedium: TextStyle(
        fontFamily: bodyFontFamily,
        fontSize: 14,
        fontWeight: WEIGHT_REGULAR,
        letterSpacing: 0.25,
        height: 1.43,
        color: defaultColor,
      ),
      bodySmall: TextStyle(
        fontFamily: bodyFontFamily,
        fontSize: 12,
        fontWeight: WEIGHT_REGULAR,
        letterSpacing: 0.4,
        height: 1.33,
        color: defaultColor,
      ),

      labelLarge: TextStyle(
        fontFamily: bodyFontFamily,
        fontSize: 14,
        fontWeight: WEIGHT_SEMI_BOLD,
        letterSpacing: 0.1,
        height: 1.43,
        color: defaultColor,
      ),
      labelMedium: TextStyle(
        fontFamily: bodyFontFamily,
        fontSize: 12,
        fontWeight: WEIGHT_MEDIUM,
        letterSpacing: 0.5,
        height: 1.33,
        color: defaultColor,
      ),
      labelSmall: TextStyle(
        fontFamily: bodyFontFamily,
        fontSize: 11,
        fontWeight: WEIGHT_MEDIUM,
        letterSpacing: 0.5,
        height: 1.45,
        color: defaultColor,
      ),
    );
  }
}
