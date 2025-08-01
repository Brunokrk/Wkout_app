# Arquitetura de Roteamento Modular

## Visão Geral

Este documento explica como implementamos o roteamento modular no projeto Wkout, resolvendo os problemas de acoplamento e dependências circulares.

## Problema Original

- **Acoplamento forte**: Módulos importavam rotas do app principal
- **Dependência circular**: App principal importava páginas dos módulos, módulos importavam rotas do app
- **Falta de modularidade**: Rotas não eram organizadas por módulo

## Solução Implementada

### 1. Router Centralizado no Core

```dart
// packages/wkout_core/lib/router/wkout_router.dart
class WkoutRouter {
  static final WkoutRouter _instance = WkoutRouter._internal();
  factory WkoutRouter() => _instance;
  
  final List<RouteBase> _routes = [];
  final List<RouteBase> _shellRoutes = [];
  
  void registerRoutes(List<RouteBase> routes) {
    _routes.addAll(routes);
  }
  
  GoRouter createRouter() {
    return GoRouter(
      routes: [..._shellRoutes, ..._routes],
      initialLocation: '/',
    );
  }
}
```

### 2. Interface para Módulos

```dart
// packages/wkout_core/lib/router/wkout_router.dart
abstract class WkoutModuleRoutes {
  List<RouteBase> get routes;
  List<RouteBase> get shellRoutes => [];
}
```

### 3. Serviço de Navegação

```dart
// packages/wkout_core/lib/router/wkout_navigation_service.dart
class WkoutNavigationService {
  void go(BuildContext context, String route) {
    context.go(route);
  }
  
  void push(BuildContext context, String route) {
    context.push(route);
  }
}
```

### 4. Implementação nos Módulos

```dart
// packages/authentication/lib/src/routes/auth_routes.dart
class AuthRoutes implements WkoutModuleRoutes {
  static const String home = '/';
  static const String registerProfile = '/register-profile';

  @override
  List<RouteBase> get routes => [
    GoRoute(
      path: home,
      builder: (context, state) => const AuthHomePage(),
    ),
    GoRoute(
      path: registerProfile,
      builder: (context, state) => const RegisterProfilePage(),
    ),
  ];
}
```

### 5. Registro no Módulo

```dart
// packages/authentication/lib/src/authentication_module.dart
class AuthenticationModule extends WkoutModule<AuthenticationModule> {
  @override
  Future<void> registerInjection() async {
    // Registrar dependências
    WkoutInjector.I.registerSingleton<AuthService>(() => AuthService());
    WkoutInjector.I.registerSingleton<AuthHomeViewModel>(() => AuthHomeViewModel());
    
    // Registrar rotas do módulo
    WkoutRouter().registerRoutes(AuthRoutes().routes);
  }
}
```

### 6. Uso no App Principal

```dart
// apps/workout_app/lib/main.dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: WkoutRouter().createRouter(),
    );
  }
}
```

### 7. Navegação nos Módulos

```dart
// packages/authentication/lib/src/presentation/pages/home/auth_home_page.dart
AppButton(
  label: "Continuar",
  onPressed: () {
    WkoutNavigationService().go(context, AuthRoutes.registerProfile);
  },
),
```

## Vantagens da Solução

### ✅ **Modularidade**
- Cada módulo define suas próprias rotas
- Não há dependência circular
- Módulos são independentes

### ✅ **Centralização**
- Uma única instância do router
- Configuração centralizada
- Fácil manutenção

### ✅ **Flexibilidade**
- Suporte a shell routes
- Navegação entre módulos
- Parâmetros e dados extras

### ✅ **Testabilidade**
- Fácil mock do serviço de navegação
- Rotas isoladas por módulo
- Testes unitários independentes

## Estrutura de Arquivos

```
packages/
├── wkout_core/
│   └── lib/
│       ├── router/
│       │   ├── wkout_router.dart
│       │   └── wkout_navigation_service.dart
│       └── wkout_core.dart
└── authentication/
    └── lib/
        └── src/
            ├── routes/
            │   └── auth_routes.dart
            └── authentication_module.dart

apps/
└── workout_app/
    └── lib/
        └── main.dart
```

## Como Adicionar Novos Módulos

1. **Criar rotas do módulo**:
```dart
class WorkoutRoutes implements WkoutModuleRoutes {
  static const String home = '/workout';
  static const String exercises = '/workout/exercises';
  
  @override
  List<RouteBase> get routes => [
    GoRoute(path: home, builder: (context, state) => const WorkoutHomePage()),
    GoRoute(path: exercises, builder: (context, state) => const ExercisesPage()),
  ];
}
```

2. **Registrar no módulo**:
```dart
class WorkoutModule extends WkoutModule<WorkoutModule> {
  @override
  Future<void> registerInjection() async {
    // Dependências...
    WkoutRouter().registerRoutes(WorkoutRoutes().routes);
  }
}
```

3. **Inicializar no app**:
```dart
await WorkoutModule().registerInjection();
```

4. **Navegar**:
```dart
WkoutNavigationService().go(context, WorkoutRoutes.exercises);
```

## Considerações Importantes

### Dependências
- Apenas `wkout_core` tem dependência direta do `go_router`
- Módulos usam o `WkoutNavigationService` para navegação
- Não há importação direta do `go_router` nos módulos

### Navegação Entre Módulos
- Use constantes de rotas de outros módulos
- Exemplo: `WkoutNavigationService().go(context, AuthRoutes.home)`
- Evite strings hardcoded

### Performance
- Router é criado uma única vez
- Rotas são registradas na inicialização
- Navegação é otimizada pelo go_router

Esta arquitetura garante que o projeto seja verdadeiramente modular, com baixo acoplamento e alta coesão. 