import 'dart:io';

import 'package:networking/networking.dart';
import 'package:test/test.dart';

void main() {
  group('NetworkGuard Test', () {
    test('returns ApiResponse.success when apiCall returns status 200..299', () async {
      final requestOptions = RequestOptions(path: '/test');
      final response = Response<dynamic>(
        data: {'success': true},
        statusCode: 200,
        requestOptions: requestOptions,
      );
      final httpResponse = HttpResponse<String>('hello', response);

      final result = await NetworkGuard.execute(() async => httpResponse);

      expect(result.isSuccess, isTrue);
      expect(result.data, equals('hello'));
      expect(result.failure, isNull);
    });

    test('returns ServerFailure with extracted message when status is non-2xx', () async {
      final requestOptions = RequestOptions(path: '/test');
      final response = Response<dynamic>(
        data: {'message': 'Unauthorized access'},
        statusCode: 401,
        requestOptions: requestOptions,
      );
      final httpResponse = HttpResponse<String>('ignored', response);

      final result = await NetworkGuard.execute(() async => httpResponse);

      expect(result.isSuccess, isFalse);
      expect(result.failure, isA<ServerFailure>());
      final failure = result.failure as ServerFailure;
      expect(failure.message, equals('Unauthorized access'));
      expect(failure.statusCode, equals(401));
    });

    test('returns ServerFailure with default message when non-2xx body has no message key', () async {
      final requestOptions = RequestOptions(path: '/test');
      final response = Response<dynamic>(
        data: 'plain error string',
        statusCode: 500,
        requestOptions: requestOptions,
      );
      final httpResponse = HttpResponse<String>('ignored', response);

      final result = await NetworkGuard.execute(() async => httpResponse);

      expect(result.isSuccess, isFalse);
      expect(result.failure, isA<ServerFailure>());
      final failure = result.failure as ServerFailure;
      expect(
        failure.message,
        equals('An error occurred while processing the request'),
      );
      expect(failure.statusCode, equals(500));
    });

    group('DioException handling', () {
      final requestOptions = RequestOptions(path: '/test');

      test('connectionTimeout returns NetworkFailure with timeout message', () async {
        final exception = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.connectionTimeout,
        );

        final result = await NetworkGuard.execute<String>(() async {
          throw exception;
        });

        expect(result.isSuccess, isFalse);
        expect(result.failure, isA<NetworkFailure>());
        expect(
          result.failure?.message,
          equals('No internet connection or timeout occurred'),
        );
      });

      test('sendTimeout returns NetworkFailure with timeout message', () async {
        final exception = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.sendTimeout,
        );

        final result = await NetworkGuard.execute<String>(() async {
          throw exception;
        });

        expect(result.isSuccess, isFalse);
        expect(result.failure, isA<NetworkFailure>());
        expect(
          result.failure?.message,
          equals('No internet connection or timeout occurred'),
        );
      });

      test('receiveTimeout returns NetworkFailure with timeout message', () async {
        final exception = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.receiveTimeout,
        );

        final result = await NetworkGuard.execute<String>(() async {
          throw exception;
        });

        expect(result.isSuccess, isFalse);
        expect(result.failure, isA<NetworkFailure>());
        expect(
          result.failure?.message,
          equals('No internet connection or timeout occurred'),
        );
      });

      test('connectionError returns NetworkFailure with timeout message', () async {
        final exception = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.connectionError,
        );

        final result = await NetworkGuard.execute<String>(() async {
          throw exception;
        });

        expect(result.isSuccess, isFalse);
        expect(result.failure, isA<NetworkFailure>());
        expect(
          result.failure?.message,
          equals('No internet connection or timeout occurred'),
        );
      });

      test('badResponse returns ServerFailure with extracted message', () async {
        final exception = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: requestOptions,
            statusCode: 404,
            data: {'message': 'Resource not found'},
          ),
        );

        final result = await NetworkGuard.execute<String>(() async {
          throw exception;
        });

        expect(result.isSuccess, isFalse);
        expect(result.failure, isA<ServerFailure>());
        final failure = result.failure as ServerFailure;
        expect(failure.message, equals('Resource not found'));
        expect(failure.statusCode, equals(404));
      });

      test('badResponse returns ServerFailure with fallback message if response data is not a map', () async {
        final exception = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: requestOptions,
            statusCode: 502,
            data: null,
          ),
        );

        final result = await NetworkGuard.execute<String>(() async {
          throw exception;
        });

        expect(result.isSuccess, isFalse);
        expect(result.failure, isA<ServerFailure>());
        final failure = result.failure as ServerFailure;
        expect(
          failure.message,
          equals('An error occurred while processing the request'),
        );
        expect(failure.statusCode, equals(502));
      });

      test('cancel returns UnknownFailure with cancelled message', () async {
        final exception = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.cancel,
        );

        final result = await NetworkGuard.execute<String>(() async {
          throw exception;
        });

        expect(result.isSuccess, isFalse);
        expect(result.failure, isA<UnknownFailure>());
        expect(result.failure?.message, equals('Request was cancelled'));
      });

      test('default DioException with SocketException returns NetworkFailure', () async {
        final exception = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.unknown,
          error: const SocketException('Connection failed'),
        );

        final result = await NetworkGuard.execute<String>(() async {
          throw exception;
        });

        expect(result.isSuccess, isFalse);
        expect(result.failure, isA<NetworkFailure>());
        expect(result.failure?.message, equals('No internet connection'));
      });

      test('default DioException without SocketException returns UnknownFailure with message', () async {
        final exception = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.unknown,
          message: 'SSL Handshake failed',
        );

        final result = await NetworkGuard.execute<String>(() async {
          throw exception;
        });

        expect(result.isSuccess, isFalse);
        expect(result.failure, isA<UnknownFailure>());
        expect(result.failure?.message, equals('SSL Handshake failed'));
      });

      test('default DioException without message returns UnknownFailure with default message', () async {
        final exception = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.unknown,
        );

        final result = await NetworkGuard.execute<String>(() async {
          throw exception;
        });

        expect(result.isSuccess, isFalse);
        expect(result.failure, isA<UnknownFailure>());
        expect(result.failure?.message, equals('Unexpected error occurred'));
      });
    });

    test('catches generic Exception and returns UnknownFailure', () async {
      final result = await NetworkGuard.execute<String>(() async {
        throw const FormatException('Invalid format');
      });

      expect(result.isSuccess, isFalse);
      expect(result.failure, isA<UnknownFailure>());
      expect(result.failure?.message, contains('FormatException'));
    });
  });
}
