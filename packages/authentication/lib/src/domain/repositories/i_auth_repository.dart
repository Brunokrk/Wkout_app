import 'package:authentication/src/domain/models/user_model.dart';

abstract class IAuthRepository {
  Future<UserModel> login({required String email, required String password});
  Future<UserModel> register({
    required String email,
    required String password,
    required String name,
  });
  
  Future<void> logout();
  Future<UserModel> updateUser({required UserModel user});
}
