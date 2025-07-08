import 'package:go_router/go_router.dart';
import 'package:authentication/authentication.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const AuthHomePage(),
    ),
  ],
);