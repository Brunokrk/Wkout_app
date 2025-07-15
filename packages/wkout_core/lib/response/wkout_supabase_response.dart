/// Resposta padronizada do Supabase
class WkoutSupabaseResponse<T> {
  const WkoutSupabaseResponse({
    this.data,
    this.error,
    this.isSuccess = true,
  });

  final T? data;
  final WkoutSupabaseError? error;
  final bool isSuccess;

  /// Factory para resposta de sucesso
  factory WkoutSupabaseResponse.success({T? data}) {
    return WkoutSupabaseResponse<T>(
      data: data,
      isSuccess: true,
    );
  }

  /// Factory para resposta de erro
  factory WkoutSupabaseResponse.error({WkoutSupabaseError? error}) {
    return WkoutSupabaseResponse<T>(
      error: error,
      isSuccess: false,
    );
  }

  /// Factory para resposta vazia
  factory WkoutSupabaseResponse.empty() {
    return WkoutSupabaseResponse<T>(isSuccess: true);
  }

  /// Verifica se a resposta foi bem-sucedida
  bool get hasData => data != null;

  /// Obtém a mensagem de erro
  String get errorMessage => error?.message ?? 'Erro desconhecido';

  @override
  String toString() {
    if (isSuccess) {
      return 'WkoutSupabaseResponse.success(data: $data)';
    } else {
      return 'WkoutSupabaseResponse.error(error: $error)';
    }
  }
}

/// Erro específico do Supabase
class WkoutSupabaseError {
  const WkoutSupabaseError({
    required this.message,
    this.code,
    this.details,
  });

  final String message;
  final String? code;
  final String? details;

  /// Cria erro a partir de uma exceção do Supabase
  factory WkoutSupabaseError.fromException(dynamic exception) {
    if (exception is Map<String, dynamic>) {
      return WkoutSupabaseError(
        message: exception['message'] ?? 'Erro do Supabase',
        code: exception['code'],
        details: exception['details'],
      );
    }

    return WkoutSupabaseError(
      message: exception.toString(),
    );
  }

  /// Cria erro a partir de uma string
  factory WkoutSupabaseError.fromString(String message) {
    return WkoutSupabaseError(message: message);
  }

  @override
  String toString() {
    return 'WkoutSupabaseError(message: $message, code: $code)';
  }
} 