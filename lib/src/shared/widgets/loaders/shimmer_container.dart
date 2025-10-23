
import 'package:flutter/material.dart';
import 'package:unfold_dash/src/shared/shared.dart';
import 'package:unfold_dash/src/shared/theme/theme_data.dart';


class AppShimmer extends StatefulWidget {
  const AppShimmer(
      {super.key,
      this.height,
      this.width,
      this.child,
      required this.colors,
      this.baseColor});
  final double? height, width;
  final List<Color> colors;
  final Color? baseColor;
  final Widget? child;

  @override
  State<AppShimmer> createState() => _AppShimmerState();
}

class _AppShimmerState extends State<AppShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;
  late List<Color> colors;
  late int n;
  late double diff;
  @override
  void initState() {
    super.initState();
    // animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    // repeating animation
    _animationController.repeat(reverse: false);

    // animation
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });

    // colors
    colors = [];
    colors.add(widget.colors.last);
    colors.addAll(widget.colors);
    colors.addAll(widget.colors);

    // colors length
    n = widget.colors.length;

    // diff
    diff = (1 / n);
  }

  @override
  void dispose() {
    // disposing animationController
    _animationController.dispose();
    super.dispose();
  }

  List<double> stopsList() {
    int multiplier = -1 * n;
    List<double> stops = [];

    // generates (2*n + 1) stops
    while (multiplier <= n) {
      stops.add(_animation.value + (multiplier * diff));
      multiplier++;
    }

    return stops;
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: ShaderMask(
        child: AppContainerWrapper(
          height: widget.height ?? AppConstants.bigSpace,
          width: widget.width ?? MediaQuery.sizeOf(context).width,
          borderRadius: BorderRadius.circular(4),
          color: widget.baseColor ??
              context.colorScheme.surface.withValues(alpha: 0.7),
          child: widget.child ?? const SizedBox.shrink(),
        ),
        shaderCallback: (rect) {
          return LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.centerRight,
            tileMode: TileMode.clamp,
            stops: stopsList(),
            colors: colors,
          ).createShader(rect);
        },
      ),
    );
  }
}

class Bank78LoadingContainer extends StatelessWidget {
  const Bank78LoadingContainer(
      {super.key, this.height, this.width, this.colors});
  final double? height;
  final double? width;
  final List<Color>? colors;

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      width: width ?? MediaQuery.sizeOf(context).width,
      height: height ?? 60,
      baseColor: context.colorScheme.primary,
      colors: colors ??
          [
            context.colorScheme.primary,
            context.colorScheme.surface,
          ],
    );
  }
}
