import 'package:flutter/material.dart';
import 'package:unfold_dash/src/shared/theme/colors/colorscheme.dart';

import '../typography.dart';

class BodyTextStyle extends ThemeExtension<BodyTextStyle> {
  final TextStyle b1, b2, b3;

  BodyTextStyle._({required this.b1, required this.b2, required this.b3});

  BodyTextStyle.lightMode()
    : this._(
        b1: TextStyle(
          fontSize: 12,
          fontFamily: AppTypography.epunda,
          package: AppTypography.packageName,
          height: 1.38,
          leadingDistribution: TextLeadingDistribution.even,
          color: AppColorScheme.light().textPrimary,
        ),
        b2: TextStyle(
          fontSize: 10,
          fontFamily: AppTypography.epunda,
          package: AppTypography.packageName,
          height: 1.38,
          leadingDistribution: TextLeadingDistribution.even,
          color: AppColorScheme.light().textPrimary,
        ),
        b3: TextStyle(
          fontSize: 8,
          fontFamily: AppTypography.epunda,
          package: AppTypography.packageName,
          height: 1.38,
          leadingDistribution: TextLeadingDistribution.even,
          color: AppColorScheme.light().textPrimary,
        ),
      );

  BodyTextStyle.darkMode()
    : this._(
        b1: TextStyle(
          fontSize: 12,
          fontFamily: AppTypography.epunda,
          package: AppTypography.packageName,
          height: 1.38,
          leadingDistribution: TextLeadingDistribution.even,
          color: AppColorScheme.dark().textPrimary,
        ),
        b2: TextStyle(
          fontSize: 10,
          fontFamily: AppTypography.epunda,
          package: AppTypography.packageName,
          height: 1.38,
          leadingDistribution: TextLeadingDistribution.even,
          color: AppColorScheme.dark().textPrimary,
        ),
        b3: TextStyle(
          fontSize: 8,
          fontFamily: AppTypography.epunda,
          package: AppTypography.packageName,
          height: 1.38,
          leadingDistribution: TextLeadingDistribution.even,
          color: AppColorScheme.dark().textPrimary,
        ),
      );

  @override
  BodyTextStyle copyWith({TextStyle? b1, TextStyle? b2, TextStyle? b3}) {
    return BodyTextStyle._(
      b1: b1 ?? this.b1,
      b2: b2 ?? this.b2,
      b3: b3 ?? this.b3,
    );
  }

  @override
  BodyTextStyle lerp(covariant ThemeExtension<BodyTextStyle>? other, double t) {
    if (other is! BodyTextStyle) return this;

    return BodyTextStyle._(
      b1: TextStyle.lerp(b1, other.b2, t)!,
      b2: TextStyle.lerp(b2, other.b2, t)!,
      b3: TextStyle.lerp(b3, other.b3, t)!,
    );
  }
}
