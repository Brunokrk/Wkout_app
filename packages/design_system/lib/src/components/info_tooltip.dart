import 'package:flutter/material.dart';
import '../tokens/colors.dart';
import '../tokens/typography.dart';

class InfoTooltip extends StatefulWidget {
  final String message;
  final Widget? child;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? margin;
  final Duration? showDuration;
  final double? iconSize;
  final Color? iconColor;

  const InfoTooltip({
    super.key,
    required this.message,
    this.child,
    this.backgroundColor,
    this.textStyle,
    this.margin,
    this.showDuration,
    this.iconSize,
    this.iconColor,
  });

  @override
  State<InfoTooltip> createState() => _InfoTooltipState();
}

class _InfoTooltipState extends State<InfoTooltip> {
  final GlobalKey<TooltipState> tooltipKey = GlobalKey<TooltipState>();

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      key: tooltipKey,
      message: widget.message,
      preferBelow: true,
      triggerMode: TooltipTriggerMode.manual,
      margin: widget.margin ?? const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? AppColors.primary.withOpacity(0.9),
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: widget.textStyle ?? AppTypography.bodyText1.copyWith(
        color: Colors.white,
        fontSize: 14,
      ),
      padding: const EdgeInsets.all(12),
      showDuration: widget.showDuration ?? const Duration(seconds: 3),
      child: widget.child ?? IconButton(
        onPressed: () {
          tooltipKey.currentState?.ensureTooltipVisible();
        },
        icon: const Icon(Icons.info_outline),
        color: widget.iconColor ?? AppColors.primary,
        iconSize: widget.iconSize ?? 24,
      ),
    );
  }
}