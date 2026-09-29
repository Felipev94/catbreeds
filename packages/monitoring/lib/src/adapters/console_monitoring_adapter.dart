import 'dart:async';

import '../contracts/analytics_tracker_contract.dart';
import '../contracts/crash_reporter_contract.dart';
import '../contracts/logger_contract.dart';
import '../contracts/monitoring_adapter.dart';
import '../models/breadcrumb.dart';
import '../models/log_level.dart';
import '../models/monitoring_event.dart';

class ConsoleMonitoringAdapter
    implements
        MonitoringAdapter,
        LoggerContract,
        CrashReporterContract,
        AnalyticsTrackerContract {
  final void Function(String message) _output;
  final LogLevel minLogLevel;

  ConsoleMonitoringAdapter({
    void Function(String message)? output,
    this.minLogLevel = LogLevel.DEBUG,
  }) : _output = output ?? print;

  @override
  String get name => 'console';

  @override
  LoggerContract get logger => this;

  @override
  CrashReporterContract get crashReporter => this;

  @override
  AnalyticsTrackerContract get analytics => this;

  @override
  Future<void> initialize() async {
    _output('[Monitoring::Console] Initialized console adapter');
  }

  @override
  Future<void> dispose() async {
    _output('[Monitoring::Console] Disposed console adapter');
  }

  @override
  void log(
    LogLevel level,
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, Object?>? context,
  }) {
    if (level.index < minLogLevel.index) return;

    final String icon = switch (level) {
      LogLevel.DEBUG => '[DEBUG]',
      LogLevel.INFO => '[INFO]',
      LogLevel.WARNING => '[WARN]',
      LogLevel.ERROR => '[ERROR]',
      LogLevel.FATAL => '[FATAL]',
    };

    final buffer = StringBuffer('$icon $message');
    if (context != null && context.isNotEmpty) {
      buffer.write(' | context: $context');
    }
    if (error != null) {
      buffer.write(' | error: $error');
    }
    if (stackTrace != null) {
      buffer.write('\n$stackTrace');
    }
    _output(buffer.toString());
  }

  @override
  void debug(String message, {Map<String, Object?>? context}) =>
      log(LogLevel.DEBUG, message, context: context);

  @override
  void info(String message, {Map<String, Object?>? context}) =>
      log(LogLevel.INFO, message, context: context);

  @override
  void warning(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, Object?>? context,
  }) => log(
    LogLevel.WARNING,
    message,
    error: error,
    stackTrace: stackTrace,
    context: context,
  );

  @override
  void error(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, Object?>? context,
  }) => log(
    LogLevel.ERROR,
    message,
    error: error,
    stackTrace: stackTrace,
    context: context,
  );

  @override
  Future<void> recordError(
    Object error,
    StackTrace? stackTrace, {
    String? reason,
    bool fatal = false,
    Map<String, Object?>? context,
  }) async {
    final prefix = fatal ? '[CRASH::FATAL]' : '[CRASH::NON-FATAL]';
    final buffer = StringBuffer('$prefix $error');
    if (reason != null) {
      buffer.write(' | reason: $reason');
    }
    if (context != null && context.isNotEmpty) {
      buffer.write(' | context: $context');
    }
    if (stackTrace != null) {
      buffer.write('\n$stackTrace');
    }
    _output(buffer.toString());
  }

  @override
  void addBreadcrumb(Breadcrumb breadcrumb) {
    _output(
      '[BREADCRUMB] [${breadcrumb.category ?? 'general'}] ${breadcrumb.message}',
    );
  }

  @override
  Future<void> setUserId(String? userId) async {
    _output('[USER_ID] $userId');
  }

  @override
  Future<void> setCustomKey(String key, Object value) async {
    _output('[CUSTOM_KEY] $key = $value');
  }

  @override
  Future<void> trackEvent(MonitoringEvent event) async {
    _output('[EVENT] ${event.name} -> ${event.parameters}');
  }

  @override
  Future<void> trackScreen(
    String screenName, {
    String? screenClass,
    Map<String, Object?>? parameters,
  }) async {
    _output('[SCREEN] $screenName ($screenClass) -> $parameters');
  }

  @override
  Future<void> setUserProperty(String name, String value) async {
    _output('[USER_PROP] $name = $value');
  }
}
