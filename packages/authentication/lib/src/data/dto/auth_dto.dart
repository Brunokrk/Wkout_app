import 'package:wkout_core/wkout_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// DTO para login
class LoginDto extends BaseDto with ValidationMixin {
  final String email;
  final String password;

  LoginDto({
    required this.email,
    required this.password,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }

  @override
  LoginDto copyWith(Map<String, dynamic> changes) {
    return LoginDto(
      email: changes['email'] ?? email,
      password: changes['password'] ?? password,
    );
  }

  @override
  bool get isValid => validationErrors.isEmpty;

  @override
  List<String> get validationErrors {
    final errors = <String>[];
    
    if (!ValidationRules.email.isValid(email)) {
      errors.add('Email inválido');
    }
    
    if (!ValidationRules.minLength(6).isValid(password)) {
      errors.add('Senha deve ter pelo menos 6 caracteres');
    }
    
    return errors;
  }

  @override
  Map<String, List<ValidationRule>> get validationRules => {
    'email': [ValidationRules.required, ValidationRules.email],
    'password': [ValidationRules.required, ValidationRules.minLength(6)],
  };

  @override
  dynamic getFieldValue(String field) {
    switch (field) {
      case 'email':
        return email;
      case 'password':
        return password;
      default:
        return null;
    }
  }

  static LoginDto fromMap(Map<String, dynamic> map) {
    return LoginDto(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }

  @override
  String toString() {
    return 'LoginDto(email: $email, password: ${'*' * password.length})';
  }
}

/// DTO para registro
class RegisterDto extends BaseDto with ValidationMixin {
  final String email;
  final String password;
  final String confirmPassword;
  final String? name;
  final int? age;

  RegisterDto({
    required this.email,
    required this.password,
    required this.confirmPassword,
    this.name,
    this.age,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
      'name': name,
      'age': age,
    };
  }

  @override
  RegisterDto copyWith(Map<String, dynamic> changes) {
    return RegisterDto(
      email: changes['email'] ?? email,
      password: changes['password'] ?? password,
      confirmPassword: changes['confirmPassword'] ?? confirmPassword,
      name: changes['name'] ?? name,
      age: changes['age'] ?? age,
    );
  }

  @override
  bool get isValid => validationErrors.isEmpty;

  @override
  List<String> get validationErrors {
    final errors = <String>[];
    
    if (!ValidationRules.email.isValid(email)) {
      errors.add('Email inválido');
    }
    
    if (!ValidationRules.minLength(6).isValid(password)) {
      errors.add('Senha deve ter pelo menos 6 caracteres');
    }
    
    if (password != confirmPassword) {
      errors.add('Senhas não coincidem');
    }
    
    if (name != null && name!.trim().isEmpty) {
      errors.add('Nome não pode estar vazio');
    }
    
    if (age != null && !ValidationRules.range(13, 120).isValid(age)) {
      errors.add('Idade deve estar entre 13 e 120 anos');
    }
    
    return errors;
  }

  @override
  Map<String, List<ValidationRule>> get validationRules => {
    'email': [ValidationRules.required, ValidationRules.email],
    'password': [ValidationRules.required, ValidationRules.minLength(6)],
    'confirmPassword': [ValidationRules.required],
    'name': [ValidationRules.minLengthDefault],
    'age': [ValidationRules.range(13, 120)],
  };

  @override
  dynamic getFieldValue(String field) {
    switch (field) {
      case 'email':
        return email;
      case 'password':
        return password;
      case 'confirmPassword':
        return confirmPassword;
      case 'name':
        return name;
      case 'age':
        return age;
      default:
        return null;
    }
  }

  static RegisterDto fromMap(Map<String, dynamic> map) {
    return RegisterDto(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      confirmPassword: map['confirmPassword'] ?? '',
      name: map['name'],
      age: map['age'],
    );
  }

  @override
  String toString() {
    return 'RegisterDto(email: $email, name: $name, age: $age)';
  }
}

/// DTO para dados do usuário
class UserDto extends BaseDto with ValidationMixin {
  final String id;
  final String email;
  final String? name;
  final int? age;
  final String? avatarUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserDto({
    required this.id,
    required this.email,
    this.name,
    this.age,
    this.avatarUrl,
    this.createdAt,
    this.updatedAt,
  });

  /// Converte um User do Supabase para UserDto
  factory UserDto.fromSupabaseUser(User user) {
    return UserDto(
      id: user.id,
      email: user.email ?? '',
      name: user.userMetadata?['name'] as String?,
      age: user.userMetadata?['age'] as int?,
      avatarUrl: user.userMetadata?['avatar_url'] as String?,
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
      'age': age,
      'avatarUrl': avatarUrl,
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
      age: changes['age'] ?? age,
      avatarUrl: changes['avatarUrl'] ?? avatarUrl,
      createdAt: changes['createdAt'] != null 
          ? DateTime.parse(changes['createdAt']) 
          : createdAt,
      updatedAt: changes['updatedAt'] != null 
          ? DateTime.parse(changes['updatedAt']) 
          : updatedAt,
    );
  }

  @override
  bool get isValid => validationErrors.isEmpty;

  @override
  List<String> get validationErrors {
    final errors = <String>[];
    
    if (!ValidationRules.email.isValid(email)) {
      errors.add('Email inválido');
    }
    
    if (name != null && name!.trim().isEmpty) {
      errors.add('Nome não pode estar vazio');
    }
    
    if (age != null && !ValidationRules.range(13, 120).isValid(age)) {
      errors.add('Idade deve estar entre 13 e 120 anos');
    }
    
    return errors;
  }

  @override
  Map<String, List<ValidationRule>> get validationRules => {
    'id': [ValidationRules.required],
    'email': [ValidationRules.required, ValidationRules.email],
    'name': [ValidationRules.minLengthDefault],
    'age': [ValidationRules.range(13, 120)],
  };

  @override
  dynamic getFieldValue(String field) {
    switch (field) {
      case 'id':
        return id;
      case 'email':
        return email;
      case 'name':
        return name;
      case 'age':
        return age;
      default:
        return null;
    }
  }

  static UserDto fromMap(Map<String, dynamic> map) {
    return UserDto(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      name: map['name'],
      age: map['age'],
      avatarUrl: map['avatarUrl'],
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