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
