import '../exceptions/wkout_base_exception.dart';
import '../exceptions/wkout_exceptions_handler.dart';
import '../exceptions/wkout_supabase_exception.dart';
import '../exceptions/wkout_data_exception.dart';

abstract class WkoutBaseService implements WkoutExceptionHandler {
  
  /// Trata exceções de forma padronizada
  @override
  WkoutBaseException handleException({required Object? exception}) {
    return switch (exception) {
      WkoutSupabaseException() => exception,
      _ => WkoutDataException(
        message: exception?.toString() ?? 'Erro desconhecido',
      ),
    };
  }
} 
