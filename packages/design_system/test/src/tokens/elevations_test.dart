import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppElevation', () {
    test('elevation levels follow ascending order', () {
      expect(AppElevation.LEVEL_0, equals(0.0));
      expect(AppElevation.LEVEL_1, equals(1.0));
      expect(AppElevation.LEVEL_2, equals(3.0));
      expect(AppElevation.LEVEL_3, equals(6.0));
      expect(AppElevation.LEVEL_4, equals(10.0));
      expect(AppElevation.LEVEL_5, equals(16.0));
    });

    test('AppShadows pre-built list lengths match levels', () {
      expect(AppShadows.LIGHT_LEVEL_0, isEmpty);
      expect(AppShadows.LIGHT_LEVEL_1, isNotEmpty);
      expect(AppShadows.LIGHT_LEVEL_2, isNotEmpty);
      expect(AppShadows.LIGHT_LEVEL_3, isNotEmpty);
      expect(AppShadows.DARK_LEVEL_0, isEmpty);
      expect(AppShadows.DARK_LEVEL_1, isNotEmpty);
    });
  });
}
