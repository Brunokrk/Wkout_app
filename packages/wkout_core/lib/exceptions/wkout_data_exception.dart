import 'wkout_base_exception.dart';
import 'wkout_exception_type_enum.dart';

/// Exceção relacionada a dados
class WkoutDataException extends WkoutBaseException {
  const WkoutDataException({
    super.message,
    super.stackTrace,
  });

  @override
  WkoutExceptionTypeEnum get type => WkoutExceptionTypeEnum.data;

  @override
  String extractMessage() {
    return message ?? 'Erro de dados';
  }
}