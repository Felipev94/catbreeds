import 'package:networking/networking.dart';
import 'package:test/test.dart';

void main() {
  group('Failures Test', () {
    test('ServerFailure should instantiate with message and optional statusCode', () {
      const failure = ServerFailure('Internal error', statusCode: 500);

      expect(failure, isA<Failure>());
      expect(failure.message, equals('Internal error'));
      expect(failure.statusCode, equals(500));
    });

    test('ServerFailure should instantiate with null statusCode by default', () {
      const failure = ServerFailure('Not found');

      expect(failure.message, equals('Not found'));
      expect(failure.statusCode, isNull);
    });

    test('NetworkFailure should have default message when omitted', () {
      const failure = NetworkFailure();

      expect(failure, isA<Failure>());
      expect(failure.message, equals('No internet connection'));
      expect(failure.statusCode, isNull);
    });

    test('NetworkFailure should accept custom message', () {
      const failure = NetworkFailure('Connection timed out');

      expect(failure.message, equals('Connection timed out'));
    });

    test('CacheFailure should have default message when omitted', () {
      const failure = CacheFailure();

      expect(failure, isA<Failure>());
      expect(failure.message, equals('Failed to load cached data'));
      expect(failure.statusCode, isNull);
    });

    test('CacheFailure should accept custom message', () {
      const failure = CacheFailure('Cache expired');

      expect(failure.message, equals('Cache expired'));
    });

    test('UnknownFailure should have default message when omitted', () {
      const failure = UnknownFailure();

      expect(failure, isA<Failure>());
      expect(failure.message, equals('An unexpected error occurred'));
      expect(failure.statusCode, isNull);
    });

    test('UnknownFailure should accept custom message', () {
      const failure = UnknownFailure('Unknown error message');

      expect(failure.message, equals('Unknown error message'));
    });
  });
}
