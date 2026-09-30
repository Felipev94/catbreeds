import 'package:dio/dio.dart';

final class NetworkOptions {
  final String baseUrl;
  final Duration connectTimeout;
  final Duration receiveTimeout;
  final Duration sendTimeout;
  final Map<String, dynamic>? headers;
  final Set<Interceptor>? additionalInterceptors;

  const NetworkOptions({
    required this.baseUrl,
    this.connectTimeout = const Duration(seconds: 15),
    this.receiveTimeout = const Duration(seconds: 15),
    this.sendTimeout = const Duration(seconds: 15),
    this.headers,
    this.additionalInterceptors,
  });
}
