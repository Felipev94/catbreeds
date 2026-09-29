import 'package:monitoring/monitoring.dart';
import 'package:test/test.dart';

void main() {
  group('ConsoleMonitoringAdapter', () {
    test('outputs formatted log, error, breadcrumbs, and analytics', () async {
      final logs = <String>[];
      final adapter = ConsoleMonitoringAdapter(output: logs.add);

      await adapter.initialize();
      expect(logs.last, contains('Initialized console adapter'));

      adapter.debug('Debug test');
      expect(logs.last, contains('[DEBUG] Debug test'));

      adapter.info('Info test');
      expect(logs.last, contains('[INFO] Info test'));

      adapter.warning('Warning test');
      expect(logs.last, contains('[WARN] Warning test'));

      adapter.error('Error test');
      expect(logs.last, contains('[ERROR] Error test'));

      await adapter.recordError('Critical error', null, fatal: true);
      expect(logs.last, contains('[CRASH::FATAL] Critical error'));

      adapter.addBreadcrumb(
        Breadcrumb(message: 'User clicked buy', category: 'order'),
      );
      expect(logs.last, contains('[BREADCRUMB] [order] User clicked buy'));

      await adapter.setUserId('user_456');
      expect(logs.last, contains('[USER_ID] user_456'));

      await adapter.setCustomKey('env', 'production');
      expect(logs.last, contains('[CUSTOM_KEY] env = production'));

      await adapter.trackEvent(
        MonitoringEvent('test_event', parameters: {'key': 'val'}),
      );
      expect(logs.last, contains('[EVENT] test_event -> {key: val}'));

      await adapter.trackScreen('HomeScreen', screenClass: 'HomeView');
      expect(logs.last, contains('[SCREEN] HomeScreen (HomeView)'));

      await adapter.setUserProperty('tier', 'premium');
      expect(logs.last, contains('[USER_PROP] tier = premium'));

      await adapter.dispose();
      expect(logs.last, contains('Disposed console adapter'));
    });
  });
}
