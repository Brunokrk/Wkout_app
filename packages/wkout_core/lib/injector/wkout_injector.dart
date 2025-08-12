import 'package:get_it/get_it.dart';

class WkoutInjector {
  static WkoutInjector? _instance;
  WkoutInjector._();

  static WkoutInjector get I => _instance ??= WkoutInjector._();
  static WkoutInjector get instance => _instance ??= WkoutInjector._();

  final GetIt _getIt = GetIt.instance;

  void registerSingleton<T extends Object>(FactoryFunc<T> factory,
      {String? instanceName}) {
    if (!_getIt.isRegistered<T>()) {
      _getIt.registerLazySingleton<T>(factory, instanceName: instanceName);
    }
  }

  void registerFactory<T extends Object>(FactoryFunc<T> factoryFunc,
      {String? instanceName}) {
    if (!_getIt.isRegistered<T>()) {
      _getIt.registerFactory(factoryFunc, instanceName: instanceName);
    }
  }

  void registerLazySingleton<T extends Object>(FactoryFunc<T> factoryFunc, {String? instanceName}){
    if(!_getIt.isRegistered<T>()) {
      _getIt.registerLazySingleton(factoryFunc, instanceName: instanceName);
    }
  }

  T get<T extends Object>({String? instanceName}) {
    return _getIt.get<T>(instanceName: instanceName);
  }
}
