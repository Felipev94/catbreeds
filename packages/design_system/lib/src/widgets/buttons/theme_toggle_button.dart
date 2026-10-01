import 'package:flutter/material.dart';

import '../../extensions/context_extensions.dart';
import '../../theme/app_theme_scope.dart';

class ThemeToggleButton extends StatelessWidget {
  final VoidCallback? onToggle;
  final Color? color;
  final double? size;
  final String? tooltip;

  const ThemeToggleButton({
    this.onToggle,
    this.color,
    this.size,
    this.tooltip,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AppThemeScope? themeScope = AppThemeScope.maybeOf(context);
    final bool isDark = themeScope?.isDarkMode ?? context.isDarkMode;

    return IconButton(
      tooltip: tooltip,
      icon: Icon(
        isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
        color: color,
        size: size ?? context.dimensions.dimensionLg,
      ),
      onPressed: onToggle ?? themeScope?.toggleTheme,
    );
  }
}
