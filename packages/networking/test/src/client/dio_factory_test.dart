import 'package:networking/src/config/network_options.dart';
import 'package:test/test.dart';
import 'package:networking/networking.dart';

class _MockGlobalInterceptor extends Interceptor {}

class _MockFeatureInterceptor extends Interceptor {}

void main() {
  group('DioFactory Test', () {
    late Set<Interceptor> globalInterceptors;
    late _MockGlobalInterceptor mockGlobalInterceptor;

    setUp(() {
      mockGlobalInterceptor = _MockGlobalInterceptor();
      globalInterceptors = {mockGlobalInterceptor};
    });

    tearDown(() {
      globalInterceptors.clear();
    });

    test('debe crear una instancia de Dio con las opciones base y headers predeterminados', () {
      const NetworkOptions options = NetworkOptions(
        baseUrl: 'https://api.example.com/v1',
      );

      final Dio dio = DioFactory.create(
        options: options,
        globalInterceptors: globalInterceptors,
      );

      expect(dio, isA<Dio>());
      expect(dio.options.baseUrl, equals('https://api.example.com/v1'));
      expect(dio.options.connectTimeout, equals(const Duration(seconds: 15)));
      expect(dio.options.receiveTimeout, equals(const Duration(seconds: 15)));
      expect(dio.options.sendTimeout, equals(const Duration(seconds: 15)));
      expect(dio.options.headers['Content-Type'], equals('application/json'));
      expect(dio.options.headers['Accept'], equals('application/json'));
    });

    test(
      'debe fusionar headers adicionales manteniendo los predeterminados',
      () {
        const NetworkOptions options = NetworkOptions(
          baseUrl: 'https://api.example.com/v1',
          headers: {
            'Authorization': 'Bearer sample_token',
            'X-App-Version': '1.0.0',
          },
        );

        final Dio dio = DioFactory.create(
          options: options,
          globalInterceptors: globalInterceptors,
        );

        expect(dio.options.headers['Content-Type'], equals('application/json'));
        expect(dio.options.headers['Accept'], equals('application/json'));
        expect(
          dio.options.headers['Authorization'],
          equals('Bearer sample_token'),
        );
        expect(dio.options.headers['X-App-Version'], equals('1.0.0'));
      },
    );

    test(
      'debe registrar los interceptores globales en la instancia de Dio',
      () {
        const NetworkOptions options = NetworkOptions(
          baseUrl: 'https://api.example.com/v1',
        );

        final Dio dio = DioFactory.create(
          options: options,
          globalInterceptors: globalInterceptors,
        );

        expect(dio.interceptors, contains(mockGlobalInterceptor));
        expect(
          dio.interceptors.whereType<_MockGlobalInterceptor>().length,
          equals(1),
        );
      },
    );

    test('debe registrar interceptores globales y adicionales del feature en el orden correcto', () {
      final _MockFeatureInterceptor mockFeatureInterceptor =
          _MockFeatureInterceptor();
      final NetworkOptions options = NetworkOptions(
        baseUrl: 'https://api.example.com/v1',
        additionalInterceptors: {mockFeatureInterceptor},
      );

      final Dio dio = DioFactory.create(
        options: options,
        globalInterceptors: globalInterceptors,
      );

      expect(
        dio.interceptors.whereType<_MockGlobalInterceptor>().length,
        equals(1),
      );
      expect(
        dio.interceptors.whereType<_MockFeatureInterceptor>().length,
        equals(1),
      );
    });
  });
}
