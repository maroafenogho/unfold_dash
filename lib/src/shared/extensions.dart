import 'package:flutter/material.dart';

extension Space on num {
  SizedBox get vSpace => SizedBox(height: toDouble());

  SizedBox get hSpace => SizedBox(width: toDouble());

  EdgeInsets get hEdgeInsets => EdgeInsets.symmetric(horizontal: toDouble());
  EdgeInsets get leftEdgeInsets => EdgeInsets.only(left: toDouble());
  EdgeInsets get rightEdgeInsets => EdgeInsets.only(right: toDouble());

  EdgeInsets get vEdgeInsets => EdgeInsets.symmetric(vertical: toDouble());

  EdgeInsets get allEdgeInsets => EdgeInsets.all(toDouble());

  static const minimumUnlimited = 99999999;

  bool get isUnlimited => this >= minimumUnlimited;

  num get zeroOrMore {
    return clamp(0, double.infinity);
  }

  String get parsedDayString {
    if (this == 1) {
      return '$this day';
    }
    return '$this days';
  }

  num get truncatedNumber {
    final number = (this * 100).truncate() / 100;
    if (number.isNaN) {
      return 0;
    }
    return number;
  }
}
