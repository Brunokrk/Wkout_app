import 'package:wkout_core/injector/wkout_injector.dart';
import 'package:wkout_core/module/wkout_module.dart';
import 'package:wkout_core/wkout_core.dart';
import 'data/data_source/auth_service.dart';
import 'presentation/pages/home/auth_home_view_model.dart';
import 'presentation/pages/register/register_profile_view_model.dart';
import 'routes/auth_routes.dart';

class AuthenticationModule extends WkoutModule<AuthenticationModule> {
  @override
  Future<void> registerInjection() async {
    WkoutInjector.I.registerSingleton<AuthService>(() => AuthService());
    WkoutInjector.I
        .registerSingleton<AuthHomeViewModel>(() => AuthHomeViewModel());
    WkoutInjector.I
        .registerFactory<RegisterProfileViewModel>(() => RegisterProfileViewModel());

    // Registrar rotas do módulo
    WkoutRouter().registerRoutes(AuthRoutes().routes);
  }

  @override
  Future<void> unregisterInjections() async {}

  @override
  Future<void> unload() async {}
}
