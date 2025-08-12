import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wkout_core/wkout_core.dart';

class WkoutLoading<T extends WkoutBaseViewModel> extends StatelessWidget {
  final Widget child;
  final Widget? loadingWidget;

  const WkoutLoading({
    super.key,
    required this.child,
    this.loadingWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<T>(
      builder: (context, viewModel, child) {
        // Verificar se o ViewModel ainda está válido
        if (viewModel == null) {
          return child ?? const SizedBox.shrink();
        }
        
        return Stack(
          children: [
            IgnorePointer(
              ignoring: viewModel.screenLoading,
              child: child,
            ),
            Visibility(
              visible: viewModel.screenLoading,
              child: loadingWidget ?? const Center(child: CircularProgressIndicator()),
            ),
          ],
        );
      },
      child: child,
    );
  }
}
