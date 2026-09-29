import 'package:monitoring/monitoring.dart';
import 'package:test/test.dart';

void main() {
  group('LogLevel', () {
    test('values follow SCREAMING_SNAKE_CASE and severity order', () {
      expect(LogLevel.DEBUG.index < LogLevel.INFO.index, isTrue);
      expect(LogLevel.INFO.index < LogLevel.WARNING.index, isTrue);
      expect(LogLevel.WARNING.index < LogLevel.ERROR.index, isTrue);
      expect(LogLevel.ERROR.index < LogLevel.FATAL.index, isTrue);
    });

    test('all expected levels exist', () {
      expect(LogLevel.values, [
        LogLevel.DEBUG,
        LogLevel.INFO,
        LogLevel.WARNING,
        LogLevel.ERROR,
        LogLevel.FATAL,
      ]);
    });
  });
}
