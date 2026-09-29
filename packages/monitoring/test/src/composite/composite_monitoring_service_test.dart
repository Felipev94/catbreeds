import 'package:monitoring/monitoring.dart';
import 'package:test/test.dart';

class SpyAdapter
    implements
        MonitoringAdapter,
        LoggerContract,
        CrashReporterContract,
        AnalyticsTrackerContract {
  @override
  final String name;

  bool isInitialized = false;
  bool isDisposed = false;

  final List<String> loggedMessages = [];
  final List<Object> recordedErrors = [];
  final List<MonitoringEvent> trackedEvents = [];
  final List<Breadcrumb> breadcrumbs = [];

  SpyAdapter(this.name);

  @override
  LoggerContract get logger => this;

  @override
  CrashReporterContract get crashReporter => this;

  @override
  AnalyticsTrackerContract get analytics => this;

  @override
  Future<void> initialize() async {
    isInitialized = true;
  }

  @override
  Future<void> dispose() async {
    isDisposed = true;
  }

  @override
  void log(
    LogLevel level,
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, Object?>? context,
  }) {
    loggedMessages.add('[$level] $message');
  }

  @override
  void debug(String message, {Map<String, Object?>? context}) =>
      log(LogLevel.DEBUG, message);

  @override
  void info(String message, {Map<String, Object?>? context}) =>
      log(LogLevel.INFO, message);

  @override
  void warning(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, Object?>? context,
  }) => log(LogLevel.WARNING, message);

  @override
  void error(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, Object?>? context,
  }) => log(LogLevel.ERROR, message);

  @override
  Future<void> recordError(
    Object error,
    StackTrace? stackTrace, {
    String? reason,
    bool fatal = false,
    Map<String, Object?>? context,
  }) async {
    recordedErrors.add(error);
  }

  @override
  void addBreadcrumb(Breadcrumb breadcrumb) {
    breadcrumbs.add(breadcrumb);
  }

  @override
  Future<void> setUserId(String? userId) async {}

  @override
  Future<void> setCustomKey(String key, Object value) async {}

  @override
  Future<void> trackEvent(MonitoringEvent event) async {
    trackedEvents.add(event);
  }

  @override
  Future<void> trackScreen(
    String screenName, {
    String? screenClass,
    Map<String, Object?>? parameters,
  }) async {}

  @override
  Future<void> setUserProperty(String name, String value) async {}
}

class FaultyAdapter extends SpyAdapter {
  FaultyAdapter() : super('faulty');

  @override
  void log(
    LogLevel level,
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, Object?>? context,
  }) {
    throw Exception('Simulated logger crash');
  }

  @override
  Future<void> recordError(
    Object error,
    StackTrace? stackTrace, {
    String? reason,
    bool fatal = false,
    Map<String, Object?>? context,
  }) async {
    throw Exception('Simulated crash reporter error');
  }
}

void main() {
  group('CompositeMonitoringService', () {
    late CompositeMonitoringService service;
    late SpyAdapter adapter1;
    late SpyAdapter adapter2;

    setUp(() {
      service = CompositeMonitoringService();
      adapter1 = SpyAdapter('adapter1');
      adapter2 = SpyAdapter('adapter2');
    });

    tearDown(() async {
      await service.dispose();
    });

    test('initializes all registered adapters', () async {
      await service.initialize(initialAdapters: [adapter1, adapter2]);

      expect(service.isInitialized, isTrue);
      expect(adapter1.isInitialized, isTrue);
      expect(adapter2.isInitialized, isTrue);
      expect(service.adapters.length, 2);
    });

    test(
      'registerAdapter at runtime initializes immediately if service is ready',
      () async {
        await service.initialize();
        expect(service.isInitialized, isTrue);

        await service.registerAdapter(adapter1);
        expect(adapter1.isInitialized, isTrue);
        expect(service.adapters, contains(adapter1));
      },
    );

    test('dispatches logs across all adapters', () async {
      await service.initialize(initialAdapters: [adapter1, adapter2]);

      service.info('App started');
      service.error('Database connection failed');

      expect(adapter1.loggedMessages, [
        '[LogLevel.INFO] App started',
        '[LogLevel.ERROR] Database connection failed',
      ]);
      expect(adapter2.loggedMessages, [
        '[LogLevel.INFO] App started',
        '[LogLevel.ERROR] Database connection failed',
      ]);
    });

    test('dispatches errors and analytics across all adapters', () async {
      await service.initialize(initialAdapters: [adapter1, adapter2]);

      final error = StateError('Corrupted state');
      await service.recordError(error, StackTrace.current);

      final event = MonitoringEvent('checkout_completed');
      await service.trackEvent(event);

      expect(adapter1.recordedErrors, contains(error));
      expect(adapter2.recordedErrors, contains(error));
      expect(adapter1.trackedEvents, contains(event));
      expect(adapter2.trackedEvents, contains(event));
    });

    test(
      'fault isolation: faulty adapter does not block healthy adapters',
      () async {
        final faulty = FaultyAdapter();
        await service.initialize(initialAdapters: [faulty, adapter1]);

        expect(() => service.info('Test resilience'), returnsNormally);
        expect(
          adapter1.loggedMessages,
          contains('[LogLevel.INFO] Test resilience'),
        );

        expect(
          () async => await service.recordError('Failure', null),
          returnsNormally,
        );
        expect(adapter1.recordedErrors, contains('Failure'));
      },
    );
  });
}
