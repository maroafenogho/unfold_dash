import 'package:flutter/material.dart';
import 'package:unfold_dash/src/features/dashboard/application/dashboard_notifier.dart';
import 'package:unfold_dash/src/features/dashboard/presentation/widgets/widgets.dart';
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
      key: Key('dashboard'),
      backgroundColor: context.colorScheme.background,
      appBar: AppBar(
        backgroundColor: context.colorScheme.surface,
        title: Text(widget.title, style: context.typography.paragraph.p1),
        actionsPadding: AppConstants.mediumSpace.hEdgeInsets,
        actions: [const ThemeModeSwitcher()],
      ),
      body: ListenableBuilder(
        listenable: dashNotifier,
        builder: (context, child) {
          return switch (dashNotifier.state.biometricsUiState) {
            LoadingState() => Center(
              child: ChartLoader(
                colors: [
                  context.colorScheme.textSecondary,
                  context.colorScheme.textPrimary,
                  context.colorScheme.textSecondary,
                ],
                baseColor: context.colorScheme.surface,
              ),
            ),
            SuccessState(result: final data) => SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: AppConstants.mediumSpaceM.allEdgeInsets,

                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      spacing: AppConstants.smallSpace,

                      children: [
                        SegmentedButton<TimeRange>(
                          key: const Key('interval_segmented_button'),
                          showSelectedIcon: true,
                          selectedIcon: Icon(
                            Icons.check,
                            color: context.colorScheme.textPrimary,
                          ),
                          onSelectionChanged: (range) {
                            dashNotifier.filterBioData(range.first, data);
                          },
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Get large data: ',
                              style: context.typography.paragraph.p3.bold,
                            ),
                            SizedBox(
                              height: AppConstants.mediumSpaceX,

                              child: FittedBox(
                                child: Switch(
                                  value: dashNotifier.state.getLargeDataSet,
                                  trackColor: WidgetStateColor.resolveWith(
                                    (states) =>
                                        context.colorScheme.textSecondary,
                                  ),
                                  thumbColor: WidgetStateColor.resolveWith(
                                    (states) => context.colorScheme.textPrimary,
                                  ),
                                  onChanged: dashNotifier.updateGetLargeData,
                                ),
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () => dashNotifier.state.getLargeDataSet
                              ? dashNotifier.getLargeData(10200)
                              : dashNotifier.getBioData(),
                          child: AppContainerWrapper(
                            margin: EdgeInsets.zero,
                            borderRadius: BorderRadius.circular(
                              AppConstants.bigSpace,
                            ),
                            padding: 4.allEdgeInsets,
                            child: Icon(
                              Icons.refresh,
                              color: context.colorScheme.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    AppConstants.mediumSpaceM.vSpace,
                    UnfoldChart(
                      data: dashNotifier.state.filteredDataPoints,

                      returnTouchedPoint: (index) {
                        dashNotifier.setTouchedPoint(
                          dashNotifier.state.filteredDataPoints[index],
                        );
                      },
                      title: 'HRV (Heart Rate Variability)',
                      showBand: true,
                      color: context.colorScheme.textSecondary,
                      getData: (dataPoint) => dataPoint.hrv.toDouble(),
                      unit: 'ms',
                    ),
                    AppConstants.mediumSpaceM.vSpace,
                    UnfoldChart(
                      data: dashNotifier.state.filteredDataPoints,
                      title: 'RHR (Resting Heart Rate)',
                      returnTouchedPoint: (index) {
                        dashNotifier.setTouchedPoint(
                          dashNotifier.state.filteredDataPoints[index],
                        );
                      },
                      color: context.colorScheme.tetiary,
                      getData: (dataPoint) => dataPoint.rhr.toDouble(),
                      unit: 'bpm',
                    ),
                    AppConstants.mediumSpaceM.vSpace,
                    UnfoldChart(
                      data: dashNotifier.state.filteredDataPoints,
                      title: 'Steps',
                      returnTouchedPoint: (index) {
                        dashNotifier.setTouchedPoint(
                          dashNotifier.state.filteredDataPoints[index],
                        );
                      },
                      color: context.colorScheme.success,
                      getData: (dataPoint) => dataPoint.steps.toDouble(),
                      unit: 'steps',
                    ),
                  ],
                ),
              ),
            ),
            ErrorState(exception: final error) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    error.toString(),
                    textAlign: TextAlign.center,
                    style: context.typography.paragraph.p3,
                  ),
                  InkWell(
                    onTap: () {
                      dashNotifier.getBioData();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Retry',
                          style: context.typography.paragraph.p3.bold.copyWith(
                            color: context.colorScheme.primary,
                          ),
                        ),
                        Icon(
                          Icons.refresh,
                          size: AppConstants.mediumSpaceM,
                          color: context.colorScheme.primary,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            IdleState() => const SizedBox.shrink(),
          };
        },
      ),
    );
  }
}
