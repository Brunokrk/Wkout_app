import 'package:wkout_core/wkout_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterDto extends BaseDto{
  final String id;
  final String email;
  
  RegisterDto({
    required this.id,
    required this.email,
  });

  factory RegisterDto.fromSupabaseUser(User user) {
    return RegisterDto(
      id: user.id,
      email: user.email ?? '',
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'email': email,
    };
    }

  @override
  dynamic getFieldValue(String field) {
    switch (field) {
      case 'email':
        return email;
      
    }
  }
  
  @override
  BaseDto copyWith(Map<String, dynamic> changes) {
    return RegisterDto(
      email: changes['email'] ?? email,
      id: changes['id'] ?? id,
    );
  }

  static RegisterDto fromMap(Map<String, dynamic> map) {
    return RegisterDto(
      email: map['email'] ?? '',
      id: map['id'] ?? '',
    );
  }
}