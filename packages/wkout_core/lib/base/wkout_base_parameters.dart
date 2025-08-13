import 'dart:convert';

/// Classe abstrata base para parâmetros de navegação
/// 
/// Força a implementação dos métodos [toExtra] e [fromExtra] para
/// padronizar a serialização e deserialização de parâmetros
/// 

abstract class WkoutBaseParameters {
  /// Converte os parâmetros para uma string JSON
  String toExtra();
  
  /// Cria uma instância dos parâmetros a partir de uma string JSON
  WkoutBaseParameters fromExtra(Object? extra);
  

  /// Implementação padrão retorna true. Sobrescrever este método
  /// para adicionar validações específicas
  bool get isValid => true;
  
  /// Útil para debug e logging
  @override
  String toString() {
    return '${runtimeType}(toExtra: ${toExtra()})';
  }
} 