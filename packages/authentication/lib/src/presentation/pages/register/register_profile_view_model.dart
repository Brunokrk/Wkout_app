import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:wkout_core/wkout_core.dart';
import '../../../domain/usecases/auth_usecase.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../services/image_picker_service.dart';

/// ViewModel que gerencia o estado da tela de registro de perfil
class RegisterProfileViewModel extends WkoutBaseViewModel {
  final AuthUseCase _authUseCase;
  
  // Controllers para os campos de texto
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
           phoneController.text.trim().isNotEmpty;
  }
  
  // Número de atividades selecionadas
  int get selectedActivitiesCount => selectedActivities.length;
  
  // Verifica se uma atividade está selecionada
  bool isActivitySelected(String activityName) {
    return selectedActivities.contains(activityName);
  }

  RegisterProfileViewModel({AuthUseCase? authUseCase})
      : _authUseCase = authUseCase ?? AuthUseCase(
          repository: AuthRepository(),
        );

  /// Seleciona uma imagem de perfil
  Future<void> selectProfileImage(BuildContext context) async {
    try {
      toggleScreenLoading();
      clearScreenError();

      final Uint8List? imageBytes = await ImagePickerService.showImageSourceDialog(context);
      
      if (imageBytes != null) {
        selectedProfileImage = imageBytes;
        notifyListeners();
      }
    } catch (e) {
      setScreenErrorText('Erro ao selecionar imagem: $e');
    } finally {
      toggleScreenLoading();
    }
  }

  /// Adiciona ou remove uma atividade da lista
  void toggleActivity(String activityName) {
    if (selectedActivities.contains(activityName)) {
      selectedActivities.remove(activityName);
    } else {
      selectedActivities.add(activityName);
    }
    notifyListeners();
  }

  /// Limpa a imagem de perfil selecionada
  void clearProfileImage() {
    selectedProfileImage = null;
    notifyListeners();
  }

  /// Valida e envia o formulário de registro
  Future<void> submitRegistration() async {
    try {
      if (!isFormValid) {
        setScreenErrorText('Por favor, preencha todos os campos obrigatórios.');
        return;
      }

      toggleScreenLoading();
      clearScreenError();

      // Aqui você pode implementar a lógica de envio para o backend
      // Por enquanto, vamos simular um delay
      await Future.delayed(const Duration(seconds: 2));

      // Exemplo de uso do AuthUseCase para atualizar o usuário
      await _authUseCase.updateUser(
        name: userNameController.text.trim(),
        // age: int.tryParse(ageController.text),
      );

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

  /// Obtém dados do usuário atual (se existir)
  Future<void> loadCurrentUserData() async {
    try {
      toggleScreenLoading();
      clearScreenError();

      // Carrega dados do usuário atual se estiver logado
      await _authUseCase.getCurrentUser();
      
      // Preenche os campos com dados existentes
      final currentUser = _authUseCase.currentUser;
      if (currentUser != null) {
        userNameController.text = currentUser.name ?? '';
        // phoneController.text = currentUser.phone ?? '';
        // bioController.text = currentUser.bio ?? '';
      }

      notifyListeners();
    } catch (e) {
      setScreenErrorText('Erro ao carregar dados do usuário: $e');
    } finally {
      toggleScreenLoading();
    }
  }

  @override
  void dispose() {
    userNameController.dispose();
    phoneController.dispose();
    bioController.dispose();
    super.dispose();
  }
} 