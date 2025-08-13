
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

  bool get isFormValid {
    return emailController.text.trim().isNotEmpty &&
           passwordController.text.trim().isNotEmpty &&
           confirmPasswordController.text.trim().isNotEmpty &&
           nameController.text.trim().isNotEmpty &&
           phoneController.text.trim().isNotEmpty &&
           birthDateController.text.trim().isNotEmpty &&
           passwordController.text == confirmPasswordController.text;
  }
  
  RegisterPasswordViewModel({AuthUseCase? authUseCase})
      : authUseCase = authUseCase ?? AuthUseCase(
          repository: AuthRepository(authService: WkoutInjector.I.get<AuthService>()),
        );

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
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    birthDateController.dispose();
    super.dispose();
  }
} 