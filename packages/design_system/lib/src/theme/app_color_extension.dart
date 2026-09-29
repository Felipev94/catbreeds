import 'package:flutter/material.dart';

import '../tokens/colors.dart';

class AppColorExtension extends ThemeExtension<AppColorExtension> {
  const AppColorExtension({
    required this.primary,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.surfaceContainer,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.textInverse,
    required this.borderSubtle,
    required this.borderStrong,
    required this.borderFocus,
    required this.success,
    required this.onSuccess,
    required this.successBackground,
    required this.warning,
    required this.onWarning,
    required this.warningBackground,
    required this.error,
    required this.onError,
    required this.errorBackground,
    required this.info,
    required this.onInfo,
    required this.infoBackground,
  });

  final Color primary;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;

  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;

  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceContainer;

  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color textInverse;

  final Color borderSubtle;
  final Color borderStrong;
  final Color borderFocus;

  final Color success;
  final Color onSuccess;
  final Color successBackground;

  final Color warning;
  final Color onWarning;
  final Color warningBackground;

  final Color error;
  final Color onError;
  final Color errorBackground;

  final Color info;
  final Color onInfo;
  final Color infoBackground;

  static const AppColorExtension light = AppColorExtension(
    primary: AppColors.PRIMARY_800,
    onPrimary: AppColors.WHITE,
    primaryContainer: AppColors.PRIMARY_50,
    onPrimaryContainer: AppColors.PRIMARY_900,
    secondary: AppColors.SECONDARY_600,
    onSecondary: AppColors.WHITE,
    secondaryContainer: AppColors.SECONDARY_50,
    onSecondaryContainer: AppColors.SECONDARY_900,
    background: AppColors.NEUTRAL_50,
    onBackground: AppColors.NEUTRAL_900,
    surface: AppColors.WHITE,
    onSurface: AppColors.NEUTRAL_900,
    surfaceContainer: AppColors.NEUTRAL_100,
    textPrimary: AppColors.NEUTRAL_900,
    textSecondary: AppColors.NEUTRAL_600,
    textMuted: AppColors.NEUTRAL_400,
    textInverse: AppColors.WHITE,
    borderSubtle: AppColors.NEUTRAL_200,
    borderStrong: AppColors.NEUTRAL_300,
    borderFocus: AppColors.PRIMARY_600,
    success: AppColors.SUCCESS,
    onSuccess: AppColors.WHITE,
    successBackground: AppColors.SUCCESS_BACKGROUND,
    warning: AppColors.WARNING,
    onWarning: AppColors.WHITE,
    warningBackground: AppColors.WARNING_BACKGROUND,
    error: AppColors.ERROR,
    onError: AppColors.WHITE,
    errorBackground: AppColors.ERROR_BACKGROUND,
    info: AppColors.INFO,
    onInfo: AppColors.WHITE,
    infoBackground: AppColors.INFO_BACKGROUND,
  );

  static const AppColorExtension dark = AppColorExtension(
    primary: AppColors.PRIMARY_300,
    onPrimary: AppColors.PRIMARY_900,
    primaryContainer: AppColors.PRIMARY_800,
    onPrimaryContainer: AppColors.PRIMARY_100,
    secondary: AppColors.SECONDARY_400,
    onSecondary: AppColors.SECONDARY_900,
    secondaryContainer: AppColors.SECONDARY_800,
    onSecondaryContainer: AppColors.SECONDARY_100,
    background: AppColors.NEUTRAL_900,
    onBackground: AppColors.NEUTRAL_50,
    surface: AppColors.NEUTRAL_800,
    onSurface: AppColors.NEUTRAL_50,
    surfaceContainer: AppColors.NEUTRAL_700,
    textPrimary: AppColors.NEUTRAL_50,
    textSecondary: AppColors.NEUTRAL_400,
    textMuted: AppColors.NEUTRAL_500,
    textInverse: AppColors.NEUTRAL_900,
    borderSubtle: AppColors.NEUTRAL_700,
    borderStrong: AppColors.NEUTRAL_600,
    borderFocus: AppColors.PRIMARY_300,
    success: AppColors.SUCCESS_LIGHT,
    onSuccess: AppColors.NEUTRAL_950,
    successBackground: Color(0xFF052E16),
    warning: AppColors.WARNING_LIGHT,
    onWarning: AppColors.NEUTRAL_950,
    warningBackground: Color(0xFF451A03),
    error: AppColors.ERROR_LIGHT,
    onError: AppColors.NEUTRAL_950,
    errorBackground: Color(0xFF450A0A),
    info: AppColors.INFO_LIGHT,
    onInfo: AppColors.NEUTRAL_950,
    infoBackground: Color(0xFF172554),
  );

