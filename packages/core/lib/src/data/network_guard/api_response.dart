
import '../entities/error/failures.dart';

class ApiResponse<T> {
  final T? data;
  final Failure? failure;
  final bool isSuccess;

  const ApiResponse._({this.data, this.failure, required this.isSuccess});

  factory ApiResponse.success(T data) {
    return ApiResponse._(data: data, isSuccess: true);
  }

  factory ApiResponse.error(Failure failure) {
    return ApiResponse._(failure: failure, isSuccess: false);
  }

  R fold<R>({
    required R Function(T data) onSuccess,
    required R Function(Failure failure) onError,
  }) {
    if (isSuccess && data != null) {
      return onSuccess(data as T);
    } else {
      return onError(failure ?? const UnknownFailure());
    }
  }
}
