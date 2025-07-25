/// Model que representa a entidade de domínio do usuário
class UserModel {
  final String id;
  final String email;
  final String? name;
  final int? age;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserModel({
    required this.id,
    required this.email,
    this.name,
    this.age,
    this.createdAt,
    this.updatedAt,
  });

  /// Cria uma cópia do model com modificações
  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    int? age,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      age: age ?? this.age,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Converte o model para Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'age': age,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  /// Cria um model a partir de um Map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      name: map['name'],
      age: map['age'],
      createdAt: map['createdAt'] != null 
          ? DateTime.parse(map['createdAt']) 
          : null,
      updatedAt: map['updatedAt'] != null 
          ? DateTime.parse(map['updatedAt']) 
          : null,
    );
  }

  /// Verifica se o usuário tem dados básicos válidos
  bool get isValid => id.isNotEmpty && email.isNotEmpty;

  /// Verifica se o usuário tem nome
  bool get hasName => name != null && name!.isNotEmpty;

  /// Obtém o nome de exibição (nome ou email)
  String get displayName => name?.isNotEmpty == true ? name! : email;

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
} 