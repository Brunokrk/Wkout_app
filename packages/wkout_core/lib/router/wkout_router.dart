import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

/// Classe responsável por gerenciar o roteamento centralizado da aplicação
class WkoutRouter {
  static final WkoutRouter _instance = WkoutRouter._internal();
  factory WkoutRouter() => _instance;
  WkoutRouter._internal();

  final List<RouteBase> _routes = [];
  final List<RouteBase> _shellRoutes = [];

  /// Registra rotas de um módulo
  void registerRoutes(List<RouteBase> routes) {
    _routes.addAll(routes);
  }

  /// Registra shell routes (para navegação com bottom navigation, etc.)
  void registerShellRoutes(List<RouteBase> shellRoutes) {
    _shellRoutes.addAll(shellRoutes);
  }

  /// Cria a instância do GoRouter com todas as rotas registradas
  GoRouter createRouter() {
    final allRoutes = [..._shellRoutes, ..._routes];

    return GoRouter(
      routes: allRoutes,
      initialLocation: '/',
      debugLogDiagnostics: true,
    );
  }

  /// Limpa todas as rotas registradas (útil para testes)
  void clearRoutes() {
    _routes.clear();
    _shellRoutes.clear();
  }
}

/// Classe base para definir rotas de um módulo
abstract class WkoutModuleRoutes {
  /// Retorna as rotas do módulo
  List<RouteBase> get routes;

  /// Retorna as shell routes do módulo (opcional)
  List<RouteBase> get shellRoutes => [];
}
