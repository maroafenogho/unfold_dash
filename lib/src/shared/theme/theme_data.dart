
import 'package:flutter/material.dart';
import 'package:unfold_dash/src/shared/theme/colors/colorscheme.dart';
import 'package:unfold_dash/src/shared/theme/typography/typography.dart';

class AppThemeData extends ThemeExtension<AppThemeData> {
  final AppColorScheme colorScheme;
  final AppTypography typography;

  AppThemeData._({required this.colorScheme, required this.typography});
  AppThemeData({AppTypography? typography, AppColorScheme? colorScheme})
    : this._(
        typography: typography ?? AppTypography.lightMode(),
        colorScheme: colorScheme ?? AppColorScheme.light(),
      );

  static AppThemeData of(BuildContext context) =>
      Theme.of(context).extension<AppThemeData>()!;

  AppThemeData.lightMode()
    : this._(
        colorScheme: AppColorScheme.light(),
        typography: AppTypography.lightMode(),
      );

  AppThemeData.darkMode()
    : this._(
        colorScheme: AppColorScheme.dark(),
        typography: AppTypography.darkMode(),
      );

  @override
  ThemeExtension<AppThemeData> copyWith({
    AppColorScheme? colorScheme,
    AppTypography? typography,
  }) {
    return AppThemeData._(
      colorScheme: colorScheme ?? this.colorScheme,
      typography: typography ?? this.typography,
    );
  }

  @override
  ThemeExtension<AppThemeData> lerp(
    covariant ThemeExtension<AppThemeData>? other,
    double t,
  ) {
    if (other is! AppThemeData) {
      return this;
    }
    return AppThemeData._(
      colorScheme: colorScheme.lerp(other.colorScheme, t),
      typography: typography.lerp(other.typography, t),
    );
  }
}

extension ThemeDataGetter on BuildContext {
  AppTypography get typography => AppThemeData.of(this).typography;
  AppColorScheme get colorScheme => AppThemeData.of(this).colorScheme;
}
