# Wkout Core Package

Pacote central do app Wkout que fornece funcionalidades base, incluindo client personalizado, sistema de resposta padronizada, DTOs e classes base.

## Características

- **WkoutSupabaseClient**: Client personalizado que engloba o SupabaseClient
- **WkoutResponse**: Classe genérica para padronizar respostas
- **BaseDto**: Classe base para DTOs com validação
- **WkoutBaseService**: Classe base para services
- **WkoutBaseViewModel**: Classe base para ViewModels
- **WkoutInjector**: Sistema de injeção de dependência

## Estrutura

```
lib/
├── base/
│   ├── wkout_base_view_model.dart    # Classe base para ViewModels
│   └── wkout_base_service.dart       # Classe base para Services
├── client/
│   └── wkout_supabase_client.dart    # Client personalizado do Supabase
├── response/
│   └── wkout_response.dart           # Classe genérica de resposta
├── dto/
│   └── base_dto.dart                 # Classe base para DTOs
├── injector/
│   └── wkout_injector.dart           # Sistema de injeção de dependência
└── module/
    └── wkout_module.dart             # Classe base para módulos
```

## WkoutBaseService

Classe base para services que fornece tratamento padronizado de exceções:

```dart
abstract class WkoutBaseService {
  /// Trata exceções de forma padronizada
  Exception handleException({required dynamic exception}) {
    if (exception is Exception) {
      return exception;
    }
    
    if (exception is String) {
      return Exception(exception);
    }
    
    return Exception('Erro inesperado: ${exception.toString()}');
  }
}
```

### Uso em Services

```dart
class AuthService extends WkoutBaseService {
  final WkoutSupabaseClient _client;
  
  AuthService({@visibleForTesting WkoutSupabaseClient? mockClient})
      : _client = mockClient ?? WkoutSupabaseClient.create();

  Future<UserDto> login({required String email, required String password}) async {
    try {
      final response = await _client.signIn(
        email: email,
        password: password,
      );

      if (response.isSuccess) {
        final user = response.data?.user;
        if (user != null) {
          return UserDto.fromSupabaseUser(user);
        } else {
          throw Exception('Usuário não encontrado');
        }
      } else {
        throw Exception(response.error ?? 'Erro no login');
      }
    } catch (e) {
      throw handleException(exception: e);
    }
  }
}
```

## WkoutSupabaseClient

Client personalizado que engloba o SupabaseClient e fornece uma interface mais limpa:

### Criação

```dart
// Usando o factory padrão
final client = WkoutSupabaseClient.create();

// Usando um SupabaseClient customizado
final customSupabaseClient = SupabaseClient(url, anonKey);
final client = WkoutSupabaseClient.withClient(customSupabaseClient);
```

### Métodos de Autenticação

```dart
// Login
final response = await client.signIn(
  email: 'usuario@exemplo.com',
  password: 'senha123',
);

// Registro
final response = await client.signUp(
  email: 'novo@exemplo.com',
  password: 'senha123',
  data: {'name': 'João Silva'},
);

// Logout
await client.signOut();

// Verificar autenticação
bool isLoggedIn = client.isAuthenticated;
User? user = client.currentUser;
```

### Operações de Dados

```dart
// Inserir dados
await client.insert(
  table: 'users',
  data: {
    'name': 'Maria Santos',
    'email': 'maria@exemplo.com',
  },
);

// Buscar dados
final response = await client.select(
  table: 'users',
  filters: {'email': 'maria@exemplo.com'},
  limit: 10,
);
```

## WkoutResponse

Classe genérica para padronizar respostas de operações:

```dart
class WkoutResponse<T> {
  final T? data;
  final String? error;
  final bool isSuccess;

  WkoutResponse._({
    this.data,
    this.error,
    required this.isSuccess,
  });

  factory WkoutResponse.success({T? data}) {
    return WkoutResponse._(data: data, isSuccess: true);
  }

  factory WkoutResponse.error({String? error}) {
    return WkoutResponse._(error: error, isSuccess: false);
  }

  factory WkoutResponse.empty() {
    return WkoutResponse._(isSuccess: true);
  }
}
```

