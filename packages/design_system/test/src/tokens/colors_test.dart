import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppColors', () {
    test('brand primary colors have valid alpha', () {
      expect((AppColors.PRIMARY_900.a * 255.0).round(), equals(255));
      expect((AppColors.PRIMARY_800.a * 255.0).round(), equals(255));
      expect((AppColors.PRIMARY_50.a * 255.0).round(), equals(255));
    });

    test('semantic colors are properly instantiated', () {
      expect((AppColors.SUCCESS.a * 255.0).round(), equals(255));
      expect((AppColors.WARNING.a * 255.0).round(), equals(255));
      expect((AppColors.ERROR.a * 255.0).round(), equals(255));
      expect((AppColors.INFO.a * 255.0).round(), equals(255));
    });
  });
}
