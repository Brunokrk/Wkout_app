import 'package:authentication/src/domain/usecases/auth_usecase.dart';
import 'package:authentication/src/presentation/pages/register/register_user_page.dart';
import 'package:authentication/src/presentation/pages/register/register_user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:wkout_core/wkout_core.dart';
import 'package:provider/provider.dart';
import 'package:design_system/design_system.dart';
import '../presentation/pages/home/auth_home_page.dart';
import '../presentation/pages/register/register_profile_page.dart';
import '../presentation/pages/home/auth_home_view_model.dart';
import '../presentation/pages/register/register_profile_view_model.dart';
import '../presentation/parameters/register_profile_parameters.dart';

class AuthRoutes implements WkoutModuleRoutes {
  static const String home = '/';
  static const String registerPassword = '/register-password';
  static const String registerProfile = '/register-profile';

  @override
  List<RouteBase> get routes => [
        GoRoute(
          path: home,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => AuthHomeViewModel(
                authUseCase: WkoutInjector.I.get<AuthUseCase>()),
            child: const AuthHomePage(),
          ),
        ),
          GoRoute(
              path: registerPassword,
              builder: (context, state) => ChangeNotifierProvider<RegisterUserViewModel>(
            create: (_) => RegisterUserViewModel(
                authUseCase: WkoutInjector.I.get<AuthUseCase>()),
            child: const RegisterUserPage(),
          ),
        ),
        GoRoute(
          path: registerProfile,
          builder: (_, state) {
            
            return ChangeNotifierProvider<RegisterProfileViewModel>(
              create: (_) => RegisterProfileViewModel(
                authUseCase: WkoutInjector.I.get<AuthUseCase>(),
              ),
              child: RegisterProfilePage(
                registerProfileParameters: RegisterProfileParameters().fromExtra(state.extra),
              ),
            );
          },
        ),
      ];

  @override
  List<RouteBase> get shellRoutes => [];
}
