import 'package:flutter/material.dart';

import 'app_theme_scope.dart';

class AppThemeProvider extends StatefulWidget {
  final ThemeMode initialThemeMode;
  final Widget? child;
  final Widget Function(BuildContext context, ThemeMode themeMode)? builder;

  const AppThemeProvider({
    this.initialThemeMode = ThemeMode.light,
    this.child,
    this.builder,
    super.key,
  }) : assert(
          child != null || builder != null,
          'Either child or builder must be provided',
        );

  static AppThemeScope of(BuildContext context) => AppThemeScope.of(context);

  static AppThemeScope? maybeOf(BuildContext context) =>
      AppThemeScope.maybeOf(context);

  static void toggleTheme(BuildContext context) => of(context).toggleTheme();

  static void setThemeMode(BuildContext context, ThemeMode mode) =>
      of(context).setThemeMode(mode);

  @override
  State<AppThemeProvider> createState() => _AppThemeProviderState();
}

class _AppThemeProviderState extends State<AppThemeProvider> {
  late ThemeMode _themeMode;

  @override
  void initState() {
    super.initState();
    _themeMode = widget.initialThemeMode;
  }

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  void _setThemeMode(ThemeMode mode) {
    if (_themeMode != mode) {
      setState(() {
        _themeMode = mode;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppThemeScope(
      themeMode: _themeMode,
      onToggleTheme: _toggleTheme,
      onThemeModeChanged: _setThemeMode,
      child: widget.builder != null
          ? Builder(
              builder: (context) => widget.builder!(context, _themeMode),
            )
          : widget.child!,
    );
  }
}
