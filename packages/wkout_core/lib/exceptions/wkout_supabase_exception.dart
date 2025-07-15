import 'wkout_base_exception.dart';
import 'wkout_exception_type_enum.dart';
import '../response/wkout_supabase_response.dart';

/// Exceção específica para erros do Supabase
class WkoutSupabaseException extends WkoutBaseException {
  const WkoutSupabaseException({
    super.message,
    super.stackTrace,
    this.response,
  });

  final WkoutSupabaseResponse? response;

  @override
  WkoutExceptionTypeEnum get type => WkoutExceptionTypeEnum.supabase;

  @override
  String extractMessage() {
    if (response?.error != null) {
      return response!.error!.message;
    }
    
    if (message != null) {
      return message!;
    }
    
    return 'Erro do Supabase';
  }

  /// Obtém o código de erro
  String? get errorCode => response?.error?.code;

  /// Obtém os detalhes do erro
  String? get errorDetails => response?.error?.details;

  /// Verifica se é um erro de autenticação
  bool get isAuthError {
    final code = errorCode;
    return code == 'invalid_credentials' || 
           code == 'user_not_found' ||
           code == 'email_not_confirmed';
  }

  /// Verifica se é um erro de rede
  bool get isNetworkError {
    final code = errorCode;
    return code == 'network_error' || 
           code == 'timeout' ||
           code == 'connection_failed';
  }

  /// Verifica se é um erro de validação
  bool get isValidationError {
    final code = errorCode;
    return code == 'validation_error' || 
           code == 'invalid_input' ||
           code == 'constraint_violation';
  }
}