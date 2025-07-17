import 'package:go_router/go_router.dart';
import 'package:authentication/src/presentation/pages/home/auth_home_page.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const AuthHomePage(),
    ),
  ],
);