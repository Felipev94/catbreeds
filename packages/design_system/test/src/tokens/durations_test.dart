import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppDurations', () {
    test('durations follow ascending progression', () {
      expect(AppDurations.INSTANT, equals(Duration.zero));
      expect(AppDurations.FAST.inMilliseconds, equals(150));
      expect(AppDurations.NORMAL.inMilliseconds, equals(300));
      expect(AppDurations.SLOW.inMilliseconds, equals(500));
      expect(AppDurations.VERY_SLOW.inMilliseconds, equals(800));

      expect(AppDurations.FAST, lessThan(AppDurations.NORMAL));
      expect(AppDurations.NORMAL, lessThan(AppDurations.SLOW));
      expect(AppDurations.SLOW, lessThan(AppDurations.VERY_SLOW));
    });
  });
}
