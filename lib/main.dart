import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unfold_dash/src/features/dashboard/application/dashboard_notifier.dart';
import 'package:unfold_dash/src/shared/shared.dart';
import 'package:unfold_dash/src/shared/theme/theme_data.dart';
import 'package:unfold_dash/src/shared/theme/theme_mode.dart';
import 'package:unfold_dash/src/shared/view_model/base_ui_state.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefsService.initialise();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: appThemeModeNotifier,
      builder:(context, child) =>  MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        themeMode: appThemeModeNotifier.themeMode,
        darkTheme:ThemeData(extensions: [AppThemeData.darkMode()]),
        theme: ThemeData(
         extensions: [AppThemeData.lightMode()]),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.background,
      appBar: AppBar(
        backgroundColor: context.colorScheme.surface,
        title: Text(widget.title, style: context.typography.paragraph.p1,),
        actions: [
          Switch(
            activeTrackColor: context.colorScheme.secondary,
            thumbColor: WidgetStateColor.resolveWith((states) => context.colorScheme.textPrimary),
            
            value: appThemeModeNotifier.isDark, onChanged: (value){
              if(value){
                appThemeModeNotifier.setThemeMode(AppThemeModeEnum.dark);
                return;
              }
                appThemeModeNotifier.setThemeMode(AppThemeModeEnum.light);

          })
        ],
      ),
      body: Consumer(
        builder: (context, ref, child) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                switch (ref
                    .watch(dashboardNotifierProvider)
                    .biometricsUiState) {
                  LoadingState(data: final data) => Column(
                    children: [
                      if (data != null) Text('${data.first.sleepScore}'),
                      CircularProgressIndicator(),
                    ],
                  ),
                  SuccessState(result: final data) => Text(
                    '${data.first.sleepScore}',
                  ),
                  _ => Text('Could not fetch data.\n Please try again', style: context.typography.paragraph.p3,),
                },
               
              ],
            ),
          );
        },
      ),
    );
  }
}
