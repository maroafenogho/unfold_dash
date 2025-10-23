import 'package:flutter/material.dart';

class AppColorScheme extends ThemeExtension<AppColorScheme> {
  final Color primary;
  final Color secondary;
  final Color success;
  final Color background;
  final Color surface;
  final Color textPrimary;
  final Color textSecondary;
  final Color error;

  AppColorScheme({
    required this.primary,
    required this.secondary,
    required this.success,
    required this.background,
    required this.surface,
    required this.textPrimary,
    required this.textSecondary,
    required this.error,
  });

  AppColorScheme.dark()
    : this(
        secondary: const Color(0xff4a90e2),
        success: const Color(0xff359834),
        background: const Color(0xff12161f),
        surface: const Color(0xff212738),
        textPrimary: const Color(0xfff1f5f9),
        textSecondary: const Color(0xff94a3b8),
        error: const Color(0xfff87171),
        primary: const Color(0xff2ab3a3),
      );

  AppColorScheme.light()
    : this(
        secondary: const Color(0xff4a90e2),
        success: const Color(0xff355834),
        surface: const Color(0xffdbe6de),
        background: const Color(0xfff1f5f2),
        textPrimary: const Color(0xff1f2937),
        textSecondary: const Color(0xff6b7280),
        error: const Color(0xffe63946),
        primary: const Color(0xff14281d),
      );

  @override
  ThemeExtension<AppColorScheme> copyWith({
    Color? primary,
    Color? secondary,
    Color? success,
    Color? background,
    Color? surface,
    Color? textPrimary,
    Color? textSecondary,
    Color? error,
  }) => AppColorScheme(
    primary: primary ?? this.primary,
    secondary: secondary ?? this.secondary,
    success: success ?? this.success,
    background: background ?? this.background,
    surface: surface ?? this.surface,
    textPrimary: textPrimary ?? this.textPrimary,
    textSecondary: textSecondary ?? this.textSecondary,
    error: error ?? this.error,
  );

  @override
  AppColorScheme lerp(
    covariant ThemeExtension<AppColorScheme>? other,
    double t,
  ) {
    if (other is! AppColorScheme) {
      return this;
    }
    return AppColorScheme(
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      success: Color.lerp(success, other.success, t)!,
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      error: Color.lerp(error, other.error, t)!,
    );
  }
}
