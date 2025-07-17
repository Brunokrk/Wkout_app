import "package:authentication/authentication.dart";
import 'package:wkout_core/wkout_core.dart';    

import '../data_source/auth_service.dart';
import '../dto/auth_dto.dart';
import '../../domain/models/user_model.dart';

/// Repository que transforma DTOs em Models
class AuthRepository implements IAuthRepository {
  final AuthService _authService;

  AuthRepository({AuthService? authService})
      : _authService = authService ?? AuthService();

  /// Transforma UserDto em UserModel
  UserModel _mapUserDtoToModel(UserDto dto) {
    return UserModel(
      id: dto.id,
      email: dto.email,
      name: dto.name,
      age: dto.age,
      avatarUrl: dto.avatarUrl,
      createdAt: dto.createdAt,
      updatedAt: dto.updatedAt,
    );
  }

  /// Login: Service retorna UserDto → Repository transforma em UserModel
  @override
  Future<UserModel> login(
      {required String email, required String password}) async {
    try {
      final userDto = await _authService.login(
        email: email,
        password: password,
      );

      return _mapUserDtoToModel(userDto);
    } catch (e) {
      throw Exception('Erro no login: $e');
    }
  }

  /// Register: Service retorna UserDto → Repository transforma em UserModel
  @override
  Future<UserModel> register({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final userDto = await _authService.register(
        email: email,
        password: password,
        name: name,
      );

      return _mapUserDtoToModel(userDto);
    } catch (e) {
      throw Exception('Erro no registro: $e');
    }
  }

  /// Get Current User: Service retorna UserDto → Repository transforma em UserModel
  @override
  Future<UserModel> getCurrentUser() async {
    try {
      final userDto = await _authService.getCurrentUser();

      if (userDto != null) {
        return _mapUserDtoToModel(userDto);
      }
      throw Exception('Usuário não encontrado');
    } catch (e) {
      throw Exception('Erro ao obter usuário atual: $e');
    }
  }

  /// Logout: Service retorna void → Repository retorna void
  @override
  Future<void> logout() async {
    try {
      await _authService.logout();
    } catch (e) {
      throw Exception('Erro no logout: $e');
    }
  }

  /// Update User: Service retorna UserDto → Repository transforma em UserModel
  @override
  Future<UserModel> updateUser({required UserModel user}) async {
    try {
      // Converter UserModel para UserDto para enviar ao service
      final userDto = UserDto(
        id: user.id,
        email: user.email,
        name: user.name,
        age: user.age,
        avatarUrl: user.avatarUrl,
        createdAt: user.createdAt,
        updatedAt: user.updatedAt,
      );

      final updatedUserDto = await _authService.updateUser(user: userDto);

      return _mapUserDtoToModel(updatedUserDto);
    } catch (e) {
      throw Exception('Erro ao atualizar usuário: $e');
    }
  }
}
