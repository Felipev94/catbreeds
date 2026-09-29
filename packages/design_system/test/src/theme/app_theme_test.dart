import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppTheme', () {
    test(
      'light theme is configured with Material 3 and registered extensions',
      () {
        final ThemeData theme = AppTheme.light();

        expect(theme.useMaterial3, isTrue);
        expect(theme.brightness, equals(Brightness.light));

        final AppColorExtension? colorExt = theme
            .extension<AppColorExtension>();
        expect(colorExt, isNotNull);
        expect(colorExt?.primary, equals(AppColors.PRIMARY_800));

        final AppElevationExtension? elevationExt = theme
            .extension<AppElevationExtension>();
        expect(elevationExt, isNotNull);
        expect(elevationExt?.level1, isNotEmpty);

        expect(theme.cardTheme.elevation, equals(AppElevation.LEVEL_1));
        expect(theme.appBarTheme.elevation, equals(AppElevation.LEVEL_0));
      },
    );

    test(
      'dark theme is configured with Material 3 and registered extensions',
      () {
        final ThemeData theme = AppTheme.dark();

        expect(theme.useMaterial3, isTrue);
        expect(theme.brightness, equals(Brightness.dark));

        final AppColorExtension? colorExt = theme
            .extension<AppColorExtension>();
        expect(colorExt, isNotNull);
        expect(colorExt?.primary, equals(AppColors.PRIMARY_300));

        final AppElevationExtension? elevationExt = theme
            .extension<AppElevationExtension>();
        expect(elevationExt, isNotNull);
        expect(elevationExt?.level1, isNotEmpty);
      },
    );

    test('custom font family propagates to TextTheme', () {
      final ThemeData theme = AppTheme.light(
        displayFontFamily: 'CustomDisplayFont',
        bodyFontFamily: 'CustomBodyFont',
      );

      expect(
        theme.textTheme.titleLarge?.fontFamily,
        equals('CustomDisplayFont'),
      );
      expect(theme.textTheme.bodyMedium?.fontFamily, equals('CustomBodyFont'));
    });
  });
}
