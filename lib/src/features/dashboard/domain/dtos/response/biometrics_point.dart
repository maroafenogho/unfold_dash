import 'package:unfold_dash/src/shared/shared.dart';

class BiometricsPoint {
  final num hrv;
  final num rhr;
  final int steps;
  final num sleepScore;
  final Option<DateTime> date;

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
    date: Option.fromNullable(DateTime.tryParse(json['date'] ?? '')),
  );

  BiometricsPoint.empty()
    : this(date: None(), rhr: 0, hrv: 0, sleepScore: 0, steps: 0);

  Json toJson() => {
    "date": date,
    "hrv": hrv,
    "rhr": rhr,
    "steps": steps,
    "sleepScore": sleepScore,
  };
}
