import 'package:unfold_dash/src/shared/theme/colors/colorscheme.dart';
import '../typography.dart';
import 'package:flutter/material.dart';

class ParagraphTextStyle extends ThemeExtension<ParagraphTextStyle> {
  final TextStyle p0, p1, p2, p3, p4;

  ParagraphTextStyle._({
    required this.p0,
    required this.p1,
    required this.p2,
    required this.p3,
    required this.p4,
  });

  ParagraphTextStyle.lightMode()
    : this._(
        p0: TextStyle(
          fontSize: 20,
          fontFamily: AppTypography.epunda,
          package: AppTypography.packageName,
          height: 1.38,
          leadingDistribution: TextLeadingDistribution.even,
          color: AppColorScheme.light().textPrimary,
        ),
        p1: TextStyle(
          fontSize: 17,
          fontFamily: AppTypography.epunda,
          package: AppTypography.packageName,
          height: 1.38,
          leadingDistribution: TextLeadingDistribution.even,
          color: AppColorScheme.light().textPrimary,
        ),
        p2: TextStyle(
          fontSize: 15,
          fontFamily: AppTypography.epunda,
          package: AppTypography.packageName,
          height: 1.38,
          leadingDistribution: TextLeadingDistribution.even,
          color: AppColorScheme.light().textPrimary,
        ),
        p3: TextStyle(
          fontSize: 13,
          fontFamily: AppTypography.epunda,
          package: AppTypography.packageName,
          height: 1.38,
          color: AppColorScheme.light().textPrimary,
          leadingDistribution: TextLeadingDistribution.even,
        ),

        p4: TextStyle(
          fontSize: 13,
          fontFamily: AppTypography.epunda,
          package: AppTypography.packageName,
          height: 1.38,
          leadingDistribution: TextLeadingDistribution.even,
          color: AppColorScheme.light().textPrimary,
        ),
      );

  ParagraphTextStyle.darkMode()
    : this._(
        p0: TextStyle(
          fontSize: 20,
          fontFamily: AppTypography.epunda,
          package: AppTypography.packageName,
          height: 1.38,
          leadingDistribution: TextLeadingDistribution.even,
          color: AppColorScheme.dark().textPrimary,
        ),
        p1: TextStyle(
          fontSize: 17,
          fontFamily: AppTypography.epunda,
          package: AppTypography.packageName,
          height: 1.38,
          leadingDistribution: TextLeadingDistribution.even,
          color: AppColorScheme.dark().textPrimary,
        ),
        p2: TextStyle(
          fontSize: 15,
          fontFamily: AppTypography.epunda,
          package: AppTypography.packageName,
          height: 1.38,
          leadingDistribution: TextLeadingDistribution.even,
          color: AppColorScheme.dark().textPrimary,
        ),
        p3: TextStyle(
          fontSize: 13,
          fontFamily: AppTypography.epunda,
          package: AppTypography.packageName,
          height: 1.38,
          leadingDistribution: TextLeadingDistribution.even,
          color: AppColorScheme.dark().textPrimary,
        ),
        p4: TextStyle(
          fontSize: 13,
          fontFamily: AppTypography.epunda,
          package: AppTypography.packageName,
          height: 1.38,
          leadingDistribution: TextLeadingDistribution.even,
          color: AppColorScheme.dark().textPrimary,
        ),
      );

  @override
  ParagraphTextStyle copyWith({
    TextStyle? p0,
    TextStyle? p1,
    TextStyle? p2,
    TextStyle? p3,
    TextStyle? p4,
  }) {
    return ParagraphTextStyle._(
      p0: p0 ?? this.p0,
      p1: p1 ?? this.p1,
      p2: p2 ?? this.p2,
      p3: p3 ?? this.p3,
      p4: p4 ?? this.p4,
    );
  }

  @override
  ParagraphTextStyle lerp(
    covariant ThemeExtension<ParagraphTextStyle>? other,
    double t,
  ) {
    if (other is! ParagraphTextStyle) return this;

    return ParagraphTextStyle._(
      p0: TextStyle.lerp(p0, other.p1, t)!,
      p1: TextStyle.lerp(p1, other.p1, t)!,
      p2: TextStyle.lerp(p2, other.p2, t)!,
      p3: TextStyle.lerp(p3, other.p3, t)!,
      p4: TextStyle.lerp(p4, other.p4, t)!,
    );
  }
}
