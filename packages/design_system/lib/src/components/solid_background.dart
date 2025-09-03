import 'package:flutter/material.dart';
import '../tokens/colors.dart';


class SolidBackgroundWidget extends StatelessWidget {
  final Widget child;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const SolidBackgroundWidget({
    super.key,
    required this.child,
    this.color,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: color,
      ),
      child: child,
    );
  }
  
} 