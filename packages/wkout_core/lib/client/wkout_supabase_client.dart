import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../response/wkout_supabase_response.dart';

/// Client personalizado que engloba o SupabaseClient
/// Fornece uma interface mais limpa e específica para o app Wkout
class WkoutSupabaseClient {
  final SupabaseClient _supabaseClient;

  WkoutSupabaseClient._(this._supabaseClient);

  /// Obtém os headers atuais
  Map<String, String> get headers => _supabaseClient.rest.headers;

  /// Factory constructor que cria uma instância do client
  factory WkoutSupabaseClient.create() {
    return WkoutSupabaseClient._(Supabase.instance.client);
  }

  /// Factory constructor que aceita um SupabaseClient customizado
  factory WkoutSupabaseClient.withClient(SupabaseClient client) {
    return WkoutSupabaseClient._(client);
  }

  SupabaseClient get client => _supabaseClient;

  // ========== MÉTODOS DE AUTENTICAÇÃO ==========
  Future<WkoutSupabaseResponse<AuthResponse>> signUp({
    required String email,
    required String password,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: data,
      );
      return WkoutSupabaseResponse.success(data: response);
    } catch (e) {
      final error = WkoutSupabaseError.fromException(e);
      return WkoutSupabaseResponse.error(error: error);
    }
  }

  Future<WkoutSupabaseResponse<AuthResponse>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
      
      return WkoutSupabaseResponse.success(data: response);
    } catch (e) {
      final error = WkoutSupabaseError.fromException(e);
      return WkoutSupabaseResponse.error(error: error);
    }
  }

  Future<WkoutSupabaseResponse<void>> signOut() async {
    try {
      await _supabaseClient.auth.signOut();
      return WkoutSupabaseResponse.empty();
    } catch (e) {
      final error = WkoutSupabaseError.fromException(e);
      return WkoutSupabaseResponse.error(error: error);
    }
  }

  User? get currentUser => _supabaseClient.auth.currentUser;

  Session? get currentSession => _supabaseClient.auth.currentSession;

  Stream<AuthState> get authStateChanges => _supabaseClient.auth.onAuthStateChange;

  bool get isAuthenticated => currentUser != null;

  // ========== MÉTODOS DE DADOS ==========

  Future<WkoutSupabaseResponse<PostgrestResponse>> insert({
    required String table,
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await _supabaseClient
          .from(table)
          .insert(data);
      
      return WkoutSupabaseResponse.success(data: response);
    } catch (e) {
      final error = WkoutSupabaseError.fromException(e);
      return WkoutSupabaseResponse.error(error: error);
    }
  }

  Future<WkoutSupabaseResponse<dynamic>> select({
    required String table,
    String? columns,
    Map<String, dynamic>? filters,
    int? limit,
    int? offset,
  }) async {
    try {
      final response = await _supabaseClient
          .from(table)
          .select(columns ?? '*');
      
      return WkoutSupabaseResponse.success(data: response);
    } catch (e) {
      final error = WkoutSupabaseError.fromException(e);
      return WkoutSupabaseResponse.error(error: error);
    }
  }

  Future<WkoutSupabaseResponse<PostgrestResponse>> update({
    required String table,
    required Map<String, dynamic> data,
    Map<String, dynamic>? filters,
  }) async {
    try {
      var query = _supabaseClient.from(table).update(data);
      
      if (filters != null) {
        filters.forEach((key, value) {
          query = query.eq(key, value);
        });
      }
      
      final response = await query;
      return WkoutSupabaseResponse.success(data: response);
    } catch (e) {
      final error = WkoutSupabaseError.fromException(e);
      return WkoutSupabaseResponse.error(error: error);
    }
  }

  Future<WkoutSupabaseResponse<PostgrestResponse>> delete({
    required String table,
    Map<String, dynamic>? filters,
  }) async {
    try {
      var query = _supabaseClient.from(table).delete();
      
      if (filters != null) {
        filters.forEach((key, value) {
          query = query.eq(key, value);
        });
      }
      
      final response = await query;
      return WkoutSupabaseResponse.success(data: response);
    } catch (e) {
      final error = WkoutSupabaseError.fromException(e);
      return WkoutSupabaseResponse.error(error: error);
    }
  }

  // ========== MÉTODOS DE STORAGE ==========


  Future<WkoutSupabaseResponse<String>> uploadFile({
    required String bucket,
    required String path,
    required Uint8List fileBytes,
    String? contentType,
  }) async {
    try {
      await _supabaseClient.storage
          .from(bucket)
          .uploadBinary(path, fileBytes, fileOptions: FileOptions(
            contentType: contentType,
          ));
      
      final publicUrl = _supabaseClient.storage
          .from(bucket)
          .getPublicUrl(path);
      
      return WkoutSupabaseResponse.success(data: publicUrl);
    } catch (e) {
      final error = WkoutSupabaseError.fromException(e);
      return WkoutSupabaseResponse.error(error: error);
    }
  }

  Future<WkoutSupabaseResponse<void>> removeFile({
    required String bucket,
    required String path,
  }) async {
    try {
      await _supabaseClient.storage
          .from(bucket)
          .remove([path]);
      
      return WkoutSupabaseResponse.empty();
    } catch (e) {
      final error = WkoutSupabaseError.fromException(e);
      return WkoutSupabaseResponse.error(error: error);
    }
  }

  String getPublicUrl({
    required String bucket,
    required String path,
  }) {
    return _supabaseClient.storage
        .from(bucket)
        .getPublicUrl(path);
  }
} 