### Uso

```dart
// Sucesso
final successResponse = WkoutResponse.success(data: userData);

// Erro
final errorResponse = WkoutResponse.error(error: 'Erro na operação');

// Verificar resultado
if (response.isSuccess) {
  print('Sucesso: ${response.data}');
} else {
  print('Erro: ${response.error}');
}
```

## BaseDto

Classe base para DTOs com validação automática:

```dart
abstract class BaseDto {
  Map<String, dynamic> toMap();
  BaseDto copyWith(Map<String, dynamic> changes);
  bool get isValid;
  List<String> get validationErrors;
  Map<String, List<ValidationRule>> get validationRules;
  dynamic getFieldValue(String field);
}
```

### Mixin de Validação

```dart
mixin ValidationMixin on BaseDto {
  List<String> get validationErrors {
    final errors = <String>[];
    
    validationRules.forEach((field, rules) {
      final value = getFieldValue(field);
      
      for (final rule in rules) {
        if (!rule.isValid(value)) {
          errors.add(rule.errorMessage);
          break;
        }
      }
    });
    
    return errors;
  }

  bool get isValid => validationErrors.isEmpty;
}
```

### Regras de Validação

```dart
class ValidationRules {
  static const required = ValidationRule(
    isValid: (value) => value != null && value.toString().isNotEmpty,
    errorMessage: 'Campo obrigatório',
  );

  static const email = ValidationRule(
    isValid: (value) => value is String && 
        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value),
    errorMessage: 'Email inválido',
  );

  static ValidationRule minLength(int length) => ValidationRule(
    isValid: (value) => value is String && value.length >= length,
    errorMessage: 'Mínimo de $length caracteres',
  );
}
```

## WkoutBaseViewModel

Classe base para ViewModels com funcionalidades comuns:

```dart
abstract class WkoutBaseViewModel extends ChangeNotifier {
  bool _screenLoading = false;
  bool get screenLoading => _screenLoading;

  void toggleScreenLoading() {
    _screenLoading = !_screenLoading;
    notifyListeners();
  }

  bool _screenError = false;
  bool get screenError => _screenError;

  String? _screenErrorText;
  String? get screenErrorText => _screenErrorText;

  void setScreenErrorText(String? text) {
    _screenErrorText = text;
    notifyListeners();
  }

  void clearScreenError() {
    _screenErrorText = null;
    notifyListeners();
  }
}
```

## WkoutInjector

Sistema de injeção de dependência baseado no GetIt:

```dart
class WkoutInjector {
  static WkoutInjector get instance => _instance ??= WkoutInjector._();
  final GetIt _getIt = GetIt.instance;

  void registerSingleton<T extends Object>(FactoryFunc<T> factory, {String? instanceName}) {
    if (!_getIt.isRegistered<T>()) {
      _getIt.registerLazySingleton<T>(factory, instanceName: instanceName);
    }
  }

  void registerFactory<T extends Object>(FactoryFunc<T> factoryFunc, {String? instanceName}) {
    if (!_getIt.isRegistered<T>()) {
      _getIt.registerFactory(factoryFunc, instanceName: instanceName);
    }
  }
}
```

## Vantagens

1. **Padronização**: Respostas e tratamento de erros consistentes
2. **Reutilização**: Classes base para funcionalidades comuns
3. **Type Safety**: Melhor tipagem com genéricos
4. **Testabilidade**: Fácil mockar e testar
5. **Manutenibilidade**: Código organizado e modular
6. **Flexibilidade**: Acesso direto ao SupabaseClient quando necessário

## Dependências

- `supabase_flutter`: ^2.0.0
- `get_it`: Para injeção de dependência
- `flutter`: Para funcionalidades base
