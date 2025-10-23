import 'package:flutter/material.dart';

import 'text_styles/text_style.dart';

class AppTypography extends ThemeExtension<AppTypography> {
  static const epunda = 'EpundaSans';
  static const packageName = 'cwm_mason';

  final ParagraphTextStyle paragraph;
  final TitleTextStyle title;
  final HeaderTextStyle header;
  final BodyTextStyle body;

  const AppTypography._({
    required this.paragraph,
    required this.title,
    required this.header,
    required this.body,
  });

  AppTypography.lightMode()
    : this._(
        paragraph: ParagraphTextStyle.lightMode(),
        title: TitleTextStyle.lightMode(),
        header: HeaderTextStyle.lightMode(),
        body: BodyTextStyle.lightMode(),
      );

  AppTypography.darkMode()
    : this._(
        title: TitleTextStyle.darkMode(),
        paragraph: ParagraphTextStyle.darkMode(),
        header: HeaderTextStyle.darkMode(),
        body: BodyTextStyle.darkMode(),
      );

  @override
  AppTypography copyWith({
    ParagraphTextStyle? paragraph,
    TitleTextStyle? title,
    HeaderTextStyle? header,
    BodyTextStyle? body,
  }) {
    return AppTypography._(
      paragraph: paragraph ?? this.paragraph,
      title: title ?? this.title,
      header: header ?? this.header,
      body: body ?? this.body,
    );
  }

  @override
  AppTypography lerp(covariant ThemeExtension<AppTypography>? other, double t) {
    if (other is! AppTypography) {
      return this;
    }

    return AppTypography._(
      paragraph: paragraph.lerp(other.paragraph, t),
      title: title.lerp(other.title, t),
      header: header.lerp(other.header, t),
      body: body.lerp(other.body, t),
    );
  }
}

extension TypographyX on TextStyle {
  /// fontweight: 400
  TextStyle get light => copyWith(fontWeight: FontWeight.w300);
  TextStyle get regular => copyWith(fontWeight: FontWeight.w400);

  /// fontweight: 500
  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);

  /// fontweight: 600
  TextStyle get semi => copyWith(fontWeight: FontWeight.w600);

  /// fontweight: 700
  TextStyle get bold => copyWith(fontWeight: FontWeight.w700);

  /// fontweight: 800
  TextStyle get extraBold => copyWith(fontWeight: FontWeight.w800);

  /// underlined text
  TextStyle get underlined => copyWith(decoration: TextDecoration.underline);
}
