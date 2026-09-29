import 'package:monitoring/monitoring.dart';
import 'package:test/test.dart';

void main() {
  group('Monitoring Facade', () {
    tearDown(() async {
      await Monitoring.resetForTesting();
    });

    test('initializes with adapters and exposes contracts', () async {
      final logs = <String>[];
      final adapter = ConsoleMonitoringAdapter(output: logs.add);

      await Monitoring.initialize(adapters: [adapter]);

      expect(Monitoring.isInitialized, isTrue);

      Monitoring.logger.info('Facade test message');
      expect(logs.any((l) => l.contains('Facade test message')), isTrue);

      await Monitoring.analytics.trackEvent(MonitoringEvent('facade_event'));
      expect(logs.any((l) => l.contains('facade_event')), isTrue);
    });

    test('runGuarded executes body and captures exceptions', () async {
      final logs = <String>[];
      final adapter = ConsoleMonitoringAdapter(output: logs.add);
      await Monitoring.initialize(adapters: [adapter]);

      final result = Monitoring.runGuarded(() {
        return 42;
      });
      expect(result, 42);

      Monitoring.runGuarded(() {
        throw StateError('Simulated crash inside zone');
      });

      // Allow zone exception microtask to process
      await Future<void>.delayed(const Duration(milliseconds: 50));

      expect(
        logs.any((l) => l.contains('Simulated crash inside zone')),
        isTrue,
      );
    });

    test(
      'resetForTesting and setInstanceForTesting support test isolation',
      () async {
        final customService = CompositeMonitoringService();
        Monitoring.setInstanceForTesting(customService);
        expect(identical(Monitoring.instance, customService), isTrue);

        await Monitoring.resetForTesting();
        expect(identical(Monitoring.instance, customService), isFalse);
      },
    );
  });
}
