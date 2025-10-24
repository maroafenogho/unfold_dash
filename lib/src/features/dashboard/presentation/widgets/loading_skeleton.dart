import 'package:flutter/material.dart';
import 'package:unfold_dash/src/shared/shared.dart';

class ChartLoader extends StatelessWidget {
  const ChartLoader({super.key, required this.colors, this.baseColor});
  final List<Color> colors;
  final Color? baseColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      spacing: AppConstants.mediumSpaceX,
      children: [
        AppShimmer(
          width: MediaQuery.sizeOf(context).width * 0.85,
          height: 200,
          baseColor: baseColor,
          colors: colors,
        ),
        AppShimmer(
          width: MediaQuery.sizeOf(context).width * 0.85,
          height: 200,
          baseColor: baseColor,
          colors: colors,
        ),
        AppShimmer(
          width: MediaQuery.sizeOf(context).width * 0.85,
          height: 200,
          baseColor: baseColor,
          colors: colors,
        ),
      ],
    );
  }
}
