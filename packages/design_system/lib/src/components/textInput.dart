import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

enum InputType {
  email,
  password,
  phone,
  name,
  genericPrefixIcon,
}

class CustomTextInput extends StatelessWidget {
  final String label;
 
  final TextEditingController controller;
  final InputType? inputType;
  final IconData? prefixIcon;

  const CustomTextInput({
    required this.label,
   
    required this.controller,
    this.inputType,
    this.prefixIcon,
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
      case InputType.genericPrefixIcon:
        return _buildGenericPrefixIconInput();
      default:
        return _buildDefaultInput();
    }
  }

  Widget _buildGenericPrefixIconInput() {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        icon: Icon(prefixIcon),
      ),
    );
  }

  Widget _buildEmailInput() {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        icon: Icon(Icons.email),       
        fillColor: AppColors.backgroundLight,
        filled: true,
        constraints: BoxConstraints(minHeight: 40, maxHeight: 40),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      ),
    );
  }

  Widget _buildPasswordInput() {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        icon: Icon(Icons.password),
        fillColor: AppColors.backgroundLight,
        filled: true,
        constraints: BoxConstraints(maxHeight: 40),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      ),
    );
  }

  Widget _buildDefaultInput() {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: AppColors.backgroundLight,
        filled: true,
        constraints: BoxConstraints(maxHeight: 40),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      ),
    );
  }

  Widget _buildPhoneInput() {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        icon: Icon(Icons.phone),
        fillColor: AppColors.backgroundLight,
        filled: true,
        constraints: BoxConstraints(maxHeight: 40),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      ),
    );
  }

  Widget _buildNameInput() {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        icon: Icon(Icons.person),
        fillColor: AppColors.backgroundLight,
        filled: true,
        constraints: BoxConstraints(maxHeight: 40),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      ),
    );
  }
}
