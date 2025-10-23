enum AppThemeModeEnum{
  dark('dark'),
  light('light'),
  system('system');

  final String json;

  const AppThemeModeEnum(this.json);
}

extension ThemeModeX on String {
  AppThemeModeEnum get mode => AppThemeModeEnum.values.firstWhere(
    (element) => element.json == this,
    orElse: () => AppThemeModeEnum.system,
  );
}
