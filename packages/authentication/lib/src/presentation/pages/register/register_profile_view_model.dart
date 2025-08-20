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
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  
  // Estado da imagem de perfil
  Uint8List? selectedProfileImage;
  
  // Lista de atividades selecionadas
  final List<String> selectedActivities = [];
  
  // Validação de campos
  bool get isFormValid {
    return userNameController.text.trim().isNotEmpty &&
           phoneController.text.trim().isNotEmpty &&
           selectedActivities.isNotEmpty &&
           selectedActivities.length <= 6;
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

  RegisterProfileViewModel({
    AuthUseCase? authUseCase,
    this.parameters,
  }) : authUseCase = authUseCase ?? AuthUseCase(
          repository: AuthRepository(authService: WkoutInjector.I.get<AuthService>()),
        ) ;


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
        setScreenErrorText('Você pode selecionar no máximo 6 atividades.');
        return;
      }
      selectedActivities.add(activityName);
      clearScreenError(); // Limpa erro anterior se houver
    }
    notifyListeners();
  }

  void clearProfileImage() {
    selectedProfileImage = null;
    notifyListeners();
  }


  Future<void> submitRegistration() async {
    try {
      // Validação específica para atividades
      if (!hasMinimumActivities) {
        setScreenErrorText('Selecione pelo menos uma atividade favorita.');
        return;
      }
      
      if (selectedActivities.length > 6) {
        setScreenErrorText('Você pode selecionar no máximo 6 atividades.');
        return;
      }

      if (!isFormValid) {
        setScreenErrorText('Por favor, preencha todos os campos obrigatórios.');
        return;
      }

      if (parameters == null) {
        setScreenErrorText('Parâmetros de registro não encontrados.');
        return;
      }

      toggleScreenLoading();
      clearScreenError();

      /// TO-DO: Envio backend
      
      notifyListeners();
    } catch (e) {
      setScreenErrorText('Erro ao cadastrar perfil: $e');
    } finally {
      toggleScreenLoading();
    }
  }

  /// Limpa todos os campos do formulário
  void clearForm() {
    userNameController.clear();
    phoneController.clear();
    bioController.clear();
    selectedProfileImage = null;
    selectedActivities.clear();
    clearScreenError();
    notifyListeners();
  }


  @override
  void dispose() {
    userNameController.dispose();
    phoneController.dispose();
    bioController.dispose();
    super.dispose();
  }
} 