library wkout_core;

// Base classes
export 'base/wkout_base_view_model.dart';
export 'base/wkout_base_parameters.dart';
export 'data/wkout_base_service.dart';

// Injector
export 'injector/wkout_injector.dart';

// Modules
export 'module/wkout_module.dart';

// Client
export 'client/wkout_supabase_client.dart';

// Response
export 'response/wkout_supabase_response.dart';

// Exceptions
export 'exceptions/wkout_base_exception.dart';
export 'exceptions/wkout_exception_type_enum.dart';
export 'exceptions/wkout_exceptions_handler.dart';
export 'exceptions/wkout_supabase_exception.dart';
export 'exceptions/wkout_data_exception.dart';

// DTOs
export 'data/dto/base_dto.dart';

// Router
export 'router/wkout_router.dart';
export 'router/wkout_navigation_service.dart';

// Re-export go_router types for modules
export 'package:go_router/go_router.dart';

// Utils
export 'utils/validators.dart';
