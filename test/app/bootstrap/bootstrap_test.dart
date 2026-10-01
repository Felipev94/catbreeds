import 'dart:async';

import 'package:catbreeds/app/bootstrap/bootstrap.dart';
import 'package:catbreeds/app/bootstrap/di/di_module.dart';
import 'package:catbreeds/app/bootstrap/di/service_locator.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:monitoring/monitoring.dart';

class _MockTestModule implements DiModule {
  const _MockTestModule();

  @override
  FutureOr<void> register(GetIt sl) {
    sl.registerSingleton<int>(42);
  }
}

void main() {
  setUp(() async {
    await Monitoring.resetForTesting();
    await ServiceLocator.reset();
  });

  tearDown(() async {
    await Monitoring.resetForTesting();
    await ServiceLocator.reset();
  });

  group('Bootstrap Test', () {
    testWidgets('Bootstrap.run initializes monitoring, DI and builds app', (tester) async {
      bool appBuilt = false;

      await Bootstrap.run(
        () {
          appBuilt = true;
          return const SizedBox.shrink();
        },
        monitoringAdapters: [ConsoleMonitoringAdapter()],
        diModules: const [_MockTestModule()],
      );

      await tester.pump();

      expect(Monitoring.isInitialized, isTrue);
      expect(ServiceLocator.instance.isRegistered<int>(), isTrue);
      expect(ServiceLocator.instance<int>(), equals(42));
      expect(appBuilt, isTrue);
    });
  });
}
