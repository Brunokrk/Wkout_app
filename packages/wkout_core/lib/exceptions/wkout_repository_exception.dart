import 'package:wkout_core/exceptions/wkout_base_exception.dart';
import 'package:wkout_core/exceptions/wkout_exception_type_enum.dart';

class WkoutRepositoryException extends WkoutBaseException {
  WkoutRepositoryException({super.stackTrace, super.message});

  @override
  WkoutExceptionTypeEnum get type => WkoutExceptionTypeEnum.data;

  @override
  String extractMessage() => message ?? 'Erro no repositório';
}