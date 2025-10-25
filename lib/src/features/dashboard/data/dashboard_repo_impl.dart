import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:unfold_dash/src/features/dashboard/data/dashboard_repository.dart';
import 'package:unfold_dash/src/features/dashboard/domain/dtos/response/biometrics_point.dart';
import 'package:unfold_dash/src/features/dashboard/domain/dtos/response/journal_dto.dart';
import 'package:unfold_dash/src/shared/exceptions/exceptions.dart';
import 'package:unfold_dash/src/shared/typedefs.dart';
import 'package:unfold_dash/src/shared/utility/utility.dart';

class DashboardRepoImpl implements DashboardRepository {
  final Random _random = Random();

  @override
  Future<EitherExceptionOr<List<BiometricsPoint>>> getBiometricPoints() async {
    final bioJson = await _loadBundleString('biometrics_90d');
    return await processData(
      (json) => switch (json['list']) {
        final List list? =>
          list.map((e) => BiometricsPoint.fromJson(e as Json)).toList(),
        _ => const [],
      },
      bioJson,
    );
  }

  @override
  Future<EitherExceptionOr<List<JournalDto>>> getJournals() async {
    final journalsJson = await _loadBundleString('journals');
    return await processData(
      (json) => switch (json['list']) {
        final List list? =>
          list.map((e) => JournalDto.fromJson(e as Json)).toList(),
        _ => const [],
      },
      journalsJson,
    );
  }

  @override
  Future<EitherExceptionOr<List<BiometricsPoint>>> generateLargeBioData(
    int points,
  ) async {
    await Future.delayed(Duration(milliseconds: 700 + Random().nextInt(500)));

    final List<BiometricsPoint> data = [];
    final now = DateTime.now();
    for (int i = points - 1; i >= 0; i--) {
      final date = now.subtract(Duration(hours: i * 6));
      final seed = date.millisecondsSinceEpoch / 1000000;
      data.add(
        BiometricsPoint(
          date: Option.fromNullable(date),
          hrv: (58 + sin(seed) * 5 + _random.nextDouble() * 2)
              .clamp(45, 70)
              .toDouble(),
          rhr: (60 + cos(seed) * 4 + _random.nextInt(3)).clamp(55, 68).toInt(),
          steps: (7500 + sin(seed * 2) * 2000 + _random.nextInt(1500))
              .clamp(3000, 12000)
              .toInt(),
          sleepScore: _generateSleepScore(i),
        ),
      );
    }
    return Right(data);
  }

  @override
  EitherExceptionOr<List<BiometricsPoint>> decimateData(
    List<BiometricsPoint> data,
    int targetSize,
  ) {
    if (data.length <= targetSize || targetSize < 5) {
      return Right(data);
    }
    final hrvIndices = _getLttbIndices<BiometricsPoint>(
      data,
      targetSize,
      (p) => p.hrv.toDouble(),
    );

    final rhrIndices = _getLttbIndices<BiometricsPoint>(
      data,
      targetSize,
      (p) => p.rhr.toDouble(),
    );

    final stepsIndices = _getLttbIndices<BiometricsPoint>(
      data,
      targetSize,
      (p) => p.steps.toDouble(),
    );
    final mergedIndices = {...hrvIndices, ...rhrIndices, ...stepsIndices};

    final sortedIndices = mergedIndices.toList()..sort();

    List<BiometricsPoint> decimatedList = sortedIndices
        .map((index) => data[index])
        .toList();

    return Right(decimatedList);
  }
}

Future<EitherExceptionOr<dynamic>> _loadBundleString(String assetName) async {
  await Future.delayed(Duration(milliseconds: 700 + Random().nextInt(500)));

  if (Random().nextDouble() < 0.10) {
    return Left(GroundException("Network simulation failure. Try again."));
  }
  try {
    final data = jsonDecode(
      await rootBundle.loadString('assets/$assetName.json'),
    );
    return Right(data);
  } catch (e) {
    return Left(GroundException(e.toString()));
  }
}

double _generateSleepScore(dayIndex) {
  final cycle = sin(dayIndex / 7) * 5;
  final randomness = (Random().nextDouble() - 0.5) * 16;

  double score = 85 + cycle + randomness;

  score = min(100, max(50, score));

  return (score * 10).round() / 10;
}

class Point {
  final double x;
  final double y;
  final int originalIndex;

  Point(this.x, this.y, this.originalIndex);
}

List<int> _getLttbIndices<T>(
  List<T> data,
  int targetSize,
  double Function(T) getValue,
) {
  int N = data.length;
  if (N <= targetSize || targetSize <= 2) {
    return List<int>.generate(N, (i) => i);
  }

  List<Point> points = [];
  for (int i = 0; i < N; i++) {
    points.add(Point(i.toDouble(), getValue(data[i]), i));
  }

  List<int> resultIndices = [points[0].originalIndex]; // Keep first index
  double every = (N - 2).toDouble() / (targetSize - 2).toDouble();

  Point previousPoint = points[0];
  int a = 0; // Index of the last selected point in the 'points' list

  for (int i = 0; i < targetSize - 2; i++) {
    int bucketStart = a + 1;
    int bucketEnd = ((i + 1) * every).toInt() + 1;
    if (bucketEnd >= N) bucketEnd = N;

    // Calculate average of the current bucket (averagePoint)
    double avgX = 0;
    double avgY = 0;
    int bucketCount = bucketEnd - bucketStart;

    for (int j = bucketStart; j < bucketEnd; j++) {
      avgX += points[j].x;
      avgY += points[j].y;
    }
    Point averagePoint = Point(
      avgX / bucketCount,
      avgY / bucketCount,
      -1,
    ); // Index not needed

    // Find the best point in the current bucket
    double maxArea = -1;
    int maxAreaIndex = bucketStart;

    for (int j = bucketStart; j < bucketEnd; j++) {
      Point currentPoint = points[j];

      // Triangle Area Calculation
      double area =
          0.5 *
          ((previousPoint.x - currentPoint.x) *
                      (averagePoint.y - currentPoint.y) -
                  (previousPoint.y - currentPoint.y) *
                      (averagePoint.x - currentPoint.x))
              .abs();

      if (area > maxArea) {
        maxArea = area;
        maxAreaIndex = j;
      }
    }
    // Select the max area point and update previousPoint
    previousPoint = points[maxAreaIndex];
    a = maxAreaIndex;
    resultIndices.add(points[maxAreaIndex].originalIndex);
  }

  resultIndices.add(points[N - 1].originalIndex); // Keep last index
  return resultIndices;
}
