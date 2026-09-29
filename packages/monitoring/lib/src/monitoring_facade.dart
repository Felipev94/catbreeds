import 'dart:async';

import 'package:meta/meta.dart';

import 'composite/composite_monitoring_service.dart';
import 'contracts/analytics_tracker_contract.dart';
import 'contracts/crash_reporter_contract.dart';
import 'contracts/logger_contract.dart';
import 'contracts/monitoring_adapter.dart';

class Monitoring {
  static CompositeMonitoringService _service = CompositeMonitoringService();

  static CompositeMonitoringService get instance => _service;

  static LoggerContract get logger => _service;

  static CrashReporterContract get crashReporter => _service;

  static AnalyticsTrackerContract get analytics => _service;

  static bool get isInitialized => _service.isInitialized;

  static Future<void> initialize({
    required List<MonitoringAdapter> adapters,
  }) async {
    await _service.initialize(initialAdapters: adapters);
  }

  static Future<void> registerAdapter(MonitoringAdapter adapter) async {
    await _service.registerAdapter(adapter);
  }

  static Future<void> dispose() async {
    await _service.dispose();
  }

  @visibleForTesting
  static Future<void> resetForTesting() async {
    await _service.dispose();
    _service = CompositeMonitoringService();
  }

  @visibleForTesting
  static void setInstanceForTesting(CompositeMonitoringService service) {
    _service = service;
  }

  static R? runGuarded<R>(
    R Function() body, {
    String? reason,
    bool fatal = true,
  }) {
    return runZonedGuarded<R>(body, (error, stackTrace) {
      _service.recordError(
        error,
        stackTrace,
        reason:
            reason ?? 'Unhandled zone error caught by Monitoring.runGuarded',
        fatal: fatal,
      );
    });
  }
}
