import 'dart:async';

import '../contracts/analytics_tracker_contract.dart';
import '../contracts/crash_reporter_contract.dart';
import '../contracts/logger_contract.dart';
import '../contracts/monitoring_adapter.dart';
import '../models/breadcrumb.dart';
import '../models/log_level.dart';
import '../models/monitoring_event.dart';

class CompositeMonitoringService
    implements LoggerContract, CrashReporterContract, AnalyticsTrackerContract {
  final List<MonitoringAdapter> _adapters = [];
  bool _isInitialized = false;

  List<MonitoringAdapter> get adapters => List.unmodifiable(_adapters);

  bool get isInitialized => _isInitialized;

  Future<void> registerAdapter(MonitoringAdapter adapter) async {
    if (_adapters.any((a) => a.name == adapter.name)) {
      return;
    }
    _adapters.add(adapter);
    if (_isInitialized) {
      await _safeExecute(
        'initialize adapter: ${adapter.name}',
        () => adapter.initialize(),
      );
    }
  }

  Future<void> initialize({List<MonitoringAdapter>? initialAdapters}) async {
    if (initialAdapters != null) {
      for (final adapter in initialAdapters) {
        if (!_adapters.any((a) => a.name == adapter.name)) {
          _adapters.add(adapter);
        }
      }
    }

    _isInitialized = true;

    await Future.wait(
      _adapters.map(
        (adapter) => _safeExecute(
          'initialize adapter: ${adapter.name}',
          () => adapter.initialize(),
        ),
      ),
    );
  }

  Future<void> dispose() async {
    await Future.wait(
      _adapters.map(
        (adapter) => _safeExecute(
          'dispose adapter: ${adapter.name}',
          () => adapter.dispose(),
        ),
      ),
    );
    _adapters.clear();
    _isInitialized = false;
  }

  @override
  void log(
    LogLevel level,
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, Object?>? context,
  }) {
    for (final MonitoringAdapter adapter in _adapters) {
      final LoggerContract? logger = adapter.logger;
      if (logger != null) {
        try {
          logger.log(
            level,
            message,
            error: error,
            stackTrace: stackTrace,
            context: context,
          );
        } catch (_) {}
      }
    }
  }

  @override
  void debug(String message, {Map<String, Object?>? context}) {
    log(LogLevel.DEBUG, message, context: context);
  }

  @override
  void info(String message, {Map<String, Object?>? context}) {
    log(LogLevel.INFO, message, context: context);
  }

  @override
  void warning(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, Object?>? context,
  }) {
    log(
      LogLevel.WARNING,
      message,
      error: error,
      stackTrace: stackTrace,
      context: context,
    );
  }

  @override
  void error(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, Object?>? context,
  }) {
    log(
      LogLevel.ERROR,
      message,
      error: error,
      stackTrace: stackTrace,
      context: context,
    );
  }

  @override
  Future<void> recordError(
    Object error,
    StackTrace? stackTrace, {
    String? reason,
    bool fatal = false,
    Map<String, Object?>? context,
  }) async {
    await Future.wait(
      _adapters.map((adapter) {
        final CrashReporterContract? reporter = adapter.crashReporter;
        if (reporter == null) return Future<void>.value();
        return _safeExecute(
          'recordError in ${adapter.name}',
          () => reporter.recordError(
            error,
            stackTrace,
            reason: reason,
            fatal: fatal,
            context: context,
          ),
        );
      }),
    );
  }

  @override
  void addBreadcrumb(Breadcrumb breadcrumb) {
    for (final MonitoringAdapter adapter in _adapters) {
      final CrashReporterContract? reporter = adapter.crashReporter;
      if (reporter != null) {
        try {
          reporter.addBreadcrumb(breadcrumb);
        } catch (_) {}
      }
    }
  }

  @override
  Future<void> setUserId(String? userId) async {
    await Future.wait(
      _adapters.map((adapter) {
        final CrashReporterContract? reporter = adapter.crashReporter;
        if (reporter == null) return Future<void>.value();
        return _safeExecute(
          'setUserId in ${adapter.name}',
          () => reporter.setUserId(userId),
        );
      }),
    );
  }

  @override
  Future<void> setCustomKey(String key, Object value) async {
    await Future.wait(
      _adapters.map((adapter) {
        final CrashReporterContract? reporter = adapter.crashReporter;
        if (reporter == null) return Future<void>.value();
        return _safeExecute(
          'setCustomKey in ${adapter.name}',
          () => reporter.setCustomKey(key, value),
        );
      }),
    );
  }

  @override
  Future<void> trackEvent(MonitoringEvent event) async {
    await Future.wait(
      _adapters.map((adapter) {
        final AnalyticsTrackerContract? analytics = adapter.analytics;
        if (analytics == null) return Future<void>.value();
        return _safeExecute(
          'trackEvent in ${adapter.name}',
          () => analytics.trackEvent(event),
        );
      }),
    );
  }

  @override
  Future<void> trackScreen(
    String screenName, {
    String? screenClass,
    Map<String, Object?>? parameters,
  }) async {
    await Future.wait(
      _adapters.map((adapter) {
        final AnalyticsTrackerContract? analytics = adapter.analytics;
        if (analytics == null) return Future<void>.value();
        return _safeExecute(
          'trackScreen in ${adapter.name}',
          () => analytics.trackScreen(
            screenName,
            screenClass: screenClass,
            parameters: parameters,
          ),
        );
      }),
    );
  }

  @override
  Future<void> setUserProperty(String name, String value) async {
    await Future.wait(
      _adapters.map((adapter) {
        final AnalyticsTrackerContract? analytics = adapter.analytics;
        if (analytics == null) return Future<void>.value();
        return _safeExecute(
          'setUserProperty in ${adapter.name}',
          () => analytics.setUserProperty(name, value),
        );
      }),
    );
  }

  Future<void> _safeExecute(
    String operation,
    Future<void> Function() action,
  ) async {
    try {
      await action();
    } catch (_) {}
  }
}
