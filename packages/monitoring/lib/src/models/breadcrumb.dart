import 'package:meta/meta.dart';

import 'log_level.dart';

@immutable
class Breadcrumb {
  final String message;
  final String? category;
  final LogLevel level;
  final DateTime timestamp;
  final Map<String, Object?> data;

  Breadcrumb({
    required this.message,
    this.category,
    this.level = LogLevel.INFO,
    DateTime? timestamp,
    Map<String, Object?>? data,
  }) : timestamp = timestamp ?? DateTime.now().toUtc(),
       data = Map.unmodifiable(data ?? const {});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Breadcrumb &&
          runtimeType == other.runtimeType &&
          message == other.message &&
          category == other.category &&
          level == other.level &&
          timestamp == other.timestamp;

  @override
  int get hashCode =>
      message.hashCode ^
      category.hashCode ^
      level.hashCode ^
      timestamp.hashCode;

  @override
  String toString() =>
      'Breadcrumb(message: $message, category: $category, level: $level, timestamp: $timestamp, data: $data)';
}
