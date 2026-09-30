import 'package:dio/dio.dart';
import 'package:test/test.dart';
import 'package:networking/src/config/network_options.dart';

void main() {
  group('NetworkOptions Test', () {
    test('debe asignar los valores por defecto correctamente', () {
      const String baseUrl = 'https://api.example.com/v1';

      const NetworkOptions options = NetworkOptions(baseUrl: baseUrl);

      expect(options.baseUrl, equals(baseUrl));
      expect(options.connectTimeout, equals(const Duration(seconds: 15)));
      expect(options.receiveTimeout, equals(const Duration(seconds: 15)));
      expect(options.sendTimeout, equals(const Duration(seconds: 15)));
      expect(options.headers, isNull);
      expect(options.additionalInterceptors, isNull);
    });

    test('debe permitir sobrescribir los valores por defecto', () {
      const String baseUrl = 'https://api.example.com/v2';
      const Duration customTimeout = Duration(seconds: 30);
      const Map<String, String> customHeaders = {
        'X-Custom-Header': 'TestValue',
      };
      final Interceptor customInterceptor = Interceptor();

      final NetworkOptions options = NetworkOptions(
        baseUrl: baseUrl,
        connectTimeout: customTimeout,
        receiveTimeout: customTimeout,
        sendTimeout: customTimeout,
        headers: customHeaders,
        additionalInterceptors: {customInterceptor},
      );

      expect(options.baseUrl, equals(baseUrl));
      expect(options.connectTimeout, equals(customTimeout));
      expect(options.receiveTimeout, equals(customTimeout));
      expect(options.sendTimeout, equals(customTimeout));
      expect(options.headers, equals(customHeaders));
      expect(options.additionalInterceptors, contains(customInterceptor));
    });
  });
}
