
import 'package:authentication/src/presentation/parameters/register_profile_parameters.dart';
import 'package:flutter/material.dart';
import 'package:wkout_core/injector/wkout_injector.dart';
import 'package:wkout_core/wkout_core.dart';
import '../../../data/data_source/auth_service.dart';
import '../../../domain/usecases/auth_usecase.dart';
import '../../../data/repositories/auth_repository.dart';

/// ViewModel que gerencia o estado da tela de registro de senha e mais informações
class RegisterPasswordViewModel extends WkoutBaseViewModel {
  final AuthUseCase authUseCase;
  
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();

  late RegisterProfileParameters registrationParameters;

  RegisterPasswordViewModel({AuthUseCase? authUseCase})
      : authUseCase = authUseCase ?? AuthUseCase(
          repository: AuthRepository(authService: WkoutInjector.I.get<AuthService>()),
        ) {
    // Adicionar listeners para atualizar o estado quando os campos mudarem
    emailController.addListener(_onFieldChanged);
    passwordController.addListener(_onFieldChanged);
    confirmPasswordController.addListener(_onFieldChanged);
    nameController.addListener(_onFieldChanged);
    phoneController.addListener(_onFieldChanged);
    birthDateController.addListener(_onFieldChanged);
  }

  void _onFieldChanged() {
    notifyListeners();
  }

  bool get isFormValid {
    return _validateEmail() == null &&
           _validatePassword() == null &&
           _validateConfirmPassword() == null &&
           _validateName() == null &&
           _validatePhone() == null &&
           _validateBirthDate() == null;
  }

  String? _validateEmail() {
    return Validators.email()(emailController.text);
  }

  String? _validatePassword() {
    return Validators.password()(passwordController.text);
  }

  String? _validateConfirmPassword() {
    if (confirmPasswordController.text.isEmpty) {
      return 'Confirme sua senha';
    }
    if (confirmPasswordController.text != passwordController.text) {
      return 'As senhas não coincidem';
    }
    return null;
  }

  String? _validateName() {
    return Validators.fullName()(nameController.text);
  }

  String? _validatePhone() {
    return Validators.required(message: 'Informe seu número de telefone')(phoneController.text);
  }

  String? _validateBirthDate() {
    return Validators.birthDate()(birthDateController.text);
  }

  /// Valida todos os campos e retorna uma lista de erros
  List<String> validateAllFields() {
    final errors = <String>[];
    
    final emailError = _validateEmail();
    if (emailError != null) errors.add(emailError);
    
    final passwordError = _validatePassword();
    if (passwordError != null) errors.add(passwordError);
    
    final confirmPasswordError = _validateConfirmPassword();
    if (confirmPasswordError != null) errors.add(confirmPasswordError);
    
    final nameError = _validateName();
    if (nameError != null) errors.add(nameError);
    
    final phoneError = _validatePhone();
    if (phoneError != null) errors.add(phoneError);
    
    final birthDateError = _validateBirthDate();
    if (birthDateError != null) errors.add(birthDateError);
    
    return errors;
  }

  /// Limpa todos os campos do formulário
  void clearForm() {
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    nameController.clear();
    phoneController.clear();
    birthDateController.clear();
    clearScreenError();
    notifyListeners();
  }

  bool setRegistrationParameters(){
    registrationParameters = RegisterProfileParameters(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      name: nameController.text.trim(),
      phone: phoneController.text.trim(),
      birthDate: birthDateController.text.trim(),
    );
    return registrationParameters.isValid;
  }

  RegisterProfileParameters getRegistrationParameters(){
    setRegistrationParameters();
    return registrationParameters;
  }

  @override
  void dispose() {
    emailController.removeListener(_onFieldChanged);
    passwordController.removeListener(_onFieldChanged);
    confirmPasswordController.removeListener(_onFieldChanged);
    nameController.removeListener(_onFieldChanged);
    phoneController.removeListener(_onFieldChanged);
    birthDateController.removeListener(_onFieldChanged);
    
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    birthDateController.dispose();
    super.dispose();
  }
} 