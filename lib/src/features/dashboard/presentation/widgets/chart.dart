import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:unfold_dash/src/features/dashboard/application/dashboard_notifier.dart';
import 'package:unfold_dash/src/features/dashboard/domain/dtos/response/biometrics_point.dart';
import 'package:unfold_dash/src/shared/services/mean_service.dart';
import 'package:unfold_dash/src/shared/shared.dart';

class UnfoldChart extends StatelessWidget {
  const UnfoldChart({
    super.key,
    required this.data,
    required this.title,
    required this.getData,
    required this.unit,
    required this.returnTouchedPoint,
    required this.color,
    this.showBand = false,
  });

  final List<BiometricsPoint> data;
  final String title;
  final double Function(BiometricsPoint) getData;
  final Function(int) returnTouchedPoint;
  final String unit;
  final Color color;
  final bool showBand;
  @override
  Widget build(BuildContext context) {
    final spots = data
        .asMap()
        .entries
        .map((e) => FlSpot(e.key.toDouble(), getData(e.value)))
        .toSet()
        .toList();

    final line = [
      LineChartBarData(
        barWidth: 1.5,
        dotData: FlDotData(show: false),
        preventCurveOverShooting: true,
        color: color,
        isCurved: true,
        spots: spots.isNotEmpty ? spots : [FlSpot(0, 0)],
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            begin: AlignmentGeometry.topCenter,
            end: AlignmentGeometry.bottomCenter,
            colors: [color.withValues(alpha: 0.35), Colors.transparent],
          ),
        ),
      ),
    ];

    final minAndMaxValues = spots.minimumAndMaximum;
    final padding = (minAndMaxValues.max - minAndMaxValues.min) * 0.1;
    if (showBand && data.length >= 10) {
      final bands = MeanService.generateHrvBands(
        spots.map((e) => e.y).toList(),
      );

      line.add(
        LineChartBarData(
          barWidth: 1.5,
          dotData: FlDotData(show: false),
          preventCurveOverShooting: true,
          color: context.colorScheme.primary,
          isCurved: true,
          spots: bands.mean.isNotEmpty ? bands.mean : [FlSpot(0, 0)],
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              begin: AlignmentGeometry.topCenter,
              end: AlignmentGeometry.bottomCenter,
              colors: [color.withValues(alpha: 0.35), Colors.transparent],
            ),
          ),
        ),
      );

      line.add(
        LineChartBarData(
          barWidth: 1.5,
          dotData: FlDotData(show: false),
          preventCurveOverShooting: true,
          color: Colors.transparent,
          isCurved: true,
          spots: bands.upper.isNotEmpty ? bands.upper : [FlSpot(0, 0)],
          belowBarData: BarAreaData(
            show: true,
            color: context.colorScheme.tetiary.withValues(alpha: 0.2),
            cutOffY: bands.lower.last.y,
            applyCutOffY: true,
          ),
        ),
      );
    }
    return AppContainerWrapper(
      child: Column(
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(title, style: context.typography.title.t4)],
            ),
          ),
          AppConstants.mediumSpaceM.vSpace,
          SizedBox(
            height: 200,
            child: LineChart(
              duration: AppConstants.shortAnimDur, // Optional
              curve: Curves.easeInOutCirc, //
              transformationConfig: FlTransformationConfig(
                trackpadScrollCausesScale: true,
                scaleAxis: FlScaleAxis.free,
                maxScale: 5,
              ),
              LineChartData(
                borderData: FlBorderData(show: false),
                gridData: FlGridData(show: true),
                extraLinesData: ExtraLinesData(
                  verticalLines: [
                    VerticalLine(
                      x: data.indexOf(dashNotifier.state.point).toDouble(),
                      color: context.colorScheme.primary,
                      strokeWidth: 1,
                      dashArray: [4, 4],
                    ),
                  ],
                ),
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
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        return spots.isEmpty
                            ? const SizedBox.shrink()
                            : Text(
                                data[value.toInt()].date
                                    .getOrElse(DateTime.now())
                                    .toFormattedDate,
                                style: context.typography.body.b3,
                              );
                      },
                    ),
                  ),
                ),
                minY: minAndMaxValues.min - padding,
                maxY: minAndMaxValues.max + padding,
                lineTouchData: LineTouchData(
                  touchCallback: (event, response) {
                    if (event.isInterestedForInteractions &&
                        response != null &&
                        response.lineBarSpots != null &&
                        response.lineBarSpots!.isNotEmpty) {
                      final touchedX = response.lineBarSpots!.first.x;
                      returnTouchedPoint(touchedX.toInt());
                    } else if (event is FlLongPressEnd ||
                        event is FlPanEndEvent ||
                        event is FlTapUpEvent) {}
                  },

                  touchTooltipData: LineTouchTooltipData(
                    maxContentWidth: 200,
                    tooltipBorder: BorderSide(
                      color: context.colorScheme.textSecondary,
                    ),
                    getTooltipColor: (touchedSpot) =>
                        context.colorScheme.surface,
                    fitInsideVertically: true,
                    // fitInsideHorizontally: true,
                    showOnTopOfTheChartBoxArea: true,
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((e) {
                        // returnTouchedPoint(e.spotIndex);
                        return LineTooltipItem(
                          textAlign: TextAlign.left,
                          data[e.spotIndex].date
                              .getOrElse(DateTime.now())
                              .toFullDate,
                          context.typography.paragraph.p4,
                          children: [
                            TextSpan(text: '\n${e.y.truncatedNumber} $unit'),
                          ],
                        );
                      }).toList();
                    },
                  ),
                ),
                lineBarsData: [...line],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
