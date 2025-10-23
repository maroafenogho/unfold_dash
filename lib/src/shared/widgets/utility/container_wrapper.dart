
import 'package:flutter/material.dart';
import 'package:unfold_dash/src/shared/shared.dart';
import 'package:unfold_dash/src/shared/theme/theme_data.dart';

class AppContainerWrapper extends StatelessWidget {
  const AppContainerWrapper({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.gradient,
    this.color,
    this.height,
    this.borderRadius,
    this.width,
    this.border,
    this.onTap,
    this.onLongPress,
    this.constraints,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Gradient? gradient;
  final Color? color;
  final double? height, width;
  final BorderRadiusGeometry? borderRadius;
  final BoxBorder? border;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final BoxConstraints? constraints;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeIn,
            constraints: constraints,
            height: height,
            width: width,
            margin: margin ?? EdgeInsets.zero,
            padding: padding ?? AppConstants.mediumSpaceM.allEdgeInsets,
            decoration: BoxDecoration(
              gradient: gradient,
              border: border,
              borderRadius: borderRadius ??
                  BorderRadius.circular(AppConstants.mediumSpace - 2),
              color: color ?? context.colorScheme.surface,
            ),
            child: child),
      ),
    );
  }
}
