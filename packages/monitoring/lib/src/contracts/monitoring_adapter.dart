import 'analytics_tracker_contract.dart';
import 'crash_reporter_contract.dart';
import 'logger_contract.dart';

abstract interface class MonitoringAdapter {
  String get name;

  Future<void> initialize();

  Future<void> dispose();

  LoggerContract? get logger;

  CrashReporterContract? get crashReporter;

  AnalyticsTrackerContract? get analytics;
}
