import '../models/monitoring_event.dart';

abstract interface class AnalyticsTrackerContract {
  Future<void> trackEvent(MonitoringEvent event);

  Future<void> trackScreen(
    String screenName, {
    String? screenClass,
    Map<String, Object?>? parameters,
  });

  Future<void> setUserProperty(String name, String value);
}
