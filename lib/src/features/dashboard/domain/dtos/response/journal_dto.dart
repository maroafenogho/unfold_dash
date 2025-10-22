import 'package:unfold_dash/src/shared/shared.dart';

class JournalDto {
  final String date;
  final int mood;
  final String note;

  JournalDto({required this.date, required this.mood, required this.note});

  factory JournalDto.fromJson(Json json) => JournalDto(
    date: json['date'] ?? '',
    mood: json['mood'] ?? 0,
    note: json['note'] ?? '',
  );
}
