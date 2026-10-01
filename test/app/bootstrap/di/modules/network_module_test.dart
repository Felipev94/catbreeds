import 'package:catbreeds/app/bootstrap/di/modules/network_module.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:monitoring/monitoring.dart';
import 'package:core/core.dart';

class _FakeLogger extends Fake implements LoggerContract {
  @override
  void log(
    LogLevel level,
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, Object?>? context,
  }) {}
}

class _FakeCrashReporter extends Fake implements CrashReporterContract {
  @override
  void addBreadcrumb(Breadcrumb breadcrumb) {}

  @override
  Future<void> recordError(
    Object error,
    StackTrace? stackTrace, {
    String? reason,
    bool fatal = false,
    Map<String, Object?>? context,
  }) async {}
}

class _FakeRequestHandler extends Fake implements RequestInterceptorHandler {
  @override
  void next(RequestOptions options) {}
}

class _FakeResponseHandler extends Fake implements ResponseInterceptorHandler {
  @override
  void next(Response response) {}
}

class _FakeErrorHandler extends Fake implements ErrorInterceptorHandler {
  @override
  void next(DioException err) {}
}

void main() {
  late GetIt sl;

  setUp(() async {
    sl = GetIt.asNewInstance();
  });

  tearDown(() async {
    await sl.reset();
  });

  group('NetworkModule Test', () {
    test('registers NetworkOptions and Dio', () async {
      const module = NetworkModule();
      await module.register(sl);

      expect(sl.isRegistered<NetworkOptions>(), isTrue);
      expect(sl.isRegistered<Dio>(), isTrue);
      expect(sl<Dio>(), isA<Dio>());
    });

    test('registers custom NetworkOptions and custom Interceptors', () async {
      const customOptions = NetworkOptions(baseUrl: 'https://example.com/api');
      final customInterceptor = InterceptorsWrapper();

      final module = NetworkModule(
        customOptions: customOptions,
        customInterceptors: {customInterceptor},
      );
      await module.register(sl);

      expect(sl<NetworkOptions>().baseUrl, equals('https://example.com/api'));
      expect(sl<Dio>().interceptors, contains(customInterceptor));
    });

    test('DioMonitoringInterceptor delegates onRequest, onResponse, and onError without throwing', () {
      final helper = NetworkMonitoringHelper(
        logger: _FakeLogger(),
        crashReporter: _FakeCrashReporter(),
      );

      final interceptor = DioMonitoringInterceptor(helper: helper);
      final options = RequestOptions(path: '/test', method: 'GET');

      expect(
        () => interceptor.onRequest(options, _FakeRequestHandler()),
        returnsNormally,
      );

      final response = Response(
        requestOptions: options,
        statusCode: 200,
        data: {'success': true},
      );
      expect(
        () => interceptor.onResponse(response, _FakeResponseHandler()),
        returnsNormally,
      );

      final dioError = DioException(
        requestOptions: options,
        error: 'Network failure',
      );
      expect(
        () => interceptor.onError(dioError, _FakeErrorHandler()),
        returnsNormally,
      );
    });
  });
}
