import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
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
                      SegmentedButton<TimeRange>(
                        showSelectedIcon: true,
                        selectedIcon: Icon(
                          Icons.check,
                          color: context.colorScheme.textPrimary,
                        ),
                        onSelectionChanged: (range) =>
                            dashNotifier.setTimeRange(range.first),
                        style: ButtonStyle(
                          backgroundColor: WidgetStateColor.resolveWith(
                            (states) => context.colorScheme.surface,
                          ),
                        ),
                        segments: TimeRange.values
                            .map(
                              (e) => ButtonSegment<TimeRange>(
                                value: e,
                                label: Text(
                                  e.json,
                                  style: context.typography.body.b1.bold,
                                ),
                              ),
                            )
                            .toList(),
                        selected: <TimeRange>{
                          dashNotifier.state.selectedTimeRange,
                        },
                      ),
                      AppConstants.mediumSpaceM.vSpace,
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height - 200,
                        width: MediaQuery.sizeOf(context).width - 100,
                        child: LineChart(
                          transformationConfig: FlTransformationConfig(
                            trackpadScrollCausesScale: true,
                            scaleAxis: FlScaleAxis.free,
                            maxScale: 3,
                          ),
                          LineChartData(
                            borderData: FlBorderData(show: false),
                            gridData: FlGridData(show: true),
                            titlesData: FlTitlesData(
                              show: true,
                              rightTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 40,
                                  getTitlesWidget: (value, meta) => Text(
                                    value.toString(),
                                    style: context.typography.body.b2,
                                  ),
                                ),
                              ),
                              topTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) => Text(
                                    value.dateFrimMilliseconds.toFormattedDate,
                                    style: context.typography.body.b3,
                                  ),
                                ),
                              ),
                            ),
                            minY:
                                data.first
                                    .toJson()
                                    .values
                                    .whereType<num>()
                                    .map((e) => e.toDouble())
                                    .toList()
                                    .reduce((a, b) => a < b ? a : b) -
                                10,
                            minX: data.first.date.fold(
                              () => 0,
                              (value) =>
                                  value.millisecondsSinceEpoch.toDouble() -
                                  10000000,
                            ),
                            maxX: data.last.date.fold(
                              () => 0,
                              (value) =>
                                  value.millisecondsSinceEpoch.toDouble() +
                                  10000000,
                            ),
                            lineTouchData: LineTouchData(
                              touchTooltipData: LineTouchTooltipData(
                                maxContentWidth: 200,
                                getTooltipColor: (touchedSpot) =>
                                    context.colorScheme.surface,
                                fitInsideVertically: true,
                                // fitInsideHorizontally: true,
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
                                            TextSpan(
                                              text:
                                                  '\n${e.barIndex == 1 ? 'RHR' : 'HRV'} : ${e.y}\n\n${e.bar.lineChartStepData}',
                                            ),
                                          ],
                                        ),
                                      )
                                      .toList();
                                },
                              ),
                            ),
                            lineBarsData: [
                              LineChartBarData(
                                barWidth: 1.5,
                                preventCurveOverShooting: true,
                                color: context.colorScheme.textSecondary,
                                isCurved: true,
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
                                    .toSet()
                                    .toList(),
                              ),
                              LineChartBarData(
                                barWidth: 1.5,
                                preventCurveOverShooting: true,
                                color: context.colorScheme.secondary,

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
                              // LineChartBarData(
                              //   barWidth: 1.5,
                              //   preventCurveOverShooting: true,
                              //   color: context.colorScheme.secondary,

                              //   spots: data
                              //       .map(
                              //         (e) => FlSpot(
                              //           e.date.fold(
                              //             () => 0,
                              //             (value) => value
                              //                 .millisecondsSinceEpoch
                              //                 .toDouble(),
                              //           ),
                              //           e.steps.toDouble(),
                              //         ),
                              //       )
                              //       .toList(),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  _ => Text.rich(
                    TextSpan(
                      text: 'Could not fetch data.\n',
                      children: [
                        TextSpan(
                          text: 'Retry 🔄',
                          style: TextStyle().copyWith(
                            color: context.colorScheme.secondary,
                            decoration: TextDecoration.underline,
                            decorationColor: context.colorScheme.secondary,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              dashNotifier.getBioData();
                            },
                        ),
                      ],
                    ),

                    textAlign: TextAlign.center,
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
            height: AppConstants.mediumSpaceM,
            colors: colors,
          ),
          AppShimmer(
            width: 150,
            height: AppConstants.mediumSpaceM,
            colors: colors,
          ),
          AppShimmer(
            width: 200,
            height: AppConstants.mediumSpaceM,
            colors: colors,
          ),
          AppShimmer(
            width: 150,
            height: AppConstants.mediumSpaceM,
            colors: colors,
          ),
        ],
      ),
    );
  }
}
