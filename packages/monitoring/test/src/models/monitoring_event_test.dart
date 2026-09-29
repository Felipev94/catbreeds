import 'package:monitoring/monitoring.dart';
import 'package:test/test.dart';

void main() {
  group('MonitoringEvent', () {
    test('equality and parameters map', () {
      final now = DateTime.utc(2026, 9, 26, 12, 0, 0);
      final event1 = MonitoringEvent(
        'screen_view',
        parameters: {'screen': 'home'},
        timestamp: now,
      );
      final event2 = MonitoringEvent(
        'screen_view',
        parameters: {'screen': 'home'},
        timestamp: now,
      );
      final event3 = MonitoringEvent(
        'button_click',
        parameters: {'screen': 'home'},
        timestamp: now,
      );

      expect(event1, equals(event2));
      expect(event1.hashCode, equals(event2.hashCode));
      expect(event1, isNot(equals(event3)));
      expect(event1.name, 'screen_view');
      expect(event1.parameters['screen'], 'home');
    });

    test('parameters map is immutable', () {
      final event = MonitoringEvent('test', parameters: {'key': 'val'});
      expect(
        () => event.parameters['new'] = 'forbidden',
        throwsUnsupportedError,
      );
    });

    test('toString contains name and parameters', () {
      final event = MonitoringEvent('custom_event', parameters: {'a': 1});
      expect(event.toString(), contains('custom_event'));
      expect(event.toString(), contains('a: 1'));
    });
  });
}
