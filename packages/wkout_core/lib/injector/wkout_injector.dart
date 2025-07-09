import 'package:get_it/get_it.dart';

class WkoutInjector {
  static WkoutInjector? _instance;
  WkoutInjector._();

  static WkoutInjector get I => _instance ??= WkoutInjector._();
  static WkoutInjector get instance => _instance ??= WkoutInjector._();

  final GetIt _getIt = GetIt.instance;
}