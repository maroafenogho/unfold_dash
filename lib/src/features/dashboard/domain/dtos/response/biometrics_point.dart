import 'package:unfold_dash/src/shared/typedefs.dart' show Json;

class BiometricsPoint {
  final num hrv;
  final num rhr;
  final int steps;
  final num sleepScore;
  final String date;

  BiometricsPoint({
    required this.hrv,
    required this.rhr,
    required this.steps,
    required this.sleepScore,
    required this.date,
  });

  factory BiometricsPoint.fromJson(Json json) => BiometricsPoint(
    hrv: json['hrv'] ?? 0,
    rhr: json['rhr'] ?? 0,
    steps: json['steps'] ?? 0,
    sleepScore: json['sleepScore'] ?? 0,
    date: json['date'] ?? '',
  );
}
