import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

enum InputType {
  email,
  password,
  phone,
  name,
  genericPrefixIcon,
  largeTextInput,
}

class CustomTextInput extends StatefulWidget {
  final String label;

  final TextEditingController controller;
  final InputType? inputType;
  final IconData? prefixIcon;
  final bool? haveInformation;
  final String? information;

  const CustomTextInput({
    required this.label,
    required this.controller,
    this.inputType,
    this.prefixIcon,
    this.haveInformation,
    this.information,
    super.key,
  });

  @override
  State<CustomTextInput> createState() => _CustomTextInputState();
}

class _CustomTextInputState extends State<CustomTextInput> {
  final GlobalKey<TooltipState> tooltipKey = GlobalKey<TooltipState>();

  @override
  Widget build(BuildContext context) {
    switch (widget.inputType) {
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
      case InputType.largeTextInput:
        return _buildLargeTextInput();
      default:
        return _buildDefaultInput();
    }
  }

  Widget _buildGenericPrefixIconInput() {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        labelText: widget.label,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        icon: Icon(widget.prefixIcon),
        suffixIcon: widget.haveInformation == true
            ? InfoTooltip(
                message: widget.information ?? "",
                iconSize: 20,
              )
            : null,
      ),
    );
  }

  Widget _buildEmailInput() {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        labelText: widget.label,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        icon: Icon(Icons.email),
        fillColor: AppColors.backgroundLight,
        filled: true,
        constraints: BoxConstraints(minHeight: 40, maxHeight: 40),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        suffixIcon: widget.haveInformation == true
            ? InfoTooltip(
                message: widget.information ?? "",
                iconSize: 20,
              )
            : null,
      ),
    );
  }

  Widget _buildPasswordInput() {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        labelText: widget.label,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        icon: Icon(Icons.password),
        fillColor: AppColors.backgroundLight,
        filled: true,
        constraints: BoxConstraints(maxHeight: 40),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        suffixIcon: widget.haveInformation == true
            ? InfoTooltip(
                message: widget.information ?? "",
                iconSize: 20,
              )
            : null,
      ),
    );
  }

  Widget _buildDefaultInput() {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        labelText: widget.label,
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
      controller: widget.controller,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        labelText: widget.label,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        icon: Icon(Icons.phone),
        fillColor: AppColors.backgroundLight,
        filled: true,
        //constraints: BoxConstraints(maxHeight: 40),
        //contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        suffixIcon: widget.haveInformation == true
            ? InfoTooltip(
                message: widget.information ?? "",
                iconSize: 20,
              )
            : null,
      ),
    );
  }

  Widget _buildNameInput() {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        labelText: widget.label,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        icon: Icon(Icons.person),
        fillColor: AppColors.backgroundLight,
        filled: true,
        constraints: BoxConstraints(maxHeight: 40),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        suffixIcon: widget.haveInformation == true
            ? InfoTooltip(
                message: widget.information ?? "",
                iconSize: 20,
              )
            : null,
      ),
    );
  }

  Widget _buildLargeTextInput() {
    return TextFormField(
      controller: widget.controller,
      maxLines: 4,
      minLines: 3,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        labelText: widget.label,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        fillColor: AppColors.backgroundLight,
        filled: true,
        icon: Icon(widget.prefixIcon),
        alignLabelWithHint: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        suffixIcon: widget.haveInformation == true
            ? Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: InfoTooltip(
                  message: widget.information ?? "",
                  iconSize: 20,
                ),
              )
            : null,
      ),
    );
  }
}
