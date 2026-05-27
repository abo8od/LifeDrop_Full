// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  final Color primary;
  final Color secondary;
  final Color background;
  final Color navigationBar;
  final Color surface;
  final Color mode;
  final Color tertiary;
  final Color neutral;
  final Color textPrimary;
  final Color textSecondary;
  final Color textError;
  final Color textPlaceHolder;
  final Color iconInactive;
  final Color iconActive;
  final Color iconActiveBackground;

  const AppColors({
    required this.primary,
    required this.secondary,
    required this.background,
    required this.navigationBar,
    required this.surface,
    required this.mode,
    required this.tertiary,
    required this.neutral,
    required this.textPrimary,
    required this.textSecondary,
    required this.textError,
    required this.textPlaceHolder,
    required this.iconActive,
    required this.iconInactive,
    required this.iconActiveBackground,
  });

  factory AppColors.light() => const AppColors(
    primary: Color(0xFFB7102A),
    secondary: Color(0xFF2B6485),
    background: Color(0xFFF7F9FE),
    navigationBar: Color(0xFFFFFFFF),
    surface: Color(0xFFDFE3E8),
    mode: Color(0xFFFFFFFF),
    tertiary: Color(0xFFC7E7FF),
    neutral: Color(0xFFF1F4F9),
    textPrimary: Color(0xFF181C20),
    textSecondary: Color(0xFF5B403F),
    textError: Color(0xFFFFDAD6),
    textPlaceHolder: Color(0x7D8F6F6E),
    iconActive: Color(0xFFE63946),
    iconInactive: Color(0xFF64748B),
    iconActiveBackground: Color(0xFFFFDAD8),
  );
  factory AppColors.dark() => const AppColors(
    primary: Color(0xFFB7102A),
    secondary: Color(0xFF98CDF2),
    background: Color(0xFF0B0E11),
    navigationBar: Color(0xFF0F172A),
    surface: Color(0xFF33353A),
    mode: Color(0xFF0C0F12),
    tertiary: Color(0xFF064C6B),
    neutral: Color(0xFF1E293B),
    textPrimary: Color(0xFFE1E2E8),
    textSecondary: Color(0xFFD8C2C1),
    textError: Color(0xFFFFDAD6),
    textPlaceHolder: Color(0xFF94A3B8),
    iconActive: Color(0xFFFF4D4D),
    iconInactive: Color(0xFF94A3B8),
    iconActiveBackground: Color(0xFFDB313F),
  );

  @override
  AppColors copyWith({
    Color? primary,
    Color? secondary,
    Color? background,
    Color? navigationBar,
    Color? surface,
    Color? mode,
    Color? neutral,
    Color? tertiary,
    Color? textPrimary,
    Color? textSecondary,
    Color? textError,
    Color? textPlaceHolder,
    Color? iconInactive,
    Color? iconActive,
    Color? iconActiveBackground,
  }) {
    return AppColors(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      background: background ?? this.background,
      navigationBar: navigationBar ?? this.navigationBar,
      surface: surface ?? this.surface,
      mode: mode ?? this.mode,
      neutral: neutral ?? this.neutral,
      tertiary: tertiary ?? this.tertiary,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textError: textError ?? this.textError,
      textPlaceHolder: textPlaceHolder ?? this.textPlaceHolder,
      iconInactive: iconInactive ?? this.iconInactive,
      iconActive: iconActive ?? this.iconActive,
      iconActiveBackground: iconActiveBackground ?? this.iconActiveBackground,
    );
  }

  @override
  ThemeExtension<AppColors> lerp(
    covariant ThemeExtension<AppColors>? other,
    double t,
  ) {
    if (other is! AppColors) return this;

    return AppColors(
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      mode: Color.lerp(mode, other.mode, t)!,
      neutral: Color.lerp(neutral, other.neutral, t)!,
      tertiary: Color.lerp(tertiary, other.tertiary, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textError: Color.lerp(textError, other.textError, t)!,
      textPlaceHolder: Color.lerp(textPlaceHolder, other.textPlaceHolder, t)!,
      iconInactive: Color.lerp(iconInactive, other.iconInactive, t)!,
      iconActive: Color.lerp(iconActive, other.iconActive, t)!,
      iconActiveBackground: Color.lerp(
        iconActiveBackground,
        other.iconActiveBackground,
        t,
      )!,
      background: Color.lerp(background, other.background, t)!,
      navigationBar: Color.lerp(navigationBar, other.navigationBar, t)!,
    );
  }
}
