import 'package:meta/meta.dart';

@immutable
class MonitoringEvent {
  final String name;
  final Map<String, Object?> parameters;
  final DateTime timestamp;

  MonitoringEvent(
    this.name, {
    Map<String, Object?>? parameters,
    DateTime? timestamp,
  }) : parameters = Map.unmodifiable(parameters ?? const {}),
       timestamp = timestamp ?? DateTime.now().toUtc();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MonitoringEvent &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          timestamp == other.timestamp;

  @override
  int get hashCode => name.hashCode ^ timestamp.hashCode;

  @override
  String toString() =>
      'MonitoringEvent(name: $name, parameters: $parameters, timestamp: $timestamp)';
}
