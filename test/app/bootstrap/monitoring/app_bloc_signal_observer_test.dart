import 'package:bloc_signals/bloc_signals.dart';
import 'package:catbreeds/app/bootstrap/monitoring/app_bloc_signal_observer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:monitoring/monitoring.dart';

class _FakeLogger extends Fake implements LoggerContract {
  final List<String> messages = [];

  @override
  void log(
    LogLevel level,
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, Object?>? context,
  }) {
    messages.add(message);
  }
}

class _FakeCrashReporter extends Fake implements CrashReporterContract {
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
}

class _TestBlocSignal extends BlocSignal<String, int> {
  _TestBlocSignal() : super(initialState: 0);
}

void main() {
  late _FakeLogger logger;
  late _FakeCrashReporter crashReporter;
  late StateMonitoringObserver stateObserver;
  late AppBlocSignalObserver observer;
  late _TestBlocSignal bloc;

  setUp(() {
    logger = _FakeLogger();
    crashReporter = _FakeCrashReporter();
    stateObserver = StateMonitoringObserver(
      logger: logger,
      crashReporter: crashReporter,
    );
    observer = AppBlocSignalObserver(
      logger: logger,
      stateObserver: stateObserver,
    );
    bloc = _TestBlocSignal();
  });

  tearDown(() {
    bloc.close();
  });

  group('AppBlocSignalObserver Test', () {
    test('onCreate logs debug message', () {
      observer.onCreate(bloc);

      expect(logger.messages, contains('[_TestBlocSignal] Created'));
    });

    test('onEvent logs dispatched event', () {
      observer.onEvent(bloc, 'test_event');

      expect(
        logger.messages.any((m) => m.contains('Event: String')),
        isTrue,
      );
    });

    test('onChange notifies stateObserver and logs state transition', () {
      const change = Change<int>(currentState: 0, nextState: 1);

      observer.onChange(bloc, change);

      expect(
        logger.messages.any((m) => m.contains('[_TestBlocSignal] 0 -> 1')),
        isTrue,
      );
      expect(
        crashReporter.breadcrumbs.any((b) => b.message.contains('[_TestBlocSignal] 0 -> 1')),
        isTrue,
      );
    });

    test('onTransition logs transition message', () {
      observer.onTransition(bloc, 'event', 1);

      expect(
        logger.messages.any((m) => m.contains('Transition with String -> 1')),
        isTrue,
      );
    });

    test('onError forwards error to stateObserver and crashReporter', () {
      final error = Exception('state error');
      final stackTrace = StackTrace.current;

      observer.onError(bloc, error, stackTrace);

      expect(
        logger.messages.any((m) => m.contains('State failure: Exception: state error')),
        isTrue,
      );
      expect(crashReporter.errors, contains(error));
    });

    test('onClose logs debug message', () {
      observer.onClose(bloc);

      expect(logger.messages, contains('[_TestBlocSignal] Closed'));
    });
  });
}
