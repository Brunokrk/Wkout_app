import 'package:flutter/material.dart';
import 'package:wkout_core/wkout_core.dart';
import '../presentation/pages/home/auth_home_page.dart';
import '../presentation/pages/register/register_profile_page.dart';

class AuthRoutes implements WkoutModuleRoutes {
  static const String home = '/';
  static const String registerProfile = '/register-profile';

  @override
  List<RouteBase> get routes => [
        GoRoute(
          path: home,
          builder: (context, state) => const AuthHomePage(),
        ),
        GoRoute(
          path: registerProfile,
          builder: (context, state) => const RegisterProfilePage(),
        ),
      ];

  @override
  List<RouteBase> get shellRoutes => [];
}
