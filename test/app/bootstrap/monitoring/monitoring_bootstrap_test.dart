import 'package:catbreeds/app/bootstrap/monitoring/monitoring_bootstrap.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:monitoring/monitoring.dart';

void main() {
  setUp(() async {
    await Monitoring.resetForTesting();
  });

  tearDown(() async {
    await Monitoring.resetForTesting();
  });

  group('MonitoringBootstrap Test', () {
    test('init initializes Monitoring with default adapter', () async {
      expect(Monitoring.isInitialized, isFalse);

      await MonitoringBootstrap.init();

      expect(Monitoring.isInitialized, isTrue);
    });

    test('init initializes Monitoring with custom adapters', () async {
      final customAdapter = ConsoleMonitoringAdapter();

      await MonitoringBootstrap.init(adapters: [customAdapter]);

      expect(Monitoring.isInitialized, isTrue);
    });
  });
}
