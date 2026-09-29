import 'package:monitoring/monitoring.dart';
import 'package:test/test.dart';

class MockLogger implements LoggerContract {
  final List<String> logs = [];
  final List<Map<String, Object?>?> contexts = [];

  @override
  void log(
    LogLevel level,
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, Object?>? context,
  }) {
    logs.add('[$level] $message');
    contexts.add(context);
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
  group('NetworkMonitoringHelper', () {
    late MockLogger logger;
    late MockCrashReporter crashReporter;
    late NetworkMonitoringHelper helper;

    setUp(() {
      logger = MockLogger();
      crashReporter = MockCrashReporter();
      helper = NetworkMonitoringHelper(
        logger: logger,
        crashReporter: crashReporter,
      );
    });

    test('toCurl formats basic GET request correctly', () {
      final curl = helper.toCurl(
        method: 'GET',
        url: 'https://api.example.com/properties',
      );
      expect(curl, "curl -X GET 'https://api.example.com/properties'");
    });

    test('toCurl formats POST request with headers and body', () {
      final curl = helper.toCurl(
        method: 'post',
        url: 'https://api.example.com/auth',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer 123',
        },
        body: '{"username":"john"}',
      );

      expect(curl, contains("curl -X POST 'https://api.example.com/auth'"));
      expect(curl, contains("-H 'Content-Type: application/json'"));
      expect(curl, contains("-H 'Authorization: Bearer 123'"));
      expect(curl, contains("--data '{\"username\":\"john\"}'"));
    });

    test('onRequest records outgoing request log with cURL and breadcrumb', () {
      helper.onRequest(
        'POST',
        'https://api.example.com/properties',
        headers: {'Content-Type': 'application/json'},
        body: '{"price":500000}',
      );

      expect(
        logger.logs.first,
        contains(
          '[LogLevel.DEBUG] --> POST https://api.example.com/properties',
        ),
      );
      expect(
        logger.logs.first,
        contains("curl -X POST 'https://api.example.com/properties'"),
      );

      expect(logger.contexts.first?['curl'], isNotNull);
      expect(crashReporter.breadcrumbs.length, 1);
      expect(
        crashReporter.breadcrumbs.first.message,
        'HTTP POST https://api.example.com/properties',
      );
      expect(crashReporter.breadcrumbs.first.category, 'network');
      expect(crashReporter.breadcrumbs.first.data['curl'], isNotNull);
    });

    test('onResponse records response status, duration, and breadcrumb', () {
      helper.onResponse(
        'GET',
        'https://api.example.com/properties',
        200,
        duration: const Duration(milliseconds: 150),
      );

      expect(
        logger.logs,
        contains(
          '[LogLevel.INFO] <-- [200 OK] GET https://api.example.com/properties (150ms)',
        ),
      );
      expect(crashReporter.breadcrumbs.length, 1);
      expect(
        crashReporter.breadcrumbs.first.message,
        '<-- [200 OK] GET https://api.example.com/properties (150ms)',
      );
    });

    test('onResponse formats headers and pretty-prints JSON body', () {
      helper.onResponse(
        'POST',
        'https://api.example.com/properties',
        201,
        duration: const Duration(milliseconds: 200),
        headers: {
          'content-type': 'application/json',
          'x-request-id': 'req_123',
        },
        responseBody: {'id': 'prop_1', 'price': 250000},
      );

      expect(
        logger.logs.last,
        contains(
          '[LogLevel.INFO] <-- [201 Created] POST https://api.example.com/properties (200ms)',
        ),
      );
      expect(
        logger.logs.last,
        contains(
          'Headers:\n  content-type: application/json\n  x-request-id: req_123',
        ),
      );
      expect(
        logger.logs.last,
        contains('Body:\n{\n  "id": "prop_1",\n  "price": 250000\n}'),
      );
    });

    test('onResponse records warning on 4xx status code', () {
      helper.onResponse(
        'GET',
        'https://api.example.com/properties/999',
        404,
        duration: const Duration(milliseconds: 80),
      );

      expect(
        logger.logs,
        contains(
          '[LogLevel.WARNING] <-- [404 Not Found] GET https://api.example.com/properties/999 (80ms)',
        ),
      );
    });

    test('onResponse flags slow requests with warning and label', () {
      helper.onResponse(
        'GET',
        'https://api.example.com/heavy',
        200,
        duration: const Duration(milliseconds: 2500),
      );

      expect(
        logger.logs.last,
        contains(
          '[LogLevel.WARNING] <-- [200 OK] GET https://api.example.com/heavy (2500ms) [SLOW REQUEST]',
        ),
      );
    });

    test('onError records error log, breadcrumb, and error report', () async {
      final error = Exception('Connection timeout');
      await helper.onError(
        'POST',
        'https://api.example.com/auth',
        error,
        StackTrace.current,
        statusCode: 504,
        duration: const Duration(milliseconds: 5000),
      );

      expect(
        logger.logs.first,
        contains(
          '[LogLevel.ERROR] <-- HTTP [504 Gateway Timeout] POST https://api.example.com/auth (5000ms): Exception: Connection timeout',
        ),
      );
      expect(crashReporter.breadcrumbs.length, 1);
      expect(crashReporter.errors, contains(error));
    });
  });
}
