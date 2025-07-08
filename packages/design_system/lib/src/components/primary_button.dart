import 'package:design_system/src/tokens/colors.dart';
import 'package:flutter/material.dart';

class WkPrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Icon? icon;
  final String? iconPath;
  final bool disabled;
  final bool isLoading;

  const WkPrimaryButton({
    required this.label,
    required this.onPressed,
    this.icon,
    this.iconPath,
    this.disabled = false,
    this.isLoading = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: (disabled)
          ? FilledButton(onPressed: null, child: Text(label))
          : FilledButton(onPressed: onPressed, child: Text(label)),
    );
  }
}
