import 'package:flutter/widgets.dart';
import 'package:monitoring/monitoring.dart';

class AppNavigationObserver extends NavigatorObserver {
  final NavigationMonitoringHelper _helper;

  AppNavigationObserver({NavigationMonitoringHelper? helper})
      : _helper = helper ??
            NavigationMonitoringHelper(
              analytics: Monitoring.analytics,
              crashReporter: Monitoring.crashReporter,
            );

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    final String routeName = _extractRouteName(route);
    final String? previousRouteName =
        previousRoute != null ? _extractRouteName(previousRoute) : null;

    _helper.onRouteChanged(
      routeName: routeName,
      previousRouteName: previousRouteName,
      action: 'push',
      arguments: _extractArguments(route),
    );
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    final String routeName = _extractRouteName(route);
    final String? previousRouteName =
        previousRoute != null ? _extractRouteName(previousRoute) : null;

    _helper.onRouteChanged(
      routeName: routeName,
      previousRouteName: previousRouteName,
      action: 'pop',
      arguments: _extractArguments(route),
    );
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute == null) return;

    final String routeName = _extractRouteName(newRoute);
    final String? previousRouteName =
        oldRoute != null ? _extractRouteName(oldRoute) : null;

    _helper.onRouteChanged(
      routeName: routeName,
      previousRouteName: previousRouteName,
      action: 'replace',
      arguments: _extractArguments(newRoute),
    );
  }

  String _extractRouteName(Route<dynamic> route) {
    return route.settings.name ?? route.settings.toString();
  }

  Map<String, Object?>? _extractArguments(Route<dynamic> route) {
    final Object? args = route.settings.arguments;
    if (args is Map<String, Object?>) {
      return args;
    }
    if (args != null) {
      return {'arguments': args.toString()};
    }
    return null;
  }
}
