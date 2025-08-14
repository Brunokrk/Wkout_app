import 'package:flutter/material.dart';

class Spacing {
  static SizedBox vertical(double height) {
    return SizedBox(height: height);
  }

  static SizedBox horizontal(double width) {
    return SizedBox(width: width);
  }
}

/// Widget que fecha o teclado quando o usuário clica fora dos campos de texto
class KeyboardDismissible extends StatelessWidget {
  final Widget child;
  final bool dismissOnTap;

  const KeyboardDismissible({
    super.key,
    required this.child,
    this.dismissOnTap = true,
  });

  @override
  Widget build(BuildContext context) {
    if (!dismissOnTap) return child;
    
    return GestureDetector(
      onTap: () {
        // Fecha o teclado quando clicar fora dos campos
        FocusScope.of(context).unfocus();
      },
      child: child,
    );
  }
}

