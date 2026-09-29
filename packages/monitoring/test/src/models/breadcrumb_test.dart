import 'package:monitoring/monitoring.dart';
import 'package:test/test.dart';

void main() {
  group('Breadcrumb', () {
    test('equality and properties', () {
      final now = DateTime.utc(2026, 9, 26, 12, 0, 0);
      final b1 = Breadcrumb(
        message: 'Tapped button',
        category: 'ui',
        timestamp: now,
        data: {'btn': 'submit'},
      );
      final b2 = Breadcrumb(
        message: 'Tapped button',
        category: 'ui',
        timestamp: now,
        data: {'btn': 'submit'},
      );
      final b3 = Breadcrumb(
        message: 'Swiped list',
        category: 'ui',
        timestamp: now,
      );

      expect(b1, equals(b2));
      expect(b1.hashCode, equals(b2.hashCode));
      expect(b1, isNot(equals(b3)));
      expect(b1.level, LogLevel.INFO);
      expect(b1.data['btn'], 'submit');
    });

    test('data map is immutable', () {
      final breadcrumb = Breadcrumb(message: 'Action', data: {'key': 'val'});
      expect(
        () => breadcrumb.data['new'] = 'forbidden',
        throwsUnsupportedError,
      );
    });

    test('toString contains relevant fields', () {
      final breadcrumb = Breadcrumb(message: 'Action message', category: 'nav');
      expect(breadcrumb.toString(), contains('Action message'));
      expect(breadcrumb.toString(), contains('nav'));
    });
  });
}
