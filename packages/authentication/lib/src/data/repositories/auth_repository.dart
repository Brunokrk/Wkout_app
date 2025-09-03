import "package:authentication/authentication.dart";
import 'package:authentication/src/data/dto/register_dto.dart';
import 'package:authentication/src/data/dto/user_dto.dart';
import 'package:wkout_core/wkout_core.dart';    

import '../data_source/auth_service.dart';
import '../../domain/models/user_model.dart';

/// Repository que transforma DTOs em Models
class AuthRepository implements IAuthRepository {
  final AuthService authService;

  AuthRepository({required this.authService});

 @override
 Future<UserModel?> register({
  required String email,
  required String password,
  required String name,
 }) async {
  return null;
 }
 
 @override
 Future<void> logout() async {
  return;
 }

 @override
 Future<UserModel?> login({required String email, required String password}) async {
  return null;
 }

 @override
 Future<UserModel?> updateUser({required UserModel user}) async {
  return null;
 }

}

  /// Login: Service retorna UserDto → Repository transforma em UserModel
  // @override
  // Future<UserModel> login(
  //     {required String email, required String password}) async {
  //   try {
  //     final userDto = await authService.login(
  //       email: email,
  //       password: password,
  //     );

  //     return _mapUserDtoToModel(userDto);
  //   } catch (e) {
  //     throw Exception('Erro no login: $e');
  //   }
  // }

  /// Register: Service retorna RegisterDto → Repository transforma em UserModel
  // @override
  // Future<UserModel?> register({
  //   required String email,
  //   required String password,
  //   //required String name,
  // }) async {
  //   try {
  //     final RegisterDto registerDto = await authService.register(
  //       email: email,
  //       password: password,
  //     );

  //     return UserModel.fromRegisterDto(registerDto);
  //     //UserModel.fromRegisterDto(registerDto);
  //   } catch (e) {
  //     throw Exception('Erro no registro: $e');
  //   }
  // }

  // @override
  // Future<void> logout() async {
  //   try {
  //     await authService.logout();
  //   } catch (e) {
  //     throw Exception('Erro no logout: $e');
  //   }
  // }

  // @override
  // Future<UserModel> updateUser({required UserModel user}) async {
  //   try {
  //     // Converter UserModel para UserDto para enviar ao service
  //     final userDto = UserDto(
  //       id: user.id,
  //       email: user.email,
  //       name: user.name,
  //       //age: user.age,
  //       createdAt: user.createdAt,
  //       updatedAt: user.updatedAt,
  //     );

  //     final updatedUserDto = await authService.updateUser(user: userDto);

  //     return _mapUserDtoToModel(updatedUserDto);
  //   } catch (e) {
  //     throw Exception('Erro ao atualizar usuário: $e');
  //   }
  // }
