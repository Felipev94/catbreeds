import 'package:flutter/material.dart';

class AppThemeScope extends InheritedWidget {
  final ThemeMode themeMode;
  final VoidCallback onToggleTheme;
  final ValueChanged<ThemeMode> onThemeModeChanged;

  const AppThemeScope({
    required this.themeMode,
    required this.onToggleTheme,
    required this.onThemeModeChanged,
    required super.child,
    super.key,
  });

  static AppThemeScope of(BuildContext context) {
    final AppThemeScope? result =
        context.dependOnInheritedWidgetOfExactType<AppThemeScope>();
    assert(result != null, 'No AppThemeScope found in context');
    return result!;
  }

  static AppThemeScope? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppThemeScope>();
  }

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme() => onToggleTheme();

  void setThemeMode(ThemeMode mode) => onThemeModeChanged(mode);

  @override
  bool updateShouldNotify(covariant AppThemeScope oldWidget) {
    return themeMode != oldWidget.themeMode;
  }
}
