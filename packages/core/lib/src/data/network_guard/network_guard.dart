import 'dart:io';

import 'package:networking/networking.dart';

import '../entities/error/failures.dart';
import 'api_response.dart';

class NetworkGuard {
  static Future<ApiResponse<T>> execute<T>(
    Future<HttpResponse<T>> Function() apiCall,
  ) async {
    try {
      final HttpResponse<T> httpResponse = await apiCall();
      final Response<dynamic> response = httpResponse.response;

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return ApiResponse.success(httpResponse.data);
      } else {
        return ApiResponse.error(
          ServerFailure(
            _extractErrorMessage(response.data),
            statusCode: response.statusCode,
          ),
        );
      }
    } on DioException catch (e) {
      return ApiResponse.error(_handleDioError(e));
    } catch (e) {
      return ApiResponse.error(UnknownFailure(e.toString()));
    }
  }

  static Failure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return const NetworkFailure(
          "No internet connection or timeout occurred",
        );
      case DioExceptionType.badResponse:
        final int? statusCode = error.response?.statusCode;
        final String message = _extractErrorMessage(error.response?.data);
        return ServerFailure(message, statusCode: statusCode);
      case DioExceptionType.cancel:
        return const UnknownFailure("Request was cancelled");
      default:
        if (error.error is SocketException) {
          return const NetworkFailure();
        }
        return UnknownFailure(error.message ?? "Unexpected error occurred");
    }
  }

  static String _extractErrorMessage(dynamic data) {
    if (data is Map<String, dynamic> && data.containsKey('message')) {
      return data['message'].toString();
    }
    return "An error occurred while processing the request";
  }
}
