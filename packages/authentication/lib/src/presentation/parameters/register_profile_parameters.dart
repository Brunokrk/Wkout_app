import 'dart:convert';
import 'package:wkout_core/wkout_core.dart';

class RegisterProfileParameters extends WkoutBaseParameters {
  final String? email;
  final String? password;
  final String? name;
  final String? phone;
  final String? birthDate;

  RegisterProfileParameters({
    this.email,
    this.password,
    this.name,
    this.phone,
    this.birthDate,
  });
  

  @override
  String toExtra() {
    return jsonEncode({
      'email': email,
      'password': password,
      'name': name,
      'phone': phone,
      'birthDate': birthDate,
    });
  }

  @override
  RegisterProfileParameters fromExtra(Object? extra) {
    final Map<String, dynamic> map = jsonDecode(extra.toString());
    return RegisterProfileParameters(
      email: map['email'],
      password: map['password'],
      name: map['name'],
      phone: map['phone'],
      birthDate: map['birthDate'],
    );
  }

  @override
  bool get isValid {
    return (email?.isNotEmpty ?? false) &&
           (password?.isNotEmpty ?? false) &&
           (name?.isNotEmpty ?? false) &&
           (phone?.isNotEmpty ?? false) &&
           (birthDate?.isNotEmpty ?? false);  
  }

  @override
  String toString() {
    return 'RegisterProfileParameters(email: $email, name: $name, phone: $phone, birthDate: $birthDate)';
  }
}