import 'package:wkout_core/exceptions/wkout_base_exception.dart';

/// Interface para tratamento de exceções
abstract class WkoutExceptionHandler {
  /// Trata exceções de forma padronizada
  WkoutBaseException handleException({required Object? exception});
}
