import 'package:dio/dio.dart';

import '../config/network_options.dart';

abstract final class DioFactory {
  static const String _CONTENT_TYPE_HEADER = 'Content-Type';
  static const String _ACCEPT_HEADER = 'Accept';
  static const String _CONTENT_TYPE = 'application/json';

  static Dio create({
    required NetworkOptions options,
    required Set<Interceptor> globalInterceptors,
  }) {
    final BaseOptions baseOptions = BaseOptions(
      baseUrl: options.baseUrl,
      connectTimeout: options.connectTimeout,
      receiveTimeout: options.receiveTimeout,
      sendTimeout: options.sendTimeout,
      headers: {
        _CONTENT_TYPE_HEADER: _CONTENT_TYPE,
        _ACCEPT_HEADER: _CONTENT_TYPE,
        ...?options.headers,
      },
    );

    final Dio dio = Dio(baseOptions)..interceptors.addAll(globalInterceptors);

    if (options.additionalInterceptors != null &&
        options.additionalInterceptors!.isNotEmpty) {
      dio.interceptors.addAll(options.additionalInterceptors!);
    }

    return dio;
  }
}
