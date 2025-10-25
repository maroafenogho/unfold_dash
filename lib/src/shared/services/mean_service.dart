import 'dart:math';
import 'package:fl_chart/fl_chart.dart';

class MeanService {
  static List<double?> rollingMean(List<double?> data, int window) {
    if (window <= 1 || data.isEmpty) return data;
    final result = List<double?>.filled(data.length, null);
    double sum = 0;
    int count = 0;

    for (int i = 0; i < data.length; i++) {
      final value = data[i];
      if (value != null) {
        sum += value;
        count++;
      }

      if (i >= window) {
        final oldValue = data[i - window];
        if (oldValue != null) {
          sum -= oldValue;
          count--;
        }
      }

      if (i >= window - 1 && count > 0) {
        result[i] = sum / count;
      }
    }
    return result;
  }

  static List<double?> rollingStdDev(List<double?> data, int window) {
    if (window <= 1 || data.isEmpty) {
      return List<double?>.filled(data.length, null);
    }
    final result = List<double?>.filled(data.length, null);
    final queue = <double>[];

    for (int i = 0; i < data.length; i++) {
      final value = data[i];
      if (value != null) queue.add(value);
      if (queue.length > window) queue.removeAt(0);

      if (queue.length == window) {
        final mean = queue.reduce((a, b) => a + b) / window;
        final variance =
            queue.map((v) => pow(v - mean, 2)).reduce((a, b) => a + b) / window;
        result[i] = sqrt(variance);
      }
    }
    return result;
  }

  /// Generate upper/lower band data (mean ± 1σ) for HRV visualization.

  static BandData generateHrvBands(List<double?> hrvValues) {
    const int window = 7;

    final means = rollingMean(hrvValues, window);
    final stdDevs = rollingStdDev(hrvValues, window);

    final meanSpots = <FlSpot>[];
    final upperSpots = <FlSpot>[];
    final lowerSpots = <FlSpot>[];

    for (int i = 0; i < hrvValues.length; i++) {
      final m = means[i];
      final s = stdDevs[i];
      if (m != null && s != null) {
        meanSpots.add(FlSpot(i.toDouble(), m));
        upperSpots.add(FlSpot(i.toDouble(), m + s));
        lowerSpots.add(FlSpot(i.toDouble(), m - s));
      }
    }

    return BandData(mean: meanSpots, upper: upperSpots, lower: lowerSpots);
  }
}

class BandData {
  final List<FlSpot> mean;
  final List<FlSpot> upper;
  final List<FlSpot> lower;

  BandData({required this.mean, required this.upper, required this.lower});
}
