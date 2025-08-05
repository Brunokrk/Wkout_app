import 'package:flutter/material.dart';
import '../tokens/colors.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;
  final AlignmentGeometry? begin;
  final AlignmentGeometry? end;
  final List<Color>? colors;
  final List<double>? stops;

  const GradientBackground({
    super.key,
    required this.child,
    this.begin,
    this.end,
    this.colors,
    this.stops,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: begin ?? Alignment.topCenter,
          end: end ?? Alignment.bottomCenter,
          colors: colors ?? [
            AppColors.primary.withOpacity(0.8),
            AppColors.secondary.withOpacity(0.6),
          ],
          stops: stops ?? [0.0, 1.0],
        ),
      ),
      child: child,
    );
  }
}

class GradientBackgroundWidget extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const GradientBackgroundWidget({
    super.key,
    required this.child,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.primary,
            AppColors.secondary,
          ],
          stops: [0.0, 1.0],
        ),
      ),
      child: child,
    );
  }
  
} 