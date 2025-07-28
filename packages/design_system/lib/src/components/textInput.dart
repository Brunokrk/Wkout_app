import 'package:flutter/material.dart';

enum InputType {
  email,
  password,
  phone,
  name,
}

class CustomTextInput extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final InputType? inputType;

  const CustomTextInput({
    required this.label,
    required this.hint,
    required this.controller,
    this.inputType,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    switch (inputType) {
      case InputType.email:
        return _buildEmailInput();
      case InputType.password:
        return _buildPasswordInput();
      case InputType.phone:
        return _buildPhoneInput();
      case InputType.name:
        return _buildNameInput();
      default:
        return _buildDefaultInput();
    }
  }

  Widget _buildEmailInput() {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        labelText: label,
        icon: Icon(Icons.email),
        hintText: hint,
      ),
    );
  }

  Widget _buildPasswordInput() {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        labelText: label,
        icon: Icon(Icons.password),
        hintText: hint,
      ),
    );
  }

  Widget _buildDefaultInput() {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        labelText: label,
        hintText: hint,
      ),
    );
  }

  Widget _buildPhoneInput() {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        labelText: label,
        icon: Icon(Icons.phone),
        hintText: hint,
      ),
    );
  }

  Widget _buildNameInput() {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        labelText: label,
        icon: Icon(Icons.person),
        hintText: hint,
      ),
    );
  }
}