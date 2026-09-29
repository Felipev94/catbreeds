import 'package:monitoring/monitoring.dart';
import 'package:test/test.dart';

class MockAnalyticsTracker implements AnalyticsTrackerContract {
  final List<String> screens = [];
  final List<Map<String, Object?>?> screenParameters = [];
  final List<MonitoringEvent> events = [];

  @override
  Future<void> trackScreen(
    String screenName, {
    String? screenClass,
    Map<String, Object?>? parameters,
  }) async {
    screens.add(screenName);
    screenParameters.add(parameters);
  }

  @override
  Future<void> trackEvent(MonitoringEvent event) async {
    events.add(event);
  }

  @override
  Future<void> setUserProperty(String name, String value) async {}
}

class MockCrashReporter implements CrashReporterContract {
  final List<Breadcrumb> breadcrumbs = [];
  final List<Object> errors = [];

  @override
  void addBreadcrumb(Breadcrumb breadcrumb) {
    breadcrumbs.add(breadcrumb);
  }

  @override
  Future<void> recordError(
    Object error,
    StackTrace? stackTrace, {
    String? reason,
    bool fatal = false,
    Map<String, Object?>? context,
  }) async {
    errors.add(error);
  }

  @override
  Future<void> setCustomKey(String key, Object value) async {}

  @override
  Future<void> setUserId(String? userId) async {}
}

void main() {
  group('NavigationMonitoringHelper', () {
    late MockAnalyticsTracker analytics;
    late MockCrashReporter crashReporter;
    late NavigationMonitoringHelper helper;

    setUp(() {
      analytics = MockAnalyticsTracker();
      crashReporter = MockCrashReporter();
      helper = NavigationMonitoringHelper(
        analytics: analytics,
        crashReporter: crashReporter,
      );
    });

    test('onRouteChanged tracks screen view and records breadcrumb', () {
      helper.onRouteChanged(
        routeName: '/property/123',
        previousRouteName: '/home',
        action: 'push',
      );

      expect(analytics.screens, contains('/property/123'));
      expect(analytics.screenParameters.first?['action'], 'push');
      expect(analytics.screenParameters.first?['previous_route'], '/home');

      expect(crashReporter.breadcrumbs.length, 1);
      expect(
        crashReporter.breadcrumbs.first.message,
        'Navigation [push]: /property/123',
      );
      expect(crashReporter.breadcrumbs.first.category, 'navigation');
    });

    test('onRouteChanged with arguments handles parameters cleanly', () {
      helper.onRouteChanged(
        routeName: '/checkout',
        action: 'replace',
        arguments: {'id': 99},
      );

      expect(analytics.screens, contains('/checkout'));
      expect(analytics.screenParameters.first?['action'], 'replace');
      expect(analytics.screenParameters.first?['arguments'], '{id: 99}');

      expect(crashReporter.breadcrumbs.length, 1);
      expect(
        crashReporter.breadcrumbs.first.message,
        'Navigation [replace]: /checkout',
      );
    });
  });
}
