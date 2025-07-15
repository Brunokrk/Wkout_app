import 'package:wkout_core/injector/wkout_injector.dart';
import 'package:wkout_core/module/wkout_module.dart';
import 'data/data_source/auth_service.dart';
import 'presentation/pages/home/auth_home_view_model.dart';

class AuthenticationModule extends WkoutModule<AuthenticationModule> {
  @override
  Future<void> registerInjection() async {
    WkoutInjector.I.registerSingleton<AuthService>(() => AuthService());
    WkoutInjector.I.registerSingleton<AuthHomeViewModel>(() => AuthHomeViewModel());
  }

  @override
  Future<void> unregisterInjections() async {
    // GetIt não tem método unregister, então não precisamos fazer nada aqui
  }

  @override
  Future<void> unload() async {}
}