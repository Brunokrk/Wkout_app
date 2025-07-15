# Authentication Package

Pacote de autenticação para o app Wkout, implementando Clean Architecture completa com separação clara entre Data, Domain e Presentation layers.

## Características

- **Clean Architecture**: Separação clara entre camadas (Data, Domain, Presentation)
- **DTOs**: Validação e transferência de dados na camada Data
- **Models**: Entidades de domínio na camada Domain
- **Use Cases**: Uma única AuthUseCase com todas as regras de negócio
- **ViewModels**: Gerenciamento de estado na camada Presentation
- **Error Handling**: Tratamento padronizado de erros
- **Testing**: Suporte a testes com mocks

## Estrutura do Clean Architecture

```
lib/
├── src/
│   ├── data/                          # DATA LAYER
│   │   ├── data_source/
│   │   │   └── auth_service.dart      # Services que retornam DTOs
│   │   ├── repositories/
│   │   │   └── auth_repository.dart   # Transforma DTOs em Models
│   │   └── dto/
│   │       └── auth_dto.dart          # DTOs para validação
│   ├── domain/                        # DOMAIN LAYER
│   │   ├── models/
│   │   │   └── user_model.dart        # Entidades de domínio
│   │   └── usecases/
│   │       └── auth_usecase.dart      # Única Use Case com regras de negócio
│   ├── presentation/                   # PRESENTATION LAYER
│   │   └── pages/
│   │       └── home/
│   │           ├── auth_home_page.dart
│   │           └── auth_home_view_model.dart
│   └── examples/
│       └── single_usecase_example.dart
```

## Fluxo de Dados

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   ViewModels    │    │   AuthUseCase   │    │   Repositories  │    │    Services     │
│                 │    │                 │    │                 │    │                 │
│ • Gerenciam     │◄───┤ • Regras de     │◄───┤ • Transformam   │◄───┤ • Retornam      │
│   estado        │    │   negócio       │    │   DTOs em       │    │   DTOs          │
│                 │    │ • Estado        │    │   Models        │    │                 │
└─────────────────┘    └─────────────────┘    └─────────────────┘    └─────────────────┘
```

## Data Layer

### DTOs
DTOs validam dados de entrada e são usados para transferência de dados:

```dart
// Validação de entrada
final loginDto = LoginDto(
  email: 'usuario@exemplo.com',
  password: '123456',
);

if (!loginDto.isValid) {
  print('Erros: ${loginDto.validationErrors}');
  return;
}
```

### Services
Services fazem requisições e retornam DTOs:

```dart
class AuthService extends WkoutBaseService {
  Future<UserDto> login({required String email, required String password}) async {
    // Faz requisição e retorna UserDto
  }
}
```

### Repositories
Repositories transformam DTOs em Models:

```dart
class AuthRepository {
  Future<UserModel> login({required String email, required String password}) async {
    final userDto = await _authService.login(email: email, password: password);
    return _mapUserDtoToModel(userDto); // Transforma DTO em Model
  }
}
```

## Domain Layer

### Models
Entidades de domínio que representam o negócio:

```dart
class UserModel {
  final String id;
  final String email;
  final String? name;
  final int? age;

  bool get isValid => id.isNotEmpty && email.isNotEmpty;
  String get displayName => name?.isNotEmpty == true ? name! : email;
}
```

### AuthUseCase
Única Use Case que contém todas as regras de negócio e gerencia o estado:

```dart
class AuthUseCase extends WkoutBaseService {
  final AuthRepository _repository;
  UserModel? _currentUser;

  // Estado
  UserModel? get currentUser => _currentUser;
  bool get isAuthenticated => _currentUser != null && _currentUser!.isValid;
  String get displayName => _currentUser?.displayName ?? 'Usuário';

  /// Executa login com validações de negócio
  Future<void> login({required String email, required String password}) async {
    // Regras de negócio para login
    _validateLoginData(email: email, password: password);

    // Executar login via repository
    final user = await _repository.login(
      email: email.trim(),
      password: password,
    );

    // Regras de negócio pós-login
    _validateUserAfterLogin(user);

    // Atualizar estado
    _currentUser = user;
  }

