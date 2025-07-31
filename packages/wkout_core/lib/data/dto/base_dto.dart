import 'dart:convert';

/// Classe base para todos os DTOs do app Wkout
abstract class BaseDto {
  Map<String, dynamic> toMap();
  static T fromMap<T extends BaseDto>(Map<String, dynamic> map) {
    throw UnimplementedError('fromMap deve ser implementado nas subclasses');
  }

  String toJson() {
    return jsonEncode(toMap());
  }
  
  static T fromJson<T extends BaseDto>(String json) {
    return fromMap<T>(jsonDecode(json));
  }
  
  /// Cria uma cópia do DTO com modificações
  BaseDto copyWith(Map<String, dynamic> changes);
  
  /// Verifica se o DTO é válido
  bool get isValid;
  
  @override
  String toString() {
    return '${runtimeType}(${toMap()})';
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BaseDto && other.toMap() == toMap();
  }
  
  @override
  int get hashCode => toMap().hashCode;
}

/// Mixin para validação de DTOs
mixin ValidationMixin {
  /// Regras de validação
  Map<String, List<ValidationRule>> get validationRules;
  
  /// Valida o DTO
  bool get isValid {
    return validationErrors.isEmpty;
  }
  
  /// Obtém erros de validação
  List<String> get validationErrors {
    final errors = <String>[];
    
    for (final entry in validationRules.entries) {
      final field = entry.key;
      final rules = entry.value;
      final value = getFieldValue(field);
      
      for (final rule in rules) {
        if (!rule.isValid(value)) {
          errors.add('${rule.errorMessage}');
          break; // Para no primeiro erro do campo
        }
      }
    }
    
    return errors;
  }
  
  /// Obtém o valor de um campo (deve ser implementado)
  dynamic getFieldValue(String field);
}

/// Regra de validação
class ValidationRule {
  final bool Function(dynamic value) validator;
  final String errorMessage;
  
  const ValidationRule({
    required this.validator,
    required this.errorMessage,
  });
  
  bool isValid(dynamic value) => validator(value);
}

/// Regras de validação comuns
class ValidationRules {
  static const required = ValidationRule(
    validator: _isNotEmpty,
    errorMessage: 'Campo obrigatório',
  );
  
  static const email = ValidationRule(
    validator: _isValidEmail,
    errorMessage: 'Email inválido',
  );
  
  static const minLengthDefault = ValidationRule(
    validator: _hasMinLength,
    errorMessage: 'Mínimo de caracteres não atingido',
  );
  
  static ValidationRule minLength(int length) {
    return ValidationRule(
      validator: (value) => _hasMinLength(value, length),
      errorMessage: 'Mínimo de $length caracteres',
    );
  }
  
  static ValidationRule maxLength(int length) {
    return ValidationRule(
      validator: (value) => _hasMaxLength(value, length),
      errorMessage: 'Máximo de $length caracteres',
    );
  }
  
  static ValidationRule range(num min, num max) {
    return ValidationRule(
      validator: (value) => _isInRange(value, min, max),
      errorMessage: 'Valor deve estar entre $min e $max',
    );
  }
  
  // Implementações dos validadores
  static bool _isNotEmpty(dynamic value) {
    if (value == null) return false;
    if (value is String) return value.trim().isNotEmpty;
    if (value is List) return value.isNotEmpty;
    if (value is Map) return value.isNotEmpty;
    return true;
  }
  
  static bool _isValidEmail(dynamic value) {
    if (value == null || value is! String) return false;
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(value);
  }
  
  static bool _hasMinLength(dynamic value, [int? minLength]) {
    if (value == null || value is! String) return false;
    return value.length >= (minLength ?? 6);
  }
  
  static bool _hasMaxLength(dynamic value, int maxLength) {
    if (value == null || value is! String) return false;
    return value.length <= maxLength;
  }
  
  static bool _isInRange(dynamic value, num min, num max) {
    if (value == null) return false;
    if (value is num) return value >= min && value <= max;
    return false;
  }
} 