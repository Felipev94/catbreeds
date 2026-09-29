import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppTypography', () {
    test('createTextTheme returns full text style scale', () {
      final TextTheme textTheme = AppTypography.createTextTheme();

      expect(textTheme.displayLarge, isNotNull);
      expect(textTheme.displayMedium, isNotNull);
      expect(textTheme.displaySmall, isNotNull);

      expect(textTheme.headlineLarge, isNotNull);
      expect(textTheme.headlineMedium, isNotNull);
      expect(textTheme.headlineSmall, isNotNull);

      expect(textTheme.titleLarge, isNotNull);
      expect(textTheme.titleMedium, isNotNull);
      expect(textTheme.titleSmall, isNotNull);

      expect(textTheme.bodyLarge, isNotNull);
      expect(textTheme.bodyMedium, isNotNull);
      expect(textTheme.bodySmall, isNotNull);

      expect(textTheme.labelLarge, isNotNull);
      expect(textTheme.labelMedium, isNotNull);
      expect(textTheme.labelSmall, isNotNull);
    });

    test('createTextTheme respects custom font family', () {
      final TextTheme textTheme = AppTypography.createTextTheme(
        displayFontFamily: 'CustomFont',
        bodyFontFamily: 'CustomFont',
      );

      expect(textTheme.displayLarge?.fontFamily, equals('CustomFont'));
      expect(textTheme.bodyLarge?.fontFamily, equals('CustomFont'));
    });

    test('createTextTheme applies default color if provided', () {
      final TextTheme textTheme = AppTypography.createTextTheme(
        defaultColor: Colors.red,
      );

      expect(textTheme.displayLarge?.color, equals(Colors.red));
      expect(textTheme.bodyLarge?.color, equals(Colors.red));
    });
  });
}
