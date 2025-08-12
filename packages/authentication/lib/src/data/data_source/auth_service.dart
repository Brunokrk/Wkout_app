import 'package:flutter/material.dart';
import 'package:wkout_core/wkout_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../dto/auth_dto.dart';

class AuthService extends WkoutBaseService {
  final WkoutSupabaseClient _client;
  
  AuthService({@visibleForTesting WkoutSupabaseClient? mockClient})
      : _client = mockClient ?? WkoutSupabaseClient.create();

  /// Realiza login do usuário
  Future<UserDto> login({required String email, required String password}) async {
    try {
      final response = await _client.signIn(
        email: email,
        password: password,
      );

      if (response.isSuccess) {
        final user = response.data?.user;
        if (user != null) {
          return UserDto.fromSupabaseUser(user);
        } else {
          throw Exception('Usuário não encontrado');
        }
      } else {
        throw Exception(response.error ?? 'Erro no login');
      }
    } catch (e) {
      throw handleException(exception: e);
    }
  }

  /// Registra um novo usuário
  Future<UserDto> register({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final response = await _client.signUp(
        email: email,
        password: password,
        data: {'name': name},
      );

      if (response.isSuccess) {
        final user = response.data?.user;
        if (user != null) {
          return UserDto.fromSupabaseUser(user);
        } else {
          throw Exception('Erro ao criar usuário');
        }
      } else {
        throw Exception(response.error ?? 'Erro no registro');
      }
    } catch (e) {
      throw handleException(exception: e);
    }
  }

  /// Realiza logout do usuário
  Future<void> logout() async {
    try {
      final response = await _client.signOut();
      
      if (!response.isSuccess) {
        throw Exception(response.error ?? 'Erro no logout');
      }
    } catch (e) {
      throw handleException(exception: e);
    }
  }

  /// Atualiza dados do usuário
  Future<UserDto> updateUser({required UserDto user}) async {
    try {
      // Para atualizar dados do usuário, precisamos usar o SupabaseClient diretamente
      final response = await _client.client.auth.updateUser(
        UserAttributes(
          data: user.toMap(),
        ),
      );

      if (response.user != null) {
        return UserDto.fromSupabaseUser(response.user!);
      } else {
        throw Exception('Erro ao atualizar usuário');
      }
    } catch (e) {
      throw handleException(exception: e);
    }
  }
}