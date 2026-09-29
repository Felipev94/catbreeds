import 'package:design_system/design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppSpacing', () {
    test('values follow ascending 4pt/8pt grid progression', () {
      expect(AppSpacing.NONE, equals(0.0));
      expect(AppSpacing.XXS, equals(2.0));
      expect(AppSpacing.XS, equals(4.0));
      expect(AppSpacing.SM, equals(8.0));
      expect(AppSpacing.MD, equals(16.0));
      expect(AppSpacing.LG, equals(24.0));
      expect(AppSpacing.XL, equals(32.0));
      expect(AppSpacing.XXL, equals(48.0));
      expect(AppSpacing.XXXL, equals(64.0));
    });

    test('pre-built insets match corresponding numeric constants', () {
      expect(AppSpacing.INSETS_NONE, equals(EdgeInsets.zero));
      expect(AppSpacing.INSETS_MD, equals(const EdgeInsets.all(16.0)));
      expect(
        AppSpacing.INSETS_H_MD,
        equals(const EdgeInsets.symmetric(horizontal: 16.0)),
      );
      expect(
        AppSpacing.INSETS_V_SM,
        equals(const EdgeInsets.symmetric(vertical: 8.0)),
      );
    });

    test('AppLayout constants are consistent with spacing scale', () {
      expect(AppLayout.GUTTER, equals(16.0));
      expect(AppLayout.MARGIN, equals(16.0));
      expect(AppLayout.CARD_PADDING, equals(const EdgeInsets.all(16.0)));
      expect(AppLayout.MAX_CONTENT_WIDTH, equals(1200.0));
    });
  });
}
