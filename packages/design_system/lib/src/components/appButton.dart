import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

enum ButtonKind {
  primary,
  secondary,
}

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Icon? icon;
  final String? iconPath;
  final bool disabled;
  final bool isLoading;
  final double? height;
  final double? width;
  final ButtonKind kind;
  final Color? color;
  final Color? textColor;

  const AppButton({
    required this.label,
    required this.onPressed,
    this.icon,
    this.iconPath,
    this.height,
    this.width,
    this.disabled = false,
    this.isLoading = false,
    this.kind = ButtonKind.primary,
    this.color,
    this.textColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    switch (kind) {
      case ButtonKind.primary:
        return SizedBox(
          width: width ?? double.infinity,
          height: height ?? 40,
          child: (disabled)
              ? FilledButton(
                  onPressed: null,
                  child: (isLoading)
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Text(label, style: TextStyle(color: textColor ?? AppColors.whiteText),),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(color ?? AppColors.primary),
                  ),
                )
              : FilledButton(
                  onPressed: onPressed,
                  child: (isLoading)
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Text(label, style: TextStyle(color: textColor ?? AppColors.whiteText),),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(color ?? AppColors.primary),
                  ),
                ),
        );
      case ButtonKind.secondary:
        return SizedBox(
          width: width ?? double.infinity,
          height: height ?? 40,
          child: (disabled)
              ? OutlinedButton(
                  onPressed: null,
                  child: (isLoading)
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                          ),
                        )
                      : Text(label, style: TextStyle(color: textColor ?? AppColors.blackText),),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(color ?? AppColors.secondary),
                  ),
                )
              : OutlinedButton(
                  onPressed: onPressed,
                  child: (isLoading)
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                          ),
                        )
                      : Text(label, style: TextStyle(color: textColor ?? AppColors.blackText),),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(color ?? AppColors.secondary),
                  ),
                ),
        );
    }
  }
}
