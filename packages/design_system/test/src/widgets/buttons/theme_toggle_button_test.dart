import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ThemeToggleButton', () {
    testWidgets('renders dark_mode icon in light mode', (tester) async {
      await tester.pumpWidget(
        AppThemeProvider(
          initialThemeMode: ThemeMode.light,
          child: const MaterialApp(
            home: Scaffold(
              body: ThemeToggleButton(),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.dark_mode_rounded), findsOneWidget);
      expect(find.byIcon(Icons.light_mode_rounded), findsNothing);
    });

    testWidgets('renders light_mode icon in dark mode', (tester) async {
      await tester.pumpWidget(
        AppThemeProvider(
          initialThemeMode: ThemeMode.dark,
          child: const MaterialApp(
            home: Scaffold(
              body: ThemeToggleButton(),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.light_mode_rounded), findsOneWidget);
      expect(find.byIcon(Icons.dark_mode_rounded), findsNothing);
    });

    testWidgets('tapping button toggles theme in AppThemeProvider', (tester) async {
      await tester.pumpWidget(
        AppThemeProvider(
          initialThemeMode: ThemeMode.light,
          child: const MaterialApp(
            home: Scaffold(
              body: ThemeToggleButton(),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.dark_mode_rounded), findsOneWidget);

      await tester.tap(find.byType(ThemeToggleButton));
      await tester.pump();

      expect(find.byIcon(Icons.light_mode_rounded), findsOneWidget);

      await tester.tap(find.byType(ThemeToggleButton));
      await tester.pump();

      expect(find.byIcon(Icons.dark_mode_rounded), findsOneWidget);
    });

    testWidgets('calls custom onToggle when provided', (tester) async {
      bool customToggled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ThemeToggleButton(
              onToggle: () {
                customToggled = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ThemeToggleButton));
      await tester.pump();

      expect(customToggled, isTrue);
    });

    testWidgets('respects custom color, size and tooltip', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ThemeToggleButton(
              color: Colors.red,
              size: 32.0,
              tooltip: 'Cambiar tema',
            ),
          ),
        ),
      );

      final icon = tester.widget<Icon>(find.byType(Icon));
      expect(icon.color, equals(Colors.red));
      expect(icon.size, equals(32.0));

      final iconButton = tester.widget<IconButton>(find.byType(IconButton));
      expect(iconButton.tooltip, equals('Cambiar tema'));
    });
  });
}
