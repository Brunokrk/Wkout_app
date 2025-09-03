import 'package:wkout_core/wkout_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserDto extends BaseDto{
  final String id;
  final String email;
  final String? name;
  //final int? age;
  //final String? avatarUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserDto({
    required this.id,
    required this.email,
    this.name,
    //this.age,
    //this.avatarUrl,
    this.createdAt,
    this.updatedAt,
  });

  /// Converte um User do Supabase para UserDto
  factory UserDto.fromSupabaseUser(User user) {
    return UserDto(
      id: user.id,
      email: user.email ?? '',
      name: user.userMetadata?['name'] as String?,
      //age: user.userMetadata?['age'] as int?,
      //avatarUrl: user.userMetadata?['avatar_url'] as String?,
      createdAt: user.createdAt != null ? DateTime.parse(user.createdAt!) : null,
      updatedAt: user.updatedAt != null ? DateTime.parse(user.updatedAt!) : null,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      //'age': age,
     // 'avatarUrl': avatarUrl,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  @override
  UserDto copyWith(Map<String, dynamic> changes) {
    return UserDto(
      id: changes['id'] ?? id,
      email: changes['email'] ?? email,
      name: changes['name'] ?? name,
      //age: changes['age'] ?? age,
      //avatarUrl: changes['avatarUrl'] ?? avatarUrl,
      createdAt: changes['createdAt'] != null 
          ? DateTime.parse(changes['createdAt']) 
          : createdAt,
      updatedAt: changes['updatedAt'] != null 
          ? DateTime.parse(changes['updatedAt']) 
          : updatedAt,
    );
  }

  @override
  dynamic getFieldValue(String field) {
    switch (field) {
      case 'id':
        return id;
      case 'email':
        return email;
      case 'name':
        return name;
      //case 'age':
      //  return age;
      default:
        return null;
    }
  }

  static UserDto fromMap(Map<String, dynamic> map) {
    return UserDto(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      name: map['name'],
      //age: map['age'],
      //avatarUrl: map['avatarUrl'],
      createdAt: map['createdAt'] != null 
          ? DateTime.parse(map['createdAt']) 
          : null,
      updatedAt: map['updatedAt'] != null 
          ? DateTime.parse(map['updatedAt']) 
          : null,
    );
  }

  @override
  String toString() {
    return 'UserDto(id: $id, email: $email, name: $name)';
  }
} 