import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Serviço de navegação centralizado que encapsula as operações do go_router
class WkoutNavigationService {
  static final WkoutNavigationService _instance =
      WkoutNavigationService._internal();
  factory WkoutNavigationService() => _instance;
  WkoutNavigationService._internal();

  /// Navega para uma rota específica
  void go(BuildContext context, String route) {
    context.go(route);
  }

  /// Navega para uma rota específica com parâmetros
  void goWithParams(
      BuildContext context, String route, Map<String, String> params) {
    context.go(route, extra: params);
  }

  /// Navega para uma rota específica com dados extras
  void goWithExtra(BuildContext context, String route, Object extra) {
    context.go(route, extra: extra);
  }

  /// Navega para uma rota específica (push)
  void push(BuildContext context, String route) {
    context.push(route);
  }

  /// Navega para uma rota específica com parâmetros (push)
  void pushWithParams(
      BuildContext context, String route, Map<String, String> params) {
    context.push(route, extra: params);
  }

  /// Navega para uma rota específica com dados extras (push)
  void pushWithExtra(BuildContext context, String route, Object extra) {
    context.push(route, extra: extra);
  }

  /// Volta para a tela anterior
  void pop(BuildContext context) {
    context.pop();
  }

  /// Volta para uma rota específica com resultado
  void popWithResult(BuildContext context, Object result) {
    context.pop(result);
  }

  /// Volta para uma rota específica
  void popTo(BuildContext context, String route) {
    context.pop();
  }
}
