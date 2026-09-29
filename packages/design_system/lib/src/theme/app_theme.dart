import 'package:flutter/material.dart';

import '../tokens/elevations.dart';
import '../tokens/fonts.dart';
import '../tokens/radius.dart';
import '../tokens/spacing.dart';
import '../tokens/typography.dart';
import 'app_color_extension.dart';
import 'app_elevation_extension.dart';

abstract final class AppTheme {
  static ThemeData light({
    String displayFontFamily = AppFonts.displayFont,
    String bodyFontFamily = AppFonts.bodyFont,
  }) {
    return _buildTheme(
      brightness: Brightness.light,
      colorExt: AppColorExtension.light,
      elevationExt: AppElevationExtension.light,
      displayFontFamily: displayFontFamily,
      bodyFontFamily: bodyFontFamily,
    );
  }

  static ThemeData dark({
    String displayFontFamily = AppFonts.displayFont,
    String bodyFontFamily = AppFonts.bodyFont,
  }) {
    return _buildTheme(
      brightness: Brightness.dark,
      colorExt: AppColorExtension.dark,
      elevationExt: AppElevationExtension.dark,
      displayFontFamily: displayFontFamily,
      bodyFontFamily: bodyFontFamily,
    );
  }

  static ThemeData _buildTheme({
    required Brightness brightness,
    required AppColorExtension colorExt,
    required AppElevationExtension elevationExt,
    required String displayFontFamily,
    required String bodyFontFamily,
  }) {
    final ColorScheme colorScheme = ColorScheme(
      brightness: brightness,
      primary: colorExt.primary,
      onPrimary: colorExt.onPrimary,
      primaryContainer: colorExt.primaryContainer,
      onPrimaryContainer: colorExt.onPrimaryContainer,
      secondary: colorExt.secondary,
      onSecondary: colorExt.onSecondary,
      secondaryContainer: colorExt.secondaryContainer,
      onSecondaryContainer: colorExt.onSecondaryContainer,
      surface: colorExt.surface,
      onSurface: colorExt.onSurface,
      error: colorExt.error,
      onError: colorExt.onError,
    );

    final TextTheme textTheme = AppTypography.createTextTheme(
      displayFontFamily: displayFontFamily,
      bodyFontFamily: bodyFontFamily,
      defaultColor: colorExt.textPrimary,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorExt.background,
      textTheme: textTheme,
      extensions: <ThemeExtension<dynamic>>[colorExt, elevationExt],

      appBarTheme: AppBarTheme(
        elevation: AppElevation.LEVEL_0,
        scrolledUnderElevation: AppElevation.LEVEL_1,
        backgroundColor: colorExt.surface,
        foregroundColor: colorExt.textPrimary,
        centerTitle: false,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          color: colorExt.textPrimary,
          fontWeight: AppTypography.WEIGHT_BOLD,
        ),
      ),

      cardTheme: CardThemeData(
        elevation: AppElevation.LEVEL_1,
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.RADIUS_MD),
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        color: colorExt.surface, // Dinámico según el tema
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: AppElevation.LEVEL_1,
          backgroundColor: colorExt.primary,
          foregroundColor: colorExt.onPrimary,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.LG,
            vertical: AppSpacing.MD,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: AppRadius.RADIUS_SM,
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorExt.primary,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.LG,
            vertical: AppSpacing.MD,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: AppRadius.RADIUS_SM,
          ),
          side: BorderSide(color: colorExt.borderSubtle),
          textStyle: textTheme.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorExt.primary,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.MD,
            vertical: AppSpacing.SM,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: AppRadius.RADIUS_SM,
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorExt.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.MD,
          vertical: AppSpacing.MD,
        ),
        border: OutlineInputBorder(
          borderRadius: AppRadius.RADIUS_SM,
          borderSide: BorderSide(color: colorExt.borderSubtle),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.RADIUS_SM,
          borderSide: BorderSide(color: colorExt.borderSubtle),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.RADIUS_SM,
          borderSide: BorderSide(color: colorExt.borderFocus, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppRadius.RADIUS_SM,
          borderSide: BorderSide(color: colorExt.error),
        ),
        hintStyle: textTheme.bodyMedium?.copyWith(color: colorExt.textMuted),
        labelStyle: textTheme.bodyMedium?.copyWith(
          color: colorExt.textSecondary,
        ),
      ),

      dividerTheme: DividerThemeData(
        color: colorExt.borderSubtle,
        thickness: 1,
        space: 1,
      ),
    );
  }
}
