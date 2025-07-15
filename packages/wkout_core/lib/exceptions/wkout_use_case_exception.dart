import 'package:wkout_core/exceptions/wkout_base_exception.dart';
import 'package:wkout_core/exceptions/wkout_exception_type_enum.dart';

class WkoutUseCaseException extends WkoutBaseException {
  WkoutUseCaseException({super.stackTrace, super.message});

  @override
  String toString() => message ?? 'Ocorreu um erro.';

  @override
  WkoutExceptionTypeEnum get type => WkoutExceptionTypeEnum.domain;

  @override
  String extractMessage() => message ?? 'Erro no use case';
}