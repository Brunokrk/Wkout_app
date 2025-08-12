import 'package:authentication/authentication.dart';
import 'package:authentication/src/data/repositories/auth_repository.dart';
import 'package:wkout_core/injector/wkout_injector.dart';
import 'package:wkout_core/module/wkout_module.dart';
import 'package:wkout_core/wkout_core.dart';
import 'domain/usecases/auth_usecase.dart';
import 'data/data_source/auth_service.dart';
import 'presentation/pages/home/auth_home_view_model.dart';
import 'presentation/pages/register/register_profile_view_model.dart';
import 'routes/auth_routes.dart';

class AuthenticationModule extends WkoutModule<AuthenticationModule> {
  @override
  Future<void> registerInjection() async {
    //Services
    WkoutInjector.I.registerSingleton<AuthService>(() => AuthService());

    //REPOSITORIES
    WkoutInjector.I.registerFactory<IAuthRepository>(
        () => AuthRepository(authService: WkoutInjector.I.get<AuthService>()));

    //USE CASES
    WkoutInjector.I.registerLazySingleton<AuthUseCase>(
        () => AuthUseCase(repository: WkoutInjector.I.get<IAuthRepository>()));

    // Registrar rotas do módulo
    WkoutRouter().registerRoutes(AuthRoutes().routes);
  }

  @override
  Future<void> unregisterInjections() async {}

  @override
  Future<void> unload() async {}
}
