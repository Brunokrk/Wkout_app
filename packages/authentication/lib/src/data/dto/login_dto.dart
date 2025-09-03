import 'package:wkout_core/wkout_core.dart';

class LoginDto extends BaseDto{
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
