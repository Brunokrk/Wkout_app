import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:wkout_core/injector/wkout_injector.dart';
import 'package:wkout_core/wkout_core.dart';
import '../../../data/data_source/auth_service.dart';
import '../../../domain/usecases/auth_usecase.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../parameters/register_profile_parameters.dart';

/// ViewModel que gerencia o estado da tela de registro de perfil
class RegisterProfileViewModel extends WkoutBaseViewModel {
  final AuthUseCase authUseCase;
  final RegisterProfileParameters? parameters;
  
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  
  // Estado da imagem de perfil
  Uint8List? selectedProfileImage;
  
  // Lista de atividades selecionadas
  final List<String> selectedActivities = [];
  
  RegisterProfileViewModel({
    AuthUseCase? authUseCase,
    this.parameters,
  }) : authUseCase = authUseCase ?? AuthUseCase(
          repository: AuthRepository(authService: WkoutInjector.I.get<AuthService>()),
        ) {
    // Adicionar listeners para atualizar o estado quando os campos mudarem
    userNameController.addListener(_onFieldChanged);
    bioController.addListener(_onFieldChanged);
  }

  void _onFieldChanged() {
    notifyListeners();
  }
  
  // Validação de campos
  bool get isFormValid {
    return validateUserName() == null &&
           validateBio() == null &&
           validateActivities() == null;
  }
  
  // Validação individual de campos
  String? validateUserName() {
    if (userNameController.text.trim().isEmpty) {
      return 'Nome de usuário é obrigatório';
    }
    return null;
  }
  
  String? validateBio() {
    if (bioController.text.trim().isEmpty) {
      return 'Biografia é obrigatória';
    }
    return null;
  }
  
  String? validateActivities() {
    if (selectedActivities.isEmpty) {
      return 'Selecione pelo menos uma atividade';
    }
    if (selectedActivities.length > 6) {
      return 'Máximo de 6 atividades permitidas';
    }
    return null;
  }
  
  /// Valida todos os campos e retorna uma lista de erros
  List<String> validateAllFields() {
    final errors = <String>[];
    
    final userNameError = validateUserName();
    if (userNameError != null) errors.add(userNameError);
    
    final bioError = validateBio();
    if (bioError != null) errors.add(bioError);
    
    final activitiesError = validateActivities();
    if (activitiesError != null) errors.add(activitiesError);
    
    return errors;
  }
  
  // Número de atividades selecionadas
  int get selectedActivitiesCount => selectedActivities.length;
  
  // Verifica se uma atividade está selecionada
  bool isActivitySelected(String activityName) {
    return selectedActivities.contains(activityName);
  }
  
  // Verifica se pode selecionar mais atividades
  bool get canSelectMoreActivities => selectedActivities.length < 6;
  
  // Verifica se tem pelo menos uma atividade selecionada
  bool get hasMinimumActivities => selectedActivities.isNotEmpty;
  
  // Getter para acessar os dados dos parâmetros
  String get email => parameters?.email ?? '';
  String get password => parameters?.password ?? '';
  String get name => parameters?.name ?? '';
  String get phone => parameters?.phone ?? '';
  String get birthDate => parameters?.birthDate ?? '';

  /// Atualiza a imagem de perfil vinda da UI
  void setProfileImage(Uint8List? imageBytes) {
    selectedProfileImage = imageBytes;
    notifyListeners();
  }

  /// muda status de um chip
  void toggleActivity(String activityName) {
    if (selectedActivities.contains(activityName)) {
      selectedActivities.remove(activityName);
    } else {
      // Verifica se já atingiu o limite máximo de 6 atividades
      if (selectedActivities.length >= 6) {
        return;
      }
      selectedActivities.add(activityName);
    }
    notifyListeners();
  }

  void clearProfileImage() {
    selectedProfileImage = null;
    notifyListeners();
  }

  Future<bool> submitRegistration() async {
    try {
      if (parameters == null) {
        return false;
      }

      toggleScreenLoading();

      /// TO-DO: Envio backend
      
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    } finally {
      if (screenLoading) {
        toggleScreenLoading();
      }
    }
  }

  /// Limpa todos os campos do formulário
  void clearForm() {
    userNameController.clear();
    bioController.clear();
    selectedProfileImage = null;
    selectedActivities.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    userNameController.removeListener(_onFieldChanged);
    bioController.removeListener(_onFieldChanged);
    
    userNameController.dispose();
    bioController.dispose();
    super.dispose();
  }
} 