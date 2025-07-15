import 'package:wkout_core/exceptions/wkout_exception_type_enum.dart';

/// Classe base para todas as exceções do Wkout
abstract class WkoutBaseException implements Exception {
  const WkoutBaseException({
    this.message,
    this.stackTrace,
  });

  final String? message;
  final StackTrace? stackTrace;

  /// Tipo da exceção
  WkoutExceptionTypeEnum get type;

  /// Extrai a mensagem de erro
  String extractMessage();

  @override
  String toString() {
    return 'WkoutBaseException: ${extractMessage()}';
  }
}