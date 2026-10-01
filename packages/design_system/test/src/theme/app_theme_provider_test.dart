import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppThemeScope and AppThemeProvider', () {
    testWidgets('defaults to initialThemeMode (light)', (tester) async {
      late ThemeMode capturedMode;

      await tester.pumpWidget(
        AppThemeProvider(
          builder: (context, themeMode) {
            capturedMode = themeMode;
            return const SizedBox.shrink();
          },
        ),
      );

      expect(capturedMode, equals(ThemeMode.light));
    });

    testWidgets('supports custom initialThemeMode (dark)', (tester) async {
      late ThemeMode capturedMode;

      await tester.pumpWidget(
        AppThemeProvider(
          initialThemeMode: ThemeMode.dark,
          builder: (context, themeMode) {
            capturedMode = themeMode;
            return const SizedBox.shrink();
          },
        ),
      );

      expect(capturedMode, equals(ThemeMode.dark));
    });

    testWidgets('toggles theme when toggleTheme is called', (tester) async {
      late BuildContext innerContext;

      await tester.pumpWidget(
        AppThemeProvider(
          initialThemeMode: ThemeMode.light,
          child: MaterialApp(
            home: Builder(
              builder: (context) {
                innerContext = context;
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );

      final scope = AppThemeScope.of(innerContext);
      expect(scope.themeMode, equals(ThemeMode.light));
      expect(scope.isDarkMode, isFalse);

      scope.toggleTheme();
      await tester.pump();

      final updatedScope = AppThemeScope.of(innerContext);
      expect(updatedScope.themeMode, equals(ThemeMode.dark));
      expect(updatedScope.isDarkMode, isTrue);

      updatedScope.toggleTheme();
      await tester.pump();

      expect(AppThemeScope.of(innerContext).themeMode, equals(ThemeMode.light));
    });

    testWidgets('sets specific theme mode using setThemeMode', (tester) async {
      late BuildContext innerContext;

      await tester.pumpWidget(
        AppThemeProvider(
          initialThemeMode: ThemeMode.light,
          child: MaterialApp(
            home: Builder(
              builder: (context) {
                innerContext = context;
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );

      AppThemeProvider.setThemeMode(innerContext, ThemeMode.dark);
      await tester.pump();

      expect(AppThemeScope.of(innerContext).themeMode, equals(ThemeMode.dark));

      // Setting same mode does not cause issues
      AppThemeProvider.setThemeMode(innerContext, ThemeMode.dark);
      await tester.pump();

      expect(AppThemeScope.of(innerContext).themeMode, equals(ThemeMode.dark));
    });

    testWidgets('AppThemeProvider.toggleTheme static helper triggers toggle', (tester) async {
      late BuildContext innerContext;

      await tester.pumpWidget(
        AppThemeProvider(
          initialThemeMode: ThemeMode.light,
          child: MaterialApp(
            home: Builder(
              builder: (context) {
                innerContext = context;
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );

      AppThemeProvider.toggleTheme(innerContext);
      await tester.pump();

      expect(AppThemeScope.of(innerContext).themeMode, equals(ThemeMode.dark));
    });

    testWidgets('updateShouldNotify returns true on mode difference and false otherwise', (tester) async {
      final scope1 = AppThemeScope(
        themeMode: ThemeMode.light,
        onToggleTheme: () {},
        onThemeModeChanged: (_) {},
        child: const SizedBox.shrink(),
      );
      final scope2 = AppThemeScope(
        themeMode: ThemeMode.dark,
        onToggleTheme: () {},
        onThemeModeChanged: (_) {},
        child: const SizedBox.shrink(),
      );
      final scope3 = AppThemeScope(
        themeMode: ThemeMode.light,
        onToggleTheme: () {},
        onThemeModeChanged: (_) {},
        child: const SizedBox.shrink(),
      );

      expect(scope1.updateShouldNotify(scope2), isTrue);
      expect(scope1.updateShouldNotify(scope3), isFalse);
    });
  });
}
