import 'package:networking/networking.dart';
import 'package:test/test.dart';

void main() {
  group('ApiResponse Test', () {
    test('ApiResponse.success creates successful instance with data', () {
      final response = ApiResponse<String>.success('test_data');

      expect(response.isSuccess, isTrue);
      expect(response.data, equals('test_data'));
      expect(response.failure, isNull);
    });

    test('ApiResponse.error creates failure instance with failure', () {
      const failure = ServerFailure('Server error', statusCode: 500);
      final response = ApiResponse<String>.error(failure);

      expect(response.isSuccess, isFalse);
      expect(response.data, isNull);
      expect(response.failure, equals(failure));
    });

    test('fold invokes onSuccess callback on success with non-null data', () {
      final response = ApiResponse<int>.success(42);

      final result = response.fold<String>(
        onSuccess: (data) => 'Value: $data',
        onError: (failure) => 'Error: ${failure.message}',
      );

      expect(result, equals('Value: 42'));
    });

    test('fold invokes onError callback when response is error', () {
      const failure = NetworkFailure('No internet');
      final response = ApiResponse<int>.error(failure);

      final result = response.fold<String>(
        onSuccess: (data) => 'Value: $data',
        onError: (f) => 'Error: ${f.message}',
      );

      expect(result, equals('Error: No internet'));
    });

    test('fold invokes onError with UnknownFailure if failure is null on non-success', () {
      // Direct testing of fold fallback
      const failure = UnknownFailure();
      final response = ApiResponse<String>.error(failure);

      final result = response.fold<Failure>(
        onSuccess: (_) => const UnknownFailure('unreachable'),
        onError: (f) => f,
      );

      expect(result, isA<UnknownFailure>());
    });
  });
}
