import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppOpacity', () {
    test('values fall within valid 0.0 to 1.0 interval in order', () {
      expect(AppOpacity.TRANSPARENT, equals(0.0));
      expect(AppOpacity.FAINT, equals(0.05));
      expect(AppOpacity.MUTED, equals(0.12));
      expect(AppOpacity.DISABLED, equals(0.38));
      expect(AppOpacity.MEDIUM_EMPHASIS, equals(0.60));
      expect(AppOpacity.HIGH_EMPHASIS, equals(0.87));
      expect(AppOpacity.OPAQUE, equals(1.0));

      expect(AppOpacity.TRANSPARENT, lessThan(AppOpacity.FAINT));
      expect(AppOpacity.FAINT, lessThan(AppOpacity.MUTED));
      expect(AppOpacity.MUTED, lessThan(AppOpacity.DISABLED));
      expect(AppOpacity.DISABLED, lessThan(AppOpacity.MEDIUM_EMPHASIS));
      expect(AppOpacity.MEDIUM_EMPHASIS, lessThan(AppOpacity.HIGH_EMPHASIS));
      expect(AppOpacity.HIGH_EMPHASIS, lessThan(AppOpacity.OPAQUE));
    });
  });
}
