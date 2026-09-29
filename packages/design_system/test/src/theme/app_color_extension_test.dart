import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppColorExtension', () {
    test('light theme has expected contrast and properties', () {
      const AppColorExtension ext = AppColorExtension.light;
      expect(ext.primary, equals(AppColors.PRIMARY_800));
      expect(ext.background, equals(AppColors.NEUTRAL_50));
      expect(ext.surface, equals(AppColors.WHITE));
      expect(ext.textPrimary, equals(AppColors.NEUTRAL_900));
      expect(ext.success, equals(AppColors.SUCCESS));
    });

    test('dark theme has expected dark backgrounds and contrast', () {
      const AppColorExtension ext = AppColorExtension.dark;
      expect(ext.primary, equals(AppColors.PRIMARY_300));
      expect(ext.background, equals(AppColors.NEUTRAL_900));
      expect(ext.surface, equals(AppColors.NEUTRAL_800));
      expect(ext.textPrimary, equals(AppColors.NEUTRAL_50));
      expect(ext.success, equals(AppColors.SUCCESS_LIGHT));
    });

    test('copyWith creates new instance with overridden field', () {
      const AppColorExtension ext = AppColorExtension.light;
      final AppColorExtension modified = ext.copyWith(primary: Colors.purple);

      expect(modified.primary, equals(Colors.purple));
      expect(modified.surface, equals(ext.surface));
    });

    test('lerp correctly blends colors between light and dark', () {
      const AppColorExtension light = AppColorExtension.light;
      const AppColorExtension dark = AppColorExtension.dark;

      final AppColorExtension blended = light.lerp(dark, 0.5);

      expect(
        blended.primary,
        equals(Color.lerp(light.primary, dark.primary, 0.5)),
      );
      expect(
        blended.surface,
        equals(Color.lerp(light.surface, dark.surface, 0.5)),
      );
    });

    test('lerp returns self when other is null or invalid type', () {
      const AppColorExtension light = AppColorExtension.light;
      expect(light.lerp(null, 0.5), equals(light));
    });
  });
}
