import 'package:flutter/material.dart';
import 'package:unfold_dash/src/shared/shared.dart';

class ThemeModeSwitcher extends StatelessWidget {
  const ThemeModeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Change theme mode',
      child: SizedBox(
        height: AppConstants.bigSpace,
        // width: AppConstants.bigSpaceM.aw,
        child: FittedBox(
          child: Switch(
            // activeTrackColor: context.colorScheme.secondary,
            trackColor: WidgetStateColor.resolveWith(
              (states) => context.colorScheme.textSecondary,
            ),
            thumbColor: WidgetStateColor.resolveWith(
              (states) => context.colorScheme.textPrimary,
            ),
            thumbIcon: WidgetStateProperty.resolveWith<Icon?>((
              Set<WidgetState> states,
            ) {
              if (states.contains(WidgetState.selected)) {
                return Icon(
                  Icons.light_mode,
                  color: context.colorScheme.surface,
                );
              } else {
                return Icon(
                  Icons.dark_mode,
                  color: context.colorScheme.surface,
                );
              }
            }),
            value: appThemeModeNotifier.isDark,
            onChanged: (value) {
              if (value) {
                appThemeModeNotifier.setThemeMode(AppThemeModeEnum.dark);
                return;
              }
              appThemeModeNotifier.setThemeMode(AppThemeModeEnum.light);
            },
          ),
        ),
      ),
    );
  }
}
