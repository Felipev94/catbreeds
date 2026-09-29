import 'dart:convert';

import '../contracts/crash_reporter_contract.dart';
import '../contracts/logger_contract.dart';
import '../models/breadcrumb.dart';
import '../models/log_level.dart';

class NetworkMonitoringHelper {
  final LoggerContract logger;
  final CrashReporterContract crashReporter;

  NetworkMonitoringHelper({required this.logger, required this.crashReporter});

  String toCurl({
    required String method,
    required String url,
    Map<String, Object?>? headers,
    Object? body,
  }) {
    final StringBuffer buffer = StringBuffer(
      'curl -X ${method.toUpperCase()} \'$url\'',
    );

    if (headers != null && headers.isNotEmpty) {
      for (final MapEntry<String, Object?> entry in headers.entries) {
        if (entry.value != null) {
          buffer.write(' \\\n  -H \'${entry.key}: ${entry.value}\'');
        }
      }
    }

    if (body != null) {
      final String bodyStr = body.toString();
      if (bodyStr.isNotEmpty) {
        final String escapedBody = bodyStr.replaceAll("'", r"'\''");
        buffer.write(' \\\n  --data \'$escapedBody\'');
      }
    }

    return buffer.toString();
  }

  void onRequest(
    String method,
    String url, {
    Map<String, Object?>? headers,
    Object? body,
  }) {
    final String curl = toCurl(
      method: method,
      url: url,
      headers: headers,
      body: body,
    );

    logger.log(
      LogLevel.DEBUG,
      '--> $method $url\n$curl',
      context: {'curl': curl, 'headers': ?headers, 'body': ?body?.toString()},
    );

    crashReporter.addBreadcrumb(
      Breadcrumb(
        message: 'HTTP $method $url',
        category: 'network',
        level: LogLevel.DEBUG,
        data: {'method': method, 'url': url, 'curl': curl},
      ),
    );
  }

  void onResponse(
    String method,
    String url,
    int statusCode, {
    Duration? duration,
    Map<String, Object?>? headers,
    Object? responseBody,
    int maxBodyChars = 2000,
  }) {
    final int durationMs = duration?.inMilliseconds ?? 0;
    final bool isSlow = durationMs >= 2000;
    final bool isSuccess = statusCode >= 200 && statusCode < 400;
    final LogLevel level = isSuccess
        ? (isSlow ? LogLevel.WARNING : LogLevel.INFO)
        : LogLevel.WARNING;
    final String statusText = _statusText(statusCode);

    final StringBuffer buffer = StringBuffer(
      '<-- [$statusCode $statusText] ${method.toUpperCase()} $url (${durationMs}ms)',
    );
    if (isSlow) {
      buffer.write(' [SLOW REQUEST]');
    }

    if (headers != null && headers.isNotEmpty) {
      buffer.write('\nHeaders:');
      for (final entry in headers.entries) {
        if (entry.value != null) {
          buffer.write('\n  ${entry.key}: ${entry.value}');
        }
      }
    }

    final String? formattedBody = _formatBody(
      responseBody,
      maxChars: maxBodyChars,
    );
    if (formattedBody != null && formattedBody.isNotEmpty) {
      buffer.write('\nBody:\n$formattedBody');
    }

    final String message = buffer.toString();

    logger.log(
      level,
      message,
      context: {
        'status_code': statusCode,
        'duration_ms': durationMs,
        'headers': ?headers,
        'body': ?formattedBody,
      },
    );

    crashReporter.addBreadcrumb(
      Breadcrumb(
        message:
            '<-- [$statusCode $statusText] ${method.toUpperCase()} $url (${durationMs}ms)',
        category: 'network',
        level: level,
        data: {
          'status_code': statusCode,
          'duration_ms': durationMs,
          'headers': ?headers,
        },
      ),
    );
  }

  Future<void> onError(
    String method,
    String url,
    Object error,
    StackTrace? stackTrace, {
    int? statusCode,
    Duration? duration,
    Map<String, Object?>? context,
  }) async {
    final int durationMs = duration?.inMilliseconds ?? 0;
    final String statusLabel = statusCode != null
        ? '[$statusCode ${_statusText(statusCode)}]'
        : '[ERROR]';
    final String message =
        '<-- HTTP $statusLabel ${method.toUpperCase()} $url (${durationMs}ms): $error';

    logger.log(
      LogLevel.ERROR,
      message,
      error: error,
      stackTrace: stackTrace,
      context: context,
    );

    crashReporter.addBreadcrumb(
      Breadcrumb(
        message: message,
        category: 'network',
        level: LogLevel.ERROR,
        data: {'status_code': ?statusCode, 'duration_ms': durationMs},
      ),
    );

    await crashReporter.recordError(
      error,
      stackTrace,
      reason: 'HTTP failure: $method $url',
      fatal: false,
      context: {
        'method': method,
        'url': url,
        'status_code': ?statusCode,
        'duration_ms': durationMs,
        ...?context,
      },
    );
  }

  String _statusText(int statusCode) {
    return switch (statusCode) {
      200 => 'OK',
      201 => 'Created',
      202 => 'Accepted',
      204 => 'No Content',
      301 => 'Moved Permanently',
      302 => 'Found',
      304 => 'Not Modified',
      400 => 'Bad Request',
      401 => 'Unauthorized',
      403 => 'Forbidden',
      404 => 'Not Found',
      405 => 'Method Not Allowed',
      408 => 'Request Timeout',
      409 => 'Conflict',
      422 => 'Unprocessable Entity',
      429 => 'Too Many Requests',
      500 => 'Internal Server Error',
      502 => 'Bad Gateway',
      503 => 'Service Unavailable',
      504 => 'Gateway Timeout',
      _ => 'STATUS_$statusCode',
    };
  }

  String? _formatBody(Object? body, {int maxChars = 2000}) {
    if (body == null) return null;
    String formatted;
    if (body is Map || body is List) {
      try {
        const JsonEncoder encoder = JsonEncoder.withIndent('  ');
        formatted = encoder.convert(body);
      } catch (_) {
        formatted = body.toString();
      }
    } else if (body is String) {
      try {
        final Map<String, dynamic> decoded = jsonDecode(body);
        const JsonEncoder encoder = JsonEncoder.withIndent('  ');
        formatted = encoder.convert(decoded);
      } catch (_) {
        formatted = body;
      }
    } else {
      formatted = body.toString();
    }

    if (formatted.length > maxChars) {
      final int truncatedCount = formatted.length - maxChars;
      return '${formatted.substring(0, maxChars)}\n... [truncated $truncatedCount characters]';
    }
    return formatted;
  }
}
