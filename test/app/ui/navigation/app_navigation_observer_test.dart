import 'package:catbreeds/app/ui/navigation/app_navigation_observer.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:monitoring/monitoring.dart';

class _FakeAnalyticsTracker extends Fake implements AnalyticsTrackerContract {
  final List<String> screens = [];
  final List<Map<String, Object?>?> params = [];

  @override
  Future<void> trackScreen(
    String screenName, {
    String? screenClass,
    Map<String, Object?>? parameters,
  }) async {
    screens.add(screenName);
    params.add(parameters);
  }
}

class _FakeCrashReporter extends Fake implements CrashReporterContract {
  final List<Breadcrumb> breadcrumbs = [];

  @override
  void addBreadcrumb(Breadcrumb breadcrumb) {
    breadcrumbs.add(breadcrumb);
  }
}

void main() {
  late _FakeAnalyticsTracker analytics;
  late _FakeCrashReporter crashReporter;
  late NavigationMonitoringHelper helper;
  late AppNavigationObserver observer;

  setUp(() {
    analytics = _FakeAnalyticsTracker();
    crashReporter = _FakeCrashReporter();
    helper = NavigationMonitoringHelper(
      analytics: analytics,
      crashReporter: crashReporter,
    );
    observer = AppNavigationObserver(helper: helper);
  });

  group('AppNavigationObserver Test', () {
    test('didPush reports route push event to helper', () {
      final route = PageRouteBuilder<void>(
        settings: const RouteSettings(name: '/cats', arguments: {'search': 'test'}),
        pageBuilder: (_, _, _) => const SizedBox.shrink(),
      );
      final previousRoute = PageRouteBuilder<void>(
        settings: const RouteSettings(name: '/home'),
        pageBuilder: (_, _, _) => const SizedBox.shrink(),
      );

      observer.didPush(route, previousRoute);

      expect(analytics.screens, contains('/cats'));
      expect(analytics.params.first?['action'], equals('push'));
      expect(analytics.params.first?['previous_route'], equals('/home'));
      expect(analytics.params.first?['arguments'], contains('search'));

      expect(crashReporter.breadcrumbs.length, equals(1));
      expect(
        crashReporter.breadcrumbs.first.message,
        equals('Navigation [push]: /cats'),
      );
    });

    test('didPop reports route pop event to helper', () {
      final route = PageRouteBuilder<void>(
        settings: const RouteSettings(name: '/cats/detail'),
        pageBuilder: (_, _, _) => const SizedBox.shrink(),
      );
      final previousRoute = PageRouteBuilder<void>(
        settings: const RouteSettings(name: '/cats'),
        pageBuilder: (_, _, _) => const SizedBox.shrink(),
      );

      observer.didPop(route, previousRoute);

      expect(analytics.screens, contains('/cats/detail'));
      expect(analytics.params.first?['action'], equals('pop'));
      expect(analytics.params.first?['previous_route'], equals('/cats'));

      expect(crashReporter.breadcrumbs.length, equals(1));
      expect(
        crashReporter.breadcrumbs.first.message,
        equals('Navigation [pop]: /cats/detail'),
      );
    });

    test('didReplace reports route replace event to helper', () {
      final oldRoute = PageRouteBuilder<void>(
        settings: const RouteSettings(name: '/login'),
        pageBuilder: (_, _, _) => const SizedBox.shrink(),
      );
      final newRoute = PageRouteBuilder<void>(
        settings: const RouteSettings(name: '/cats'),
        pageBuilder: (_, _, _) => const SizedBox.shrink(),
      );

      observer.didReplace(newRoute: newRoute, oldRoute: oldRoute);

      expect(analytics.screens, contains('/cats'));
      expect(analytics.params.first?['action'], equals('replace'));
      expect(analytics.params.first?['previous_route'], equals('/login'));

      expect(crashReporter.breadcrumbs.length, equals(1));
      expect(
        crashReporter.breadcrumbs.first.message,
        equals('Navigation [replace]: /cats'),
      );
    });
  });
}
