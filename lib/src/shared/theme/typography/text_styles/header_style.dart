import 'package:flutter/material.dart';
import 'package:unfold_dash/src/shared/theme/colors/colorscheme.dart';
import '../typography.dart';

class HeaderTextStyle extends ThemeExtension<HeaderTextStyle> {
  final TextStyle h1, h2, h3, h4;

  HeaderTextStyle._({
    required this.h1,
    required this.h2,
    required this.h3,
    required this.h4,
  });

  HeaderTextStyle.lightMode()
    : this._(
        h1: TextStyle(
          fontSize: 56,
          fontFamily: AppTypography.epunda,
          color: AppColorScheme.light().textPrimary,
          package: AppTypography.packageName,
          height: 1.38,
          leadingDistribution: TextLeadingDistribution.even,
        ),
        h2: TextStyle(
          fontSize: 48,
          fontFamily: AppTypography.epunda,
          package: AppTypography.packageName,
          color: AppColorScheme.light().textPrimary,
          height: 1.38,
          leadingDistribution: TextLeadingDistribution.even,
        ),
        h3: TextStyle(
          fontSize: 40,
          fontFamily: AppTypography.epunda,
          package: AppTypography.packageName,
          color: AppColorScheme.light().textPrimary,
          height: 1.38,
          leadingDistribution: TextLeadingDistribution.even,
        ),
        h4: TextStyle(
          fontSize: 32,
          fontFamily: AppTypography.epunda,
          color: AppColorScheme.light().textPrimary,
          package: AppTypography.packageName,
          height: 1.38,
          leadingDistribution: TextLeadingDistribution.even,
        ),
      );

  HeaderTextStyle.darkMode()
    : this._(
        h1: TextStyle(
          fontSize: 56,
          fontFamily: AppTypography.epunda,
          package: AppTypography.packageName,
          height: 1.38,
          color: AppColorScheme.dark().textPrimary,
          leadingDistribution: TextLeadingDistribution.even,
        ),
        h2: TextStyle(
          fontSize: 48,
          fontFamily: AppTypography.epunda,
          color: AppColorScheme.dark().textPrimary,
          package: AppTypography.packageName,
          height: 1.38,
          leadingDistribution: TextLeadingDistribution.even,
        ),
        h3: TextStyle(
          fontSize: 40,
          fontFamily: AppTypography.epunda,
          package: AppTypography.packageName,
          color: AppColorScheme.dark().textPrimary,
          height: 1.38,
          leadingDistribution: TextLeadingDistribution.even,
        ),
        h4: TextStyle(
          fontSize: 32,
          fontFamily: AppTypography.epunda,
          package: AppTypography.packageName,
          height: 1.38,
          color: AppColorScheme.dark().textPrimary,
          leadingDistribution: TextLeadingDistribution.even,
        ),
      );

  @override
  HeaderTextStyle copyWith({
    TextStyle? h1,
    TextStyle? h2,
    TextStyle? h3,
    TextStyle? h4,
  }) {
    return HeaderTextStyle._(
      h1: h1 ?? this.h1,
      h2: h2 ?? this.h2,
      h3: h3 ?? this.h3,
      h4: h4 ?? this.h4,
    );
  }

  @override
  HeaderTextStyle lerp(
    covariant ThemeExtension<HeaderTextStyle>? other,
    double t,
  ) {
    if (other is! HeaderTextStyle) return this;

    return HeaderTextStyle._(
      h1: TextStyle.lerp(h1, other.h2, t)!,
      h2: TextStyle.lerp(h2, other.h2, t)!,
      h3: TextStyle.lerp(h3, other.h3, t)!,
      h4: TextStyle.lerp(h4, other.h4, t)!,
    );
  }
}
