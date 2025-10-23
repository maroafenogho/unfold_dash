import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:unfold_dash/src/features/dashboard/application/dashboard_notifier.dart';
import 'package:unfold_dash/src/features/dashboard/presentation/widgets/theme_switcher.dart';
import 'package:unfold_dash/src/shared/shared.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
      dashNotifier.getBioData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.background,
      appBar: AppBar(
        backgroundColor: context.colorScheme.surface,
        title: Text(widget.title, style: context.typography.paragraph.p1),
        actionsPadding: AppConstants.mediumSpace.hEdgeInsets,
        actions: [const ThemeModeSwitcher()],
      ),
      body: Padding(
        padding: AppConstants.mediumSpaceM.allEdgeInsets,
        child: ListenableBuilder(
          listenable: dashNotifier,
          builder: (context, child) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                switch (dashNotifier.state.biometricsUiState) {
                  LoadingState(data: final data) => Column(
                    children: [
                      if (data != null)
                        Text(
                          '${data.first.sleepScore}',
                          style: context.typography.paragraph.p3,
                        ),
                      ChartLoader(
                        colors: [
                          context.colorScheme.surface,
                          context.colorScheme.textSecondary,
                          context.colorScheme.textPrimary,
                        ],
                      ),
                    ],
                  ),
                  SuccessState(result: final data) => Column(
                    children: [
                      SizedBox(
                        height: 200,
                        child: LineChart(
                          LineChartData(
                            borderData: FlBorderData(show: false),
                            gridData: FlGridData(show: false),
                            titlesData: FlTitlesData(show: false),
                            clipData: FlClipData.horizontal(),
                            minX: data.first.date.fold(
                              () => 0,
                              (value) =>
                                  value.millisecondsSinceEpoch.toDouble(),
                            ),
                            lineTouchData: LineTouchData(
                              touchTooltipData: LineTouchTooltipData(
                                maxContentWidth: 200,
                                fitInsideVertically: true,
                                fitInsideHorizontally: true,
                                showOnTopOfTheChartBoxArea: true,
                                getTooltipItems: (touchedSpots) {
                                  return touchedSpots
                                      .map(
                                        (e) => LineTooltipItem(
                                          e
                                              .x
                                              .dateFrimMilliseconds
                                              .toFormattedDate,
                                          context.typography.paragraph.p4,
                                          children: [
                                            TextSpan(text: '\nHRV: ${e.y}'),
                                          ],
                                        ),
                                      )
                                      .toList();
                                },
                              ),
                            ),
                            lineBarsData: [
                              LineChartBarData(
                                preventCurveOverShooting: true,

                                spots: data
                                    .map(
                                      (e) => FlSpot(
                                        e.date.fold(
                                          () => 0,
                                          (value) => value
                                              .millisecondsSinceEpoch
                                              .toDouble(),
                                        ),
                                        e.hrv.toDouble(),
                                      ),
                                    )
                                    .toList(),
                              ),
                              LineChartBarData(
                                preventCurveOverShooting: true,

                                spots: data
                                    .map(
                                      (e) => FlSpot(
                                        e.date.fold(
                                          () => 0,
                                          (value) => value
                                              .millisecondsSinceEpoch
                                              .toDouble(),
                                        ),
                                        e.rhr.toDouble(),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        '${data.first.sleepScore}',
                        style: context.typography.paragraph.p3.bold,
                      ),
                    ],
                  ),
                  _ => Text(
                    'Could not fetch data.\n Please try again',
                    style: context.typography.paragraph.p3,
                  ),
                },
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ChartLoader extends StatelessWidget {
  const ChartLoader({super.key, required this.colors});
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: context.colorScheme.textPrimary),
          bottom: BorderSide(color: context.colorScheme.textPrimary),
        ),
      ),
      padding: AppConstants.mediumSpace.allEdgeInsets,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppConstants.smallSpace,
        children: [
          AppShimmer(
            width: 100,
            height: AppConstants.smallSpace,
            colors: colors,
          ),
          AppShimmer(
            width: 150,
            height: AppConstants.smallSpace,
            colors: colors,
          ),
          AppShimmer(
            width: 200,
            height: AppConstants.smallSpace,
            colors: colors,
          ),
          AppShimmer(
            width: 150,
            height: AppConstants.smallSpace,
            colors: colors,
          ),
        ],
      ),
    );
  }
}