  /// Executa registro com validações de negócio
  Future<void> register({
    required String email,
    required String password,
    required String name,
    int? age,
  }) async {
    // Regras de negócio para registro
    _validateRegisterData(email: email, password: password, name: name, age: age);

    // Executar registro via repository
    final user = await _repository.register(
      email: email.trim(),
      password: password,
      name: name.trim(),
    );

    // Atualizar estado
    _currentUser = user;
  }

  /// Atualiza dados do usuário
  Future<void> updateUser({
    String? name,
    int? age,
    String? avatarUrl,
  }) async {
    if (_currentUser == null) {
      throw Exception('Usuário não autenticado');
    }

    // Regras de negócio para atualização
    _validateUpdateData(name: name, age: age);

    // Criar cópia do usuário com as modificações
    final updatedUser = _currentUser!.copyWith(
      name: name,
      age: age,
      avatarUrl: avatarUrl,
    );

    // Executar atualização via repository
    final user = await _repository.updateUser(user: updatedUser);
    
    // Atualizar estado
    _currentUser = user;
  }

  // Métodos privados de validação
  void _validateLoginData({required String email, required String password}) {
    if (email.trim().isEmpty) {
      throw Exception('Email é obrigatório');
    }
    if (password.length < 6) {
      throw Exception('Senha deve ter pelo menos 6 caracteres');
    }
    // Mais validações...
  }
}
```

## Presentation Layer

### ViewModels
Gerenciam estado da UI usando a única AuthUseCase:

```dart
class AuthHomeViewModel extends WkoutBaseViewModel {
  final AuthUseCase _authUseCase;

  AuthHomeViewModel({AuthUseCase? authUseCase})
      : _authUseCase = authUseCase ?? AuthUseCase(
          repository: AuthRepository(),
        );

  // Getters que delegam para a AuthUseCase
  UserModel? get user => _authUseCase.currentUser;
  bool get isAuthenticated => _authUseCase.isAuthenticated;
  String get displayName => _authUseCase.displayName;

  Future<void> login(String email, String password) async {
    try {
      toggleScreenLoading();
      clearScreenError();

      // AuthUseCase executa todas as regras de negócio
      await _authUseCase.login(email: email, password: password);

      notifyListeners();
    } catch (e) {
      setScreenErrorText(e.toString());
    } finally {
      toggleScreenLoading();
    }
  }

  Future<void> updateUser({String? name, int? age, String? avatarUrl}) async {
    try {
      toggleScreenLoading();
      clearScreenError();

      // AuthUseCase executa todas as regras de negócio
      await _authUseCase.updateUser(
        name: name,
        age: age,
        avatarUrl: avatarUrl,
      );

      notifyListeners();
    } catch (e) {
      setScreenErrorText(e.toString());
    } finally {
      toggleScreenLoading();
    }
  }
}
```

## Vantagens da Única Use Case

### 1. **Simplicidade**
- Uma única classe para todas as operações de auth
- Menos arquivos para manter
- Interface mais limpa

### 2. **Estado Centralizado**
- Estado do usuário gerenciado em um lugar
- Fácil acesso a dados do usuário
- Consistência de estado

### 3. **Manutenibilidade**
- Regras de negócio centralizadas
- Fácil adicionar novas validações
- Mudanças isoladas

### 4. **Testabilidade**
- Um único mock para todos os testes
- Testes mais simples
- Cobertura completa

### 5. **Reutilização**
- Uma instância pode ser usada em múltiplos ViewModels
- Compartilhamento de estado entre telas
- Menos duplicação de código

## Fluxo Completo de Exemplo

```dart
// 1. Criar AuthUseCase
final authUseCase = AuthUseCase(
  repository: AuthRepository(),
);

// 2. Login
await authUseCase.login(
  email: 'usuario@exemplo.com',
  password: '123456',
);

// 3. Verificar estado
if (authUseCase.isAuthenticated) {
  print('Usuário: ${authUseCase.displayName}');
}

// 4. Atualizar dados
await authUseCase.updateUser(
  name: 'João Silva Santos',
  age: 26,
);

// 5. Logout
await authUseCase.logout();
```

## Exemplos

Veja o arquivo `examples/single_usecase_example.dart` para exemplos completos do uso da única AuthUseCase.

## Dependências

- `wkout_core`: Classes base e client personalizado
- `supabase_flutter`: Backend de autenticação
- `flutter`: Framework base
