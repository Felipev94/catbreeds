import '../contracts/analytics_tracker_contract.dart';
import '../contracts/crash_reporter_contract.dart';
import '../models/breadcrumb.dart';
import '../models/log_level.dart';

class NavigationMonitoringHelper {
  final AnalyticsTrackerContract analytics;
  final CrashReporterContract crashReporter;

  NavigationMonitoringHelper({
    required this.analytics,
    required this.crashReporter,
  });

  void onRouteChanged({
    required String routeName,
    String? previousRouteName,
    String action = 'push',
    Map<String, Object?>? arguments,
  }) {
    analytics.trackScreen(
      routeName,
      parameters: {
        'action': action,
        'previous_route': ?previousRouteName,
        'arguments': ?arguments?.toString(),
      },
    );

    crashReporter.addBreadcrumb(
      Breadcrumb(
        message: 'Navigation [$action]: $routeName',
        category: 'navigation',
        level: LogLevel.INFO,
        data: {
          'action': action,
          'route': routeName,
          'previous_route': ?previousRouteName,
        },
      ),
    );
  }
}
