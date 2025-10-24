import 'package:flutter/material.dart';
import 'package:unfold_dash/src/shared/theme/colors/colorscheme.dart';

import '../typography.dart';

class TitleTextStyle extends ThemeExtension<TitleTextStyle> {
  final TextStyle t1, t2, t3, t4;

  TitleTextStyle._({
    required this.t1,
    required this.t2,
    required this.t3,
    required this.t4,
  });

  TitleTextStyle.lightMode()
    : this._(
        t1: TextStyle(
          fontSize: 24,
          fontFamily: AppTypography.epunda,
          package: AppTypography.packageName,
          height: 1.38,
          color: AppColorScheme.light().textPrimary,
          leadingDistribution: TextLeadingDistribution.even,
        ),
        t2: TextStyle(
          fontSize: 22,
          fontFamily: AppTypography.epunda,
          package: AppTypography.packageName,
          color: AppColorScheme.light().textPrimary,
          height: 1.38,
          leadingDistribution: TextLeadingDistribution.even,
        ),
        t3: TextStyle(
          fontSize: 20,
          fontFamily: AppTypography.epunda,
          package: AppTypography.packageName,
          color: AppColorScheme.light().textPrimary,
          height: 1.38,
          leadingDistribution: TextLeadingDistribution.even,
        ),
        t4: TextStyle(
          fontSize: 18,
          fontFamily: AppTypography.epunda,
          color: AppColorScheme.light().textPrimary,
          package: AppTypography.packageName,
          height: 1.38,
          leadingDistribution: TextLeadingDistribution.even,
        ),
      );

  TitleTextStyle.darkMode()
    : this._(
        t1: TextStyle(
          fontSize: 24,
          fontFamily: AppTypography.epunda,
          package: AppTypography.packageName,
          color: AppColorScheme.dark().textPrimary,
          height: 1.38,
          leadingDistribution: TextLeadingDistribution.even,
        ),
        t2: TextStyle(
          fontSize: 22,
          color: AppColorScheme.dark().textPrimary,
          fontFamily: AppTypography.epunda,
          package: AppTypography.packageName,
          height: 1.38,
          leadingDistribution: TextLeadingDistribution.even,
        ),
        t3: TextStyle(
          fontSize: 20,
          color: AppColorScheme.dark().textPrimary,
          fontFamily: AppTypography.epunda,
          package: AppTypography.packageName,
          height: 1.38,
          leadingDistribution: TextLeadingDistribution.even,
        ),
        t4: TextStyle(
          fontSize: 18,
          color: AppColorScheme.dark().textPrimary,
          fontFamily: AppTypography.epunda,
          package: AppTypography.packageName,
          height: 1.38,
          leadingDistribution: TextLeadingDistribution.even,
        ),
      );

  @override
  TitleTextStyle copyWith({
    TextStyle? t1,
    TextStyle? t2,
    TextStyle? t3,
    TextStyle? t4,
  }) {
    return TitleTextStyle._(
      t1: t1 ?? this.t1,
      t2: t2 ?? this.t2,
      t3: t3 ?? this.t3,
      t4: t4 ?? this.t4,
    );
  }

  @override
  TitleTextStyle lerp(
    covariant ThemeExtension<TitleTextStyle>? other,
    double t,
  ) {
    if (other is! TitleTextStyle) return this;

    return TitleTextStyle._(
      t1: TextStyle.lerp(t1, other.t2, t)!,
      t2: TextStyle.lerp(t2, other.t2, t)!,
      t3: TextStyle.lerp(t3, other.t3, t)!,
      t4: TextStyle.lerp(t4, other.t4, t)!,
    );
  }
}
