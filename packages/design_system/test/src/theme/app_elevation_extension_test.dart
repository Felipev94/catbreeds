import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppElevationExtension', () {
    test('light and dark elevation extensions expose all levels', () {
      const AppElevationExtension light = AppElevationExtension.light;
      const AppElevationExtension dark = AppElevationExtension.dark;

      expect(light.level0, isEmpty);
      expect(light.level1, isNotEmpty);
      expect(light.level2, isNotEmpty);
      expect(light.level3, isNotEmpty);
      expect(light.level4, isNotEmpty);
      expect(light.level5, isNotEmpty);

      expect(dark.level0, isEmpty);
      expect(dark.level1, isNotEmpty);
    });

    test('copyWith replaces specified elevation level', () {
      const AppElevationExtension light = AppElevationExtension.light;
      final AppElevationExtension modified = light.copyWith(
        level1: const [BoxShadow(color: Colors.red)],
      );

      expect(modified.level1.first.color, equals(Colors.red));
      expect(modified.level2, equals(light.level2));
    });

    test('lerp switches at midpoint threshold', () {
      const AppElevationExtension light = AppElevationExtension.light;
      const AppElevationExtension dark = AppElevationExtension.dark;

      expect(light.lerp(dark, 0.4), equals(light));
      expect(light.lerp(dark, 0.6), equals(dark));
      expect(light.lerp(null, 0.5), equals(light));
    });
  });
}
