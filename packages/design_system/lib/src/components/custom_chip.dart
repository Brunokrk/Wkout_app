import 'package:flutter/material.dart';
import '../tokens/colors.dart';
import '../tokens/typography.dart';

class CustomChip extends StatefulWidget {
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;
  final IconData? icon;
  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? selectedTextColor;
  final Color? unselectedTextColor;
  final double? height;
  final EdgeInsetsGeometry? padding;

  const CustomChip({
    super.key,
    required this.label,
    this.isSelected = false,
    this.onTap,
    this.icon,
    this.selectedColor,
    this.unselectedColor,
    this.selectedTextColor,
    this.unselectedTextColor,
    this.height,
    this.padding,
  });

  @override
  State<CustomChip> createState() => _CustomChipState();
}

class _CustomChipState extends State<CustomChip> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: widget.height ?? 40,
        padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: widget.isSelected 
            ? (widget.selectedColor ?? AppColors.secondary)
            : (widget.unselectedColor ?? Colors.transparent),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: widget.isSelected 
              ? (widget.selectedColor ?? AppColors.primary)
              : AppColors.primary.withOpacity(0.3),
            width: 1.5,
          ),
          boxShadow: widget.isSelected ? [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ] : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.icon != null) ...[
              Icon(
                widget.icon,
                size: 16,
                color: widget.isSelected 
                  ? (widget.selectedTextColor ?? Colors.white)
                  : (widget.unselectedTextColor ?? AppColors.primary),
              ),
              const SizedBox(width: 6),
            ],
            Text(
              widget.label,
              style: AppTypography.bodyText1.copyWith(
                color: widget.isSelected 
                  ? (widget.selectedTextColor ?? Colors.white)
                  : (widget.unselectedTextColor ?? AppColors.secondary),
                fontWeight: widget.isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActivityChip extends StatelessWidget {
  final String activity;
  final bool isSelected;
  final VoidCallback? onTap;
  final IconData icon;

  const ActivityChip({
    super.key,
    required this.activity,
    required this.isSelected,
    this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return CustomChip(
      label: activity,
      isSelected: isSelected,
      onTap: onTap,
      icon: icon,
      selectedColor: AppColors.secondary,
      unselectedColor: Colors.transparent,
      selectedTextColor: Colors.white,
      unselectedTextColor: AppColors.primary,
    );
  }
}
