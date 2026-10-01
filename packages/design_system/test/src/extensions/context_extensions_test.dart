import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DesignSystemContextExtensions', () {
    testWidgets('provides easy access to tokens in Light mode', (tester) async {
      late AppColorExtension capturedColors;
      late AppElevationExtension capturedElevations;
      late TextTheme capturedTypography;
      late bool capturedIsDarkMode;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Builder(
            builder: (context) {
              capturedColors = context.colors;
              capturedElevations = context.elevations;
              capturedTypography = context.typography;
              capturedIsDarkMode = context.isDarkMode;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(capturedColors.primary, equals(AppColors.PRIMARY_800));
      expect(capturedElevations.level1, isNotEmpty);
      expect(capturedTypography.titleLarge, isNotNull);
      expect(capturedIsDarkMode, isFalse);
    });

    testWidgets('provides easy access to tokens in Dark mode', (tester) async {
      late AppColorExtension capturedColors;
      late bool capturedIsDarkMode;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Builder(
            builder: (context) {
              capturedColors = context.colors;
              capturedIsDarkMode = context.isDarkMode;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(capturedColors.primary, equals(AppColors.PRIMARY_300));
      expect(capturedIsDarkMode, isTrue);
    });

    testWidgets('gracefully falls back when extension is not in ThemeData', (
      tester,
    ) async {
      late AppColorExtension capturedColors;
      late AppElevationExtension capturedElevations;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: Builder(
            builder: (context) {
              capturedColors = context.colors;
              capturedElevations = context.elevations;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(capturedColors.primary, equals(AppColorExtension.light.primary));
      expect(
        capturedElevations.level1,
        equals(AppElevationExtension.light.level1),
      );
    });

    testWidgets('maybeThemeScope returns null when not wrapped in AppThemeProvider', (tester) async {
      late AppThemeScope? capturedScope;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              capturedScope = context.maybeThemeScope;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(capturedScope, isNull);
    });

    testWidgets('themeScope returns valid scope when wrapped in AppThemeProvider', (tester) async {
      late AppThemeScope capturedScope;

      await tester.pumpWidget(
        AppThemeProvider(
          initialThemeMode: ThemeMode.dark,
          child: MaterialApp(
            home: Builder(
              builder: (context) {
                capturedScope = context.themeScope;
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );

      expect(capturedScope.themeMode, equals(ThemeMode.dark));
      expect(capturedScope.isDarkMode, isTrue);
    });
  });
}
