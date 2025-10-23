import 'package:flutter/material.dart';
import 'package:unfold_dash/src/features/dashboard/presentation/screens/dashboard.dart';
import 'package:unfold_dash/src/shared/shared.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: appThemeModeNotifier,
      builder: (context, child) => MaterialApp(
        title: 'Unfold Health',
        debugShowCheckedModeBanner: false,
        themeMode: appThemeModeNotifier.themeMode,
        darkTheme: ThemeData(extensions: [AppThemeData.darkMode()]),
        theme: ThemeData(extensions: [AppThemeData.lightMode()]),
        home: const MyHomePage(title: 'Unfold Health Dashboard'),
      ),
    );
  }
}
