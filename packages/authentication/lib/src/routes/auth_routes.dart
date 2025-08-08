import 'package:flutter/material.dart';
import 'package:wkout_core/wkout_core.dart';
import 'package:provider/provider.dart';
import '../presentation/pages/home/auth_home_page.dart';
import '../presentation/pages/register/register_profile_page.dart';
import '../presentation/pages/home/auth_home_view_model.dart';
import '../presentation/pages/register/register_profile_view_model.dart';

class AuthRoutes implements WkoutModuleRoutes {
  static const String home = '/';
  static const String registerProfile = '/register-profile';

  @override
  List<RouteBase> get routes => [
        GoRoute(
          path: home,
          builder: (context, state) => ChangeNotifierProvider<AuthHomeViewModel>(
            create: (context) => WkoutInjector.I.get<AuthHomeViewModel>(),
            child: const AuthHomePage(),
          ),
        ),
        GoRoute(
          path: registerProfile,
          builder: (context, state) => ChangeNotifierProvider<RegisterProfileViewModel>(
            create: (context) => WkoutInjector.I.get<RegisterProfileViewModel>(),
            child: const RegisterProfilePage(),
          ),
        ),
      ];

  @override
  List<RouteBase> get shellRoutes => [];
}
