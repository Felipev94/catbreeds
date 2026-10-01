import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:monitoring/monitoring.dart';

import 'di/di_module.dart';
import 'di/service_locator.dart';
import 'monitoring/monitoring_bootstrap.dart';

abstract final class Bootstrap {
  static Future<void> run(
    FutureOr<Widget> Function() appBuilder, {
    List<MonitoringAdapter>? monitoringAdapters,
    List<DiModule>? diModules,
  }) async {
    Monitoring.runGuarded(() async {
      final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

      await MonitoringBootstrap.init(adapters: monitoringAdapters);

      await ServiceLocator.init(modules: diModules);

      Monitoring.logger.info('Application bootstrapping completed');

      runApp(await appBuilder());
      FlutterNativeSplash.remove();
    });
  }
}
