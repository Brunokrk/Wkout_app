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
    return Consumer<T>(builder: (context, viewModel, child) {
      
      return Stack(
        children: [
          IgnorePointer(
            ignoring: viewModel.screenLoading,
            child: child,
          ),
          Visibility(
            visible: viewModel.screenLoading,
            child: loadingWidget ??  Center(child: CircularProgressIndicator()),
          ),
        ],
      );
    }, child: child);
  }
}
