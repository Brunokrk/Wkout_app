import 'package:authentication/src/presentation/enum/authSteps.dart';
import 'package:wkout_core/wkout_core.dart';

import '../../../domain/models/user_model.dart';
import '../../../domain/usecases/auth_usecase.dart';
import '../../../data/repositories/auth_repository.dart';

/// ViewModel que gerencia o estado da tela de autenticação
class AuthHomeViewModel extends WkoutBaseViewModel {
  final AuthUseCase authUseCase;
  AuthSteps authStep = AuthSteps.initial;

  AuthHomeViewModel({required this.authUseCase});

  UserModel? get user => authUseCase.currentUser;

  bool get isRed => authUseCase.isRed;

  bool get isAuthenticated => authUseCase.isAuthenticated;

  String get displayName => authUseCase.displayName;

  bool get hasName => authUseCase.hasName;

  void toggleRed() {
    authUseCase.isRed = !authUseCase.isRed;
    notifyListeners();
  }

  Future<void> makeLogin(String email, String password) async {
    try {
      toggleScreenLoading();
      clearScreenError();

      // AuthUseCase executa todas as regras de negócio
      await authUseCase.login(
        email: email,
        password: password,
      );

      notifyListeners();
    } catch (e) {
      setScreenErrorText(e.toString());
    } finally {
      toggleScreenLoading();
    }
  }

  /// Executa registro usando a AuthUseCase
  Future<void> makeRegister({
    required String email,
    required String password,
    required String name,
    int? age,
  }) async {
    try {
      toggleScreenLoading();
      clearScreenError();

      await authUseCase.register(
        email: email,
        password: password,
        name: name,
        age: age,
      );

      notifyListeners();
    } catch (e) {
      setScreenErrorText(e.toString());
    } finally {
      toggleScreenLoading();
    }
  }

  /// Alterna o passo de autenticação
  void toggleAuthStep(AuthSteps step) {
    authStep = step;
    notifyListeners();
  }


  /// Executa logout usando a AuthUseCase
  Future<void> logout() async {
    try {
      toggleScreenLoading();
      clearScreenError();

      // AuthUseCase executa todas as regras de negócio
      await authUseCase.logout();

      notifyListeners();
    } catch (e) {
      setScreenErrorText(e.toString());
    } finally {
      toggleScreenLoading();
    }
  }

  /// Atualiza usuário usando a AuthUseCase
  Future<void> updateUser({
    String? name,
    int? age,
    String? avatarUrl,
  }) async {
    try {
      toggleScreenLoading();
      clearScreenError();

      // AuthUseCase executa todas as regras de negócio
      await authUseCase.updateUser(
        name: name,
        age: age,
      );

      notifyListeners();
    } catch (e) {
      setScreenErrorText(e.toString());
    } finally {
      toggleScreenLoading();
    }
  }

  @override
  void dispose() {
    // Garantir que o ViewModel seja descartado corretamente
    super.dispose();
  }
}