  @override
  AppColorExtension copyWith({
    Color? primary,
    Color? onPrimary,
    Color? primaryContainer,
    Color? onPrimaryContainer,
    Color? secondary,
    Color? onSecondary,
    Color? secondaryContainer,
    Color? onSecondaryContainer,
    Color? background,
    Color? onBackground,
    Color? surface,
    Color? onSurface,
    Color? surfaceContainer,
    Color? textPrimary,
    Color? textSecondary,
    Color? textMuted,
    Color? textInverse,
    Color? borderSubtle,
    Color? borderStrong,
    Color? borderFocus,
    Color? success,
    Color? onSuccess,
    Color? successBackground,
    Color? warning,
    Color? onWarning,
    Color? warningBackground,
    Color? error,
    Color? onError,
    Color? errorBackground,
    Color? info,
    Color? onInfo,
    Color? infoBackground,
  }) {
    return AppColorExtension(
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      primaryContainer: primaryContainer ?? this.primaryContainer,
      onPrimaryContainer: onPrimaryContainer ?? this.onPrimaryContainer,
      secondary: secondary ?? this.secondary,
      onSecondary: onSecondary ?? this.onSecondary,
      secondaryContainer: secondaryContainer ?? this.secondaryContainer,
      onSecondaryContainer: onSecondaryContainer ?? this.onSecondaryContainer,
      background: background ?? this.background,
      onBackground: onBackground ?? this.onBackground,
      surface: surface ?? this.surface,
      onSurface: onSurface ?? this.onSurface,
      surfaceContainer: surfaceContainer ?? this.surfaceContainer,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textMuted: textMuted ?? this.textMuted,
      textInverse: textInverse ?? this.textInverse,
      borderSubtle: borderSubtle ?? this.borderSubtle,
      borderStrong: borderStrong ?? this.borderStrong,
      borderFocus: borderFocus ?? this.borderFocus,
      success: success ?? this.success,
      onSuccess: onSuccess ?? this.onSuccess,
      successBackground: successBackground ?? this.successBackground,
      warning: warning ?? this.warning,
      onWarning: onWarning ?? this.onWarning,
      warningBackground: warningBackground ?? this.warningBackground,
      error: error ?? this.error,
      onError: onError ?? this.onError,
      errorBackground: errorBackground ?? this.errorBackground,
      info: info ?? this.info,
      onInfo: onInfo ?? this.onInfo,
      infoBackground: infoBackground ?? this.infoBackground,
    );
  }

  @override
  AppColorExtension lerp(ThemeExtension<AppColorExtension>? other, double t) {
    if (other is! AppColorExtension) return this;

    return AppColorExtension(
      primary: Color.lerp(primary, other.primary, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      primaryContainer: Color.lerp(
        primaryContainer,
        other.primaryContainer,
        t,
      )!,
      onPrimaryContainer: Color.lerp(
        onPrimaryContainer,
        other.onPrimaryContainer,
        t,
      )!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      onSecondary: Color.lerp(onSecondary, other.onSecondary, t)!,
      secondaryContainer: Color.lerp(
        secondaryContainer,
        other.secondaryContainer,
        t,
      )!,
      onSecondaryContainer: Color.lerp(
        onSecondaryContainer,
        other.onSecondaryContainer,
        t,
      )!,
      background: Color.lerp(background, other.background, t)!,
      onBackground: Color.lerp(onBackground, other.onBackground, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      onSurface: Color.lerp(onSurface, other.onSurface, t)!,
      surfaceContainer: Color.lerp(
        surfaceContainer,
        other.surfaceContainer,
        t,
      )!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      textInverse: Color.lerp(textInverse, other.textInverse, t)!,
      borderSubtle: Color.lerp(borderSubtle, other.borderSubtle, t)!,
      borderStrong: Color.lerp(borderStrong, other.borderStrong, t)!,
      borderFocus: Color.lerp(borderFocus, other.borderFocus, t)!,
      success: Color.lerp(success, other.success, t)!,
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t)!,
      successBackground: Color.lerp(
        successBackground,
        other.successBackground,
        t,
      )!,
      warning: Color.lerp(warning, other.warning, t)!,
      onWarning: Color.lerp(onWarning, other.onWarning, t)!,
      warningBackground: Color.lerp(
        warningBackground,
        other.warningBackground,
        t,
      )!,
      error: Color.lerp(error, other.error, t)!,
      onError: Color.lerp(onError, other.onError, t)!,
      errorBackground: Color.lerp(errorBackground, other.errorBackground, t)!,
      info: Color.lerp(info, other.info, t)!,
      onInfo: Color.lerp(onInfo, other.onInfo, t)!,
      infoBackground: Color.lerp(infoBackground, other.infoBackground, t)!,
    );
  }
}
