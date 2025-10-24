enum TimeRange {
  d7('7D', 7),
  d30('30D', 30),
  d90('90D', 90);

  final String json;
  final int days;
  const TimeRange(this.json, this.days);
}
