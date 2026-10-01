import 'package:bloc_signals/bloc_signals.dart';
import 'package:monitoring/monitoring.dart';

import 'app_bloc_signal_observer.dart';

abstract final class MonitoringBootstrap {
  static Future<void> init({
    List<MonitoringAdapter>? adapters,
    BlocSignalObserver? blocSignalObserver,
  }) async {
    final List<MonitoringAdapter> monitoringAdapters =
        adapters ?? [ConsoleMonitoringAdapter()];

    await Monitoring.initialize(adapters: monitoringAdapters);

    final BlocSignalObserver observer =
        blocSignalObserver ?? AppBlocSignalObserver();
    BlocSignalObserver.addObserver(observer);

    Monitoring.logger.info('Monitoring initialized successfully');
  }
}
