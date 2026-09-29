import 'package:design_system/design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppRadius', () {
    test('values follow ascending progression', () {
      expect(AppRadius.NONE, equals(0.0));
      expect(AppRadius.XS, equals(4.0));
      expect(AppRadius.SM, equals(8.0));
      expect(AppRadius.MD, equals(12.0));
      expect(AppRadius.LG, equals(16.0));
      expect(AppRadius.XL, equals(24.0));
      expect(AppRadius.XXL, equals(32.0));
      expect(AppRadius.FULL, equals(999.0));
    });

    test('pre-built BorderRadius primitives match expected radius values', () {
      expect(AppRadius.RADIUS_NONE, equals(BorderRadius.zero));
      expect(
        AppRadius.RADIUS_MD,
        equals(const BorderRadius.all(Radius.circular(12.0))),
      );
      expect(
        AppRadius.RADIUS_FULL,
        equals(const BorderRadius.all(Radius.circular(999.0))),
      );
      expect(
        AppRadius.SHEET_TOP,
        equals(const BorderRadius.vertical(top: Radius.circular(24.0))),
      );
    });
  });
}
