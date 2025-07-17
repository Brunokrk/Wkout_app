import 'package:wkout_core/wkout_core.dart';

import '../../../domain/models/user_model.dart';
import '../../../domain/usecases/auth_usecase.dart';
import '../../../data/repositories/auth_repository.dart';

/// ViewModel que gerencia o estado da tela de autenticação
/// Usa uma única AuthUseCase para todas as operações
class AuthHomeViewModel extends WkoutBaseViewModel {
  final AuthUseCase _authUseCase;

  AuthHomeViewModel({AuthUseCase? authUseCase})
      : _authUseCase = authUseCase ?? AuthUseCase(
          repository: AuthRepository(),
        );

  UserModel? get user => _authUseCase.currentUser;

  bool get isRed => _authUseCase.isRed;

  bool get isAuthenticated => _authUseCase.isAuthenticated;

  String get displayName => _authUseCase.displayName;

  bool get hasName => _authUseCase.hasName;

  bool get hasAvatar => _authUseCase.hasAvatar;

  String? get avatarUrl => _authUseCase.avatarUrl;

  void toggleRed() {
    _authUseCase.isRed = !_authUseCase.isRed;
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    try {
      toggleScreenLoading();
      clearScreenError();

      // AuthUseCase executa todas as regras de negócio
      await _authUseCase.login(
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
  Future<void> register({
    required String email,
    required String password,
    required String name,
    int? age,
  }) async {
    try {
      toggleScreenLoading();
      clearScreenError();

      // AuthUseCase executa todas as regras de negócio
      await _authUseCase.register(
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

  /// Obtém usuário atual usando a AuthUseCase
  Future<void> getCurrentUser() async {
    try {
      toggleScreenLoading();
      clearScreenError();

      // AuthUseCase executa todas as regras de negócio
      await _authUseCase.getCurrentUser();

      notifyListeners();
    } catch (e) {
      setScreenErrorText(e.toString());
    } finally {
      toggleScreenLoading();
    }
  }

  /// Executa logout usando a AuthUseCase
  Future<void> logout() async {
    try {
      toggleScreenLoading();
      clearScreenError();

      // AuthUseCase executa todas as regras de negócio
      await _authUseCase.logout();

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
      await _authUseCase.updateUser(
        name: name,
        age: age,
        avatarUrl: avatarUrl,
      );

      notifyListeners();
    } catch (e) {
      setScreenErrorText(e.toString());
    } finally {
      toggleScreenLoading();
    }
  }
}