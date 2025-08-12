import 'package:authentication/authentication.dart';
import 'package:wkout_core/wkout_core.dart';

import '../models/user_model.dart';
import '../../data/repositories/auth_repository.dart';

class AuthUseCase extends WkoutBaseService {
  final IAuthRepository repository;

    AuthUseCase({required this.repository});

  // Estado do usuário
  UserModel? _currentUser;

  bool isRed = true;

  /// Obtém o usuário atual
  UserModel? get currentUser => _currentUser;

  /// Verifica se o usuário está autenticado
  bool get isAuthenticated => _currentUser != null && _currentUser!.isValid;

  /// Obtém o nome de exibição do usuário
  String get displayName => _currentUser?.displayName ?? 'Usuário';

  /// Executa login com validações de negócio
  Future<void> login({required String email, required String password}) async {
    try {
      // Regras de negócio para login
      _validateLoginData(email: email, password: password);

      // Executar login via repository
      final user = await repository.login(
        email: email.trim(),
        password: password,
      );

      // Regras de negócio pós-login
      _validateUserAfterLogin(user);

      // Atualizar estado
      _currentUser = user;
    } catch (e) {
      throw handleException(exception: e);
    }
  }

  /// Executa registro com validações de negócio
  Future<void> register({
    required String email,
    required String password,
    required String name,
    int? age,
  }) async {
    try {
      // Regras de negócio para registro
      _validateRegisterData(
        email: email,
        password: password,
        name: name,
        age: age,
      );

      // Executar registro via repository
      final user = await repository.register(
        email: email.trim(),
        password: password,
        name: name.trim(),
      );

      // Regras de negócio pós-registro
      _validateUserAfterRegister(user);

      // Atualizar estado
      _currentUser = user;
    } catch (e) {
      throw handleException(exception: e);
    }
  }


  /// Executa logout
  Future<void> logout() async {
    try {
      await repository.logout();
      _currentUser = null; // Limpar estado
    } catch (e) {
      throw handleException(exception: e);
    }
  }

  /// Atualiza dados do usuário
  Future<void> updateUser({
    String? name,
    int? age,
  }) async {
    if (_currentUser == null) {
      throw Exception('Usuário não autenticado');
    }

    try {
      // Regras de negócio para atualização
      _validateUpdateData(name: name, age: age);

      // Criar cópia do usuário com as modificações
      final updatedUser = _currentUser!.copyWith(
        name: name,
        age: age,
      );

      // Executar atualização via repository
      final user = await repository.updateUser(user: updatedUser);
      
      // Regras de negócio pós-atualização
      _validateUserAfterUpdate(user);

      // Atualizar estado
      _currentUser = user;
    } catch (e) {
      throw handleException(exception: e);
    }
  }

  /// Valida dados de login
  void _validateLoginData({required String email, required String password}) {
    if (email.trim().isEmpty) {
      throw Exception('Email é obrigatório');
    }

    if (password.trim().isEmpty) {
      throw Exception('Senha é obrigatória');
    }

    if (password.length < 6) {
      throw Exception('Senha deve ter pelo menos 6 caracteres');
    }

    // Validar formato do email
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      throw Exception('Email inválido');
    }
  }

  /// Valida dados de registro
  void _validateRegisterData({
    required String email,
    required String password,
    required String name,
    int? age,
  }) {
    if (email.trim().isEmpty) {
      throw Exception('Email é obrigatório');
    }

    if (password.trim().isEmpty) {
      throw Exception('Senha é obrigatória');
    }

    if (password.length < 6) {
      throw Exception('Senha deve ter pelo menos 6 caracteres');
    }

    if (name.trim().isEmpty) {
      throw Exception('Nome é obrigatório');
    }

    if (name.length < 2) {
      throw Exception('Nome deve ter pelo menos 2 caracteres');
    }

    // Validar formato do email
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      throw Exception('Email inválido');
    }

    // Validar idade se fornecida
    if (age != null && (age < 13 || age > 120)) {
      throw Exception('Idade deve estar entre 13 e 120 anos');
    }
  }

  /// Valida dados de atualização
  void _validateUpdateData({String? name, int? age}) {
    if (name != null && name.trim().isEmpty) {
      throw Exception('Nome não pode estar vazio');
    }

    if (name != null && name.length < 2) {
      throw Exception('Nome deve ter pelo menos 2 caracteres');
    }

    if (age != null && (age < 13 || age > 120)) {
      throw Exception('Idade deve estar entre 13 e 120 anos');
    }
  }

  /// Valida usuário após login
  void _validateUserAfterLogin(UserModel user) {
    if (!user.isValid) {
      throw Exception('Dados do usuário inválidos');
    }
  }

  /// Valida usuário após registro
  void _validateUserAfterRegister(UserModel user) {
    if (!user.isValid) {
      throw Exception('Dados do usuário inválidos');
    }
  }

  /// Valida usuário após atualização
  void _validateUserAfterUpdate(UserModel user) {
    if (!user.isValid) {
      throw Exception('Dados do usuário atualizado são inválidos');
    }
  }

  /// Limpa o estado do usuário (útil para testes)
  void clearUser() {
    _currentUser = null;
  }

  /// Verifica se o usuário tem nome
  bool get hasName => _currentUser?.hasName ?? false;


} 