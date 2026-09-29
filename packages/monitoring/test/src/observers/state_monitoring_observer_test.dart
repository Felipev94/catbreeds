import 'package:monitoring/monitoring.dart';
import 'package:test/test.dart';

class MockLogger implements LoggerContract {
  final List<String> logs = [];

  @override
  void log(
    LogLevel level,
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, Object?>? context,
  }) {
    logs.add('[$level] $message');
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
}

class MockCrashReporter implements CrashReporterContract {
  final List<Breadcrumb> breadcrumbs = [];
  final List<Object> errors = [];

  @override
  void addBreadcrumb(Breadcrumb breadcrumb) {
    breadcrumbs.add(breadcrumb);
  }

  @override
  Future<void> recordError(
    Object error,
    StackTrace? stackTrace, {
    String? reason,
    bool fatal = false,
    Map<String, Object?>? context,
  }) async {
    errors.add(error);
  }

  @override
  Future<void> setCustomKey(String key, Object value) async {}

  @override
  Future<void> setUserId(String? userId) async {}
}

void main() {
  group('StateMonitoringObserver', () {
    late MockLogger logger;
    late MockCrashReporter crashReporter;
    late StateMonitoringObserver observer;

    setUp(() {
      logger = MockLogger();
      crashReporter = MockCrashReporter();
      observer = StateMonitoringObserver(
        logger: logger,
        crashReporter: crashReporter,
      );
    });

    test('onStateChange records debug log and breadcrumb', () {
      observer.onStateChange(
        'PropertyListBloc',
        previousState: 'Initial',
        currentState: 'Loaded',
        metadata: {'count': 10},
      );

      expect(
        logger.logs,
        contains('[LogLevel.DEBUG] [PropertyListBloc] Initial -> Loaded'),
      );
      expect(crashReporter.breadcrumbs.length, 1);
      expect(
        crashReporter.breadcrumbs.first.message,
        '[PropertyListBloc] Initial -> Loaded',
      );
      expect(crashReporter.breadcrumbs.first.category, 'state');
    });

    test('onError records error log and error report', () async {
      final error = Exception('Failed to load properties');
      await observer.onError(
        'PropertyListBloc',
        error,
        StackTrace.current,
        currentState: 'Loading',
      );

      expect(
        logger.logs.first,
        contains(
          '[LogLevel.ERROR] [PropertyListBloc] State failure: Exception: Failed to load properties',
        ),
      );
      expect(crashReporter.errors, contains(error));
    });
  });
}
