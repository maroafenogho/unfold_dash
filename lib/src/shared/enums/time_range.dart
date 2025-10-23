enum TimeRange {
  d7('7D'),
  d30('30D'),
  d90('90D');

  final String json;

  const TimeRange(this.json);
}
