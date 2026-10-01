import 'package:bloc_signals/bloc_signals.dart';
import 'package:monitoring/monitoring.dart';

class AppBlocSignalObserver extends BlocSignalObserver {
  final StateMonitoringObserver _stateObserver;
  final LoggerContract _logger;

  AppBlocSignalObserver({
    StateMonitoringObserver? stateObserver,
    LoggerContract? logger,
  })  : _logger = logger ?? Monitoring.logger,
        _stateObserver = stateObserver ??
            StateMonitoringObserver(
              logger: logger ?? Monitoring.logger,
              crashReporter: Monitoring.crashReporter,
            );

  @override
  void onCreate(BlocSignalBase<dynamic> bloc) {
    super.onCreate(bloc);
    _logger.log(
      LogLevel.DEBUG,
      '[${bloc.runtimeType}] Created',
      context: {'bloc': bloc.runtimeType.toString()},
    );
  }

  @override
  void onEvent(BlocSignalBase<dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    _logger.log(
      LogLevel.DEBUG,
      '[${bloc.runtimeType}] Event: ${event.runtimeType}',
      context: {
        'bloc': bloc.runtimeType.toString(),
        'event': event.toString(),
      },
    );
  }

  @override
  void onChange(BlocSignalBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    _stateObserver.onStateChange(
      bloc.runtimeType.toString(),
      previousState: change.currentState,
      currentState: change.nextState,
      metadata: {
        'bloc': bloc.runtimeType.toString(),
      },
    );
  }

  @override
  void onTransition(
    BlocSignalBase<dynamic> bloc,
    Object? event,
    Object? state,
  ) {
    super.onTransition(bloc, event, state);
    _logger.log(
      LogLevel.DEBUG,
      '[${bloc.runtimeType}] Transition with ${event.runtimeType} -> $state',
      context: {
        'bloc': bloc.runtimeType.toString(),
        'event': event.toString(),
        'state': state.toString(),
      },
    );
  }

  @override
  void onError(
    BlocSignalBase<dynamic> bloc,
    Object error,
    StackTrace stackTrace,
  ) {
    super.onError(bloc, error, stackTrace);
    _stateObserver.onError(
      bloc.runtimeType.toString(),
      error,
      stackTrace,
      currentState: bloc.state.value,
    );
  }

  @override
  void onClose(BlocSignalBase<dynamic> bloc) {
    super.onClose(bloc);
    _logger.log(
      LogLevel.DEBUG,
      '[${bloc.runtimeType}] Closed',
      context: {'bloc': bloc.runtimeType.toString()},
    );
  }
}
