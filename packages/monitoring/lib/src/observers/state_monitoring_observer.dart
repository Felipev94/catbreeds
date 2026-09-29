import '../contracts/crash_reporter_contract.dart';
import '../contracts/logger_contract.dart';
import '../models/breadcrumb.dart';
import '../models/log_level.dart';

class StateMonitoringObserver {
  final LoggerContract logger;
  final CrashReporterContract crashReporter;

  StateMonitoringObserver({required this.logger, required this.crashReporter});

  void onStateChange(
    String stateName, {
    Object? previousState,
    Object? currentState,
    Map<String, Object?>? metadata,
  }) {
    final String message = '[$stateName] $previousState -> $currentState';

    logger.log(LogLevel.DEBUG, message, context: metadata);

    crashReporter.addBreadcrumb(
      Breadcrumb(
        message: message,
        category: 'state',
        level: LogLevel.DEBUG,
        data: metadata,
      ),
    );
  }

  Future<void> onError(
    String stateName,
    Object error,
    StackTrace? stackTrace, {
    Object? currentState,
  }) async {
    logger.log(
      LogLevel.ERROR,
      '[$stateName] State failure: $error',
      error: error,
      stackTrace: stackTrace,
    );

    await crashReporter.recordError(
      error,
      stackTrace,
      reason: 'State error in $stateName',
      fatal: false,
      context: {
        'state_name': stateName,
        'current_state': ?currentState?.toString(),
      },
    );
  }
}
