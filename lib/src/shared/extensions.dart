import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

extension TimeX on DateTime {
  String get toFormattedDate {
    return '${day.toString().padLeft(2, '0')}/${month.toString().padLeft(2, '0')}';
  }

  String get toFullDate {
    return '${day.toString().padLeft(2, '0')}/${month.toString().padLeft(2, '0')}/$year';
  }
}

extension Space on num {
  DateTime get dateFrimMilliseconds =>
      DateTime.fromMillisecondsSinceEpoch(int.parse(toString()));
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

extension MinMaxExt on List<FlSpot> {
  ({double min, double max}) get minimumAndMaximum {
    if (isEmpty) {
      return (min: 0.0, max: 0.0);
    }
    final min = reduce(
      (value, element) => value.y < element.y ? value : element,
    );
    final max = reduce(
      (value, element) => value.y > element.y ? value : element,
    );

    return (min: min.y, max: max.y);
  }
}
