import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum InputType {
  email,
  password,
  phone,
  name,
  genericPrefixIcon,
  largeTextInput,
  date,
}

class CustomTextInput extends StatefulWidget {
  final String label;

  final TextEditingController controller;
  final InputType? inputType;
  final IconData? prefixIcon;
  final bool? haveInformation;
  final String? information;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;

  const CustomTextInput({
    required this.label,
    required this.controller,
    this.inputType,
    this.prefixIcon,
    this.haveInformation,
    this.information,
    this.validator,
    this.autovalidateMode,
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
      case InputType.date:
        return _buildDateInput();
      default:
        return _buildDefaultInput();
    }
  }

  Widget _buildGenericPrefixIconInput() {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      autovalidateMode: widget.autovalidateMode,
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
      validator: widget.validator,
      autovalidateMode: widget.autovalidateMode,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        labelText: widget.label,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        icon: Icon(Icons.email),
        fillColor: AppColors.backgroundLight,
        filled: true,
        constraints:
            (widget.validator != null || widget.autovalidateMode != null)
                ? null
                : BoxConstraints(minHeight: 40, maxHeight: 40),
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
      validator: widget.validator,
      autovalidateMode: widget.autovalidateMode,
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        labelText: widget.label,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        icon: Icon(Icons.password),
        fillColor: AppColors.backgroundLight,
        filled: true,
        constraints:
            (widget.validator != null || widget.autovalidateMode != null)
                ? null
                : BoxConstraints(maxHeight: 40),
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
      validator: widget.validator,
      autovalidateMode: widget.autovalidateMode,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        labelText: widget.label,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: AppColors.backgroundLight,
        filled: true,
        constraints:
            (widget.validator != null || widget.autovalidateMode != null)
                ? null
                : BoxConstraints(maxHeight: 40),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      ),
    );
  }

  Widget _buildPhoneInput() {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      autovalidateMode: widget.autovalidateMode,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        labelText: widget.label,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        icon: Icon(Icons.phone),
        fillColor: AppColors.backgroundLight,
        filled: true,
        constraints: (widget.validator != null || widget.autovalidateMode != null)
            ? null
            : BoxConstraints( maxHeight: 40),
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

  Widget _buildNameInput() {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      autovalidateMode: widget.autovalidateMode,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        labelText: widget.label,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        icon: Icon(Icons.person),
        fillColor: AppColors.backgroundLight,
        filled: true,
        constraints:
            (widget.validator != null || widget.autovalidateMode != null)
                ? null
                : BoxConstraints(maxHeight: 40),
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
      validator: widget.validator,
      autovalidateMode: widget.autovalidateMode,
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
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
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

  Widget _buildDateInput() {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      autovalidateMode: widget.autovalidateMode,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        _DateInputFormatter(),
      ],
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        labelText: widget.label,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        icon: Icon(Icons.calendar_month),
        fillColor: AppColors.backgroundLight,
        filled: true,
        constraints:
            (widget.validator != null || widget.autovalidateMode != null)
                ? null
                : BoxConstraints(minHeight: 40, maxHeight: 40),
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
}

class _DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Remove todos os caracteres não numéricos
    final text = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
    
    if (text.isEmpty) {
      return newValue.copyWith(text: '');
    }
    
    // Aplica a máscara DD/MM/AAAA
    String formattedText = '';
    
    if (text.length <= 2) {
      formattedText = text;
    } else if (text.length <= 4) {
      formattedText = '${text.substring(0, 2)}/${text.substring(2)}';
    } else if (text.length <= 8) {
      formattedText = '${text.substring(0, 2)}/${text.substring(2, 4)}/${text.substring(4)}';
    } else {
      // Limita a 8 dígitos (DDMMAAAA)
      formattedText = '${text.substring(0, 2)}/${text.substring(2, 4)}/${text.substring(4, 8)}';
    }
    
    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
