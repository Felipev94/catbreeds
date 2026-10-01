import 'dart:async';

import 'package:core/core.dart';
import 'package:get_it/get_it.dart';
import 'package:monitoring/monitoring.dart';

import '../di_module.dart';

class DioMonitoringInterceptor extends Interceptor {
  final NetworkMonitoringHelper _helper;
  final Expando<DateTime> _startTimes = Expando<DateTime>();

  DioMonitoringInterceptor({NetworkMonitoringHelper? helper})
      : _helper = helper ??
            NetworkMonitoringHelper(
              logger: Monitoring.logger,
              crashReporter: Monitoring.crashReporter,
            );

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _startTimes[options] = DateTime.now();

    _helper.onRequest(
      options.method,
      options.uri.toString(),
      headers: options.headers,
      body: options.data,
    );

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final DateTime? startTime = _startTimes[response.requestOptions];
    final Duration? duration =
        startTime != null ? DateTime.now().difference(startTime) : null;

    _helper.onResponse(
      response.requestOptions.method,
      response.requestOptions.uri.toString(),
      response.statusCode ?? 200,
      duration: duration,
      headers: response.headers.map,
      responseBody: response.data,
    );

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final DateTime? startTime = _startTimes[err.requestOptions];
    final Duration? duration =
        startTime != null ? DateTime.now().difference(startTime) : null;

    _helper.onError(
      err.requestOptions.method,
      err.requestOptions.uri.toString(),
      err.error ?? err.message ?? 'Unknown DioException',
      err.stackTrace,
      statusCode: err.response?.statusCode,
      duration: duration,
      context: {
        'type': err.type.name,
        if (err.response?.data != null) 'data': err.response?.data,
      },
    );

    super.onError(err, handler);
  }
}

final class NetworkModule implements DiModule {
  final NetworkOptions? customOptions;
  final Set<Interceptor>? customInterceptors;

  const NetworkModule({
    this.customOptions,
    this.customInterceptors,
  });

  @override
  FutureOr<void> register(GetIt sl) {
    final NetworkOptions options = customOptions ??
        NetworkOptions(
          baseUrl: const String.fromEnvironment('API_URL'),
          headers: {
            'x-api-key': const String.fromEnvironment('API_KEY'),
          },
        );

    final Set<Interceptor> interceptors = {
      DioMonitoringInterceptor(),
      ...?customInterceptors,
    };

    sl.registerLazySingleton<NetworkOptions>(() => options);

    sl.registerLazySingleton<Dio>(
      () => DioFactory.create(
        options: sl<NetworkOptions>(),
        globalInterceptors: interceptors,
      ),
    );
  }
}
