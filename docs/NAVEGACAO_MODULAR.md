# Navegação Modular - Documentação

## 📋 Índice

1. [Visão Geral](#visão-geral)
2. [Problema Original](#problema-original)
3. [Solução Implementada](#solução-implementada)
4. [Arquitetura](#arquitetura)
5. [Como Usar](#como-usar)
6. [Exemplos Práticos](#exemplos-práticos)
7. [Boas Práticas](#boas-práticas)
8. [FAQ](#faq)

## 🎯 Visão Geral

A navegação modular é uma arquitetura que permite que cada módulo do projeto defina suas próprias rotas de forma independente, mantendo baixo acoplamento e alta coesão. O sistema centraliza a configuração do router no módulo core, enquanto permite que os módulos registrem suas rotas durante a inicialização.

## ❌ Problema Original

### Antes da Implementação

```dart
// ❌ Problema: Dependência circular
// apps/workout_app/lib/routing/router.dart
import 'package:authentication/src/presentation/pages/home/auth_home_page.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const AuthHomePage(), // ❌ App importa módulo
    ),
  ],
);

// packages/authentication/lib/src/presentation/pages/home/auth_home_page.dart
import 'package:workout_app/routing/routes.dart'; // ❌ Módulo importa app

context.go(Routes.registerProfile); // ❌ Dependência circular
```

**Problemas identificados:**
- 🔴 **Dependência circular**: App principal importa módulos, módulos importam app
- 🔴 **Acoplamento forte**: Módulos dependem diretamente do router do app
- 🔴 **Falta de modularidade**: Rotas não organizadas por módulo
- 🔴 **Difícil manutenção**: Mudanças no router afetam todos os módulos

## ✅ Solução Implementada

### Arquitetura Modular

```dart
// ✅ Solução: Router centralizado com registro por módulo
// packages/wkout_core/lib/router/wkout_router.dart
class WkoutRouter {
  static final WkoutRouter _instance = WkoutRouter._internal();
  factory WkoutRouter() => _instance;
  
  final List<RouteBase> _routes = [];
  
  void registerRoutes(List<RouteBase> routes) {
    _routes.addAll(routes);
  }
  
  GoRouter createRouter() {
    return GoRouter(routes: _routes, initialLocation: '/');
  }
}
```

## 🏗️ Arquitetura

### Estrutura de Arquivos

```
packages/
├── wkout_core/
│   └── lib/
│       ├── router/
│       │   ├── wkout_router.dart          # Router centralizado
│       │   └── wkout_navigation_service.dart # Serviço de navegação
│       └── wkout_core.dart                # Exports
└── authentication/
    └── lib/
        └── src/
            ├── routes/
            │   └── auth_routes.dart        # Rotas do módulo
            └── authentication_module.dart   # Registro do módulo

apps/
└── workout_app/
    └── lib/
        └── main.dart                       # Inicialização
```

### Componentes Principais

#### 1. WkoutRouter (Singleton)
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
  
  void registerShellRoutes(List<RouteBase> shellRoutes) {
    _shellRoutes.addAll(shellRoutes);
  }
  
  GoRouter createRouter() {
    final allRoutes = [..._shellRoutes, ..._routes];
    return GoRouter(
      routes: allRoutes,
      initialLocation: '/',
      debugLogDiagnostics: true,
    );
  }
}
```

#### 2. WkoutNavigationService
```dart
// packages/wkout_core/lib/router/wkout_navigation_service.dart
class WkoutNavigationService {
  static final WkoutNavigationService _instance = WkoutNavigationService._internal();
  factory WkoutNavigationService() => _instance;
  
  void go(BuildContext context, String route) {
    context.go(route);
  }
  
  void push(BuildContext context, String route) {
    context.push(route);
  }
  
  void pop(BuildContext context) {
    context.pop();
  }
}
```

#### 3. Interface para Módulos
```dart
// packages/wkout_core/lib/router/wkout_router.dart
abstract class WkoutModuleRoutes {
  List<RouteBase> get routes;
  List<RouteBase> get shellRoutes => [];
}
```

## 🚀 Como Usar

### 1. Definir Rotas do Módulo

```dart
// packages/authentication/lib/src/routes/auth_routes.dart
import 'package:flutter/material.dart';
import 'package:wkout_core/wkout_core.dart';
import '../presentation/pages/home/auth_home_page.dart';
import '../presentation/pages/register/register_profile_page.dart';

class AuthRoutes implements WkoutModuleRoutes {
  // Constantes para as rotas (evita strings hardcoded)
  static const String home = '/';
  static const String registerProfile = '/register-profile';
  static const String login = '/login';
  static const String forgotPassword = '/forgot-password';

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
    GoRoute(
      path: login,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: forgotPassword,
      builder: (context, state) => const ForgotPasswordPage(),
    ),
  ];

  @override
  List<RouteBase> get shellRoutes => [
    // Shell routes para navegação com bottom navigation
    ShellRoute(
      builder: (context, state, child) => AuthShell(child: child),
      routes: [
        GoRoute(path: '/auth/settings', builder: (context, state) => const SettingsPage()),
      ],
    ),
  ];
}
```

### 2. Registrar no Módulo

```dart
// packages/authentication/lib/src/authentication_module.dart
import 'package:wkout_core/wkout_core.dart';
import 'routes/auth_routes.dart';

class AuthenticationModule extends WkoutModule<AuthenticationModule> {
  @override
  Future<void> registerInjection() async {
    // Registrar dependências
    WkoutInjector.I.registerSingleton<AuthService>(() => AuthService());
    WkoutInjector.I.registerSingleton<AuthHomeViewModel>(() => AuthHomeViewModel());
    
    // Registrar rotas do módulo
    WkoutRouter().registerRoutes(AuthRoutes().routes);
    WkoutRouter().registerShellRoutes(AuthRoutes().shellRoutes);
  }
}
```

### 3. Inicializar no App Principal

```dart
// apps/workout_app/lib/main.dart
import 'package:wkout_core/wkout_core.dart';
import 'package:authentication/src/authentication_module.dart';

Future<void> main() async {
  // Inicializar módulos
  await AuthenticationModule().registerInjection();
  await WorkoutModule().registerInjection();
  await ProfileModule().registerInjection();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Wkout App',
      theme: AppTheme.light,
      routerConfig: WkoutRouter().createRouter(),
    );
  }
}
```

### 4. Navegar nas Páginas

```dart
// packages/authentication/lib/src/presentation/pages/home/auth_home_page.dart
import 'package:wkout_core/wkout_core.dart';
import '../routes/auth_routes.dart';

class AuthHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppButton(
            label: "Entrar",
            onPressed: () {
              // Navegação simples
              WkoutNavigationService().go(context, AuthRoutes.login);
            },
          ),
          AppButton(
            label: "Registrar",
            onPressed: () {
              // Navegação com dados extras
              WkoutNavigationService().goWithExtra(
                context, 
                AuthRoutes.registerProfile,
                {'source': 'home_page'}
              );
            },
          ),
          AppButton(
            label: "Esqueci a senha",
            onPressed: () {
              // Navegação push (mantém na pilha)
              WkoutNavigationService().push(context, AuthRoutes.forgotPassword);
            },
          ),
        ],
      ),
    );
  }
}
```

## 📝 Exemplos Práticos

### Exemplo 1: Módulo de Workout

```dart
// packages/workout/lib/src/routes/workout_routes.dart
class WorkoutRoutes implements WkoutModuleRoutes {
  static const String home = '/workout';
  static const String exercises = '/workout/exercises';
  static const String exerciseDetail = '/workout/exercises/:id';
  static const String createWorkout = '/workout/create';

  @override
  List<RouteBase> get routes => [
    GoRoute(
      path: home,
      builder: (context, state) => const WorkoutHomePage(),
    ),
    GoRoute(
      path: exercises,
      builder: (context, state) => const ExercisesPage(),
    ),
    GoRoute(
      path: exerciseDetail,
      builder: (context, state) {
        final exerciseId = state.pathParameters['id'];
        return ExerciseDetailPage(exerciseId: exerciseId);
      },
    ),
    GoRoute(
      path: createWorkout,
      builder: (context, state) => const CreateWorkoutPage(),
    ),
  ];
}
```

### Exemplo 2: Navegação Entre Módulos

```dart
// packages/workout/lib/src/presentation/pages/exercises_page.dart
import 'package:wkout_core/wkout_core.dart';
import 'package:authentication/src/routes/auth_routes.dart';

class ExercisesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercícios'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              // Navegação para módulo de autenticação
              WkoutNavigationService().go(context, AuthRoutes.home);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Exercício ${index + 1}'),
            onTap: () {
              // Navegação com parâmetros
              WkoutNavigationService().go(
                context, 
                WorkoutRoutes.exerciseDetail.replaceAll(':id', '${index + 1}')
              );
            },
          );
        },
      ),
    );
  }
}
```

### Exemplo 3: Shell Routes (Bottom Navigation)

```dart
// packages/main/lib/src/routes/main_routes.dart
class MainRoutes implements WkoutModuleRoutes {
  static const String main = '/main';
  static const String home = '/main/home';
  static const String workout = '/main/workout';
  static const String profile = '/main/profile';

  @override
  List<RouteBase> get shellRoutes => [
    ShellRoute(
      builder: (context, state, child) => MainShell(child: child),
      routes: [
        GoRoute(
          path: home,
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: workout,
          builder: (context, state) => const WorkoutPage(),
        ),
        GoRoute(
          path: profile,
          builder: (context, state) => const ProfilePage(),
        ),
      ],
    ),
  ];

  @override
  List<RouteBase> get routes => [];
}
```

## 🎯 Boas Práticas

### 1. Organização de Rotas

```dart
// ✅ Boa prática: Constantes para rotas
class AuthRoutes implements WkoutModuleRoutes {
  // Rotas principais
  static const String home = '/';
  static const String login = '/login';
  static const String register = '/register';
  
  // Rotas aninhadas
  static const String profile = '/profile';
  static const String profileEdit = '/profile/edit';
  static const String profileSettings = '/profile/settings';
  
  // Rotas com parâmetros
  static const String userDetail = '/user/:id';
  static const String userPosts = '/user/:id/posts';
}
```

### 2. Navegação Segura

```dart
// ✅ Boa prática: Verificação de autenticação
class AuthGuard {
  static bool canAccess(BuildContext context, String route) {
    final authService = WkoutInjector.I.get<AuthService>();
    if (!authService.isAuthenticated && route != AuthRoutes.login) {
      WkoutNavigationService().go(context, AuthRoutes.login);
      return false;
    }
    return true;
  }
}

// Uso
AppButton(
  onPressed: () {
    if (AuthGuard.canAccess(context, WorkoutRoutes.home)) {
      WkoutNavigationService().go(context, WorkoutRoutes.home);
    }
  },
)
```

### 3. Tratamento de Erros

```dart
// ✅ Boa prática: Páginas de erro
class ErrorRoutes implements WkoutModuleRoutes {
  static const String notFound = '/404';
  static const String serverError = '/500';
  static const String unauthorized = '/401';

  @override
  List<RouteBase> get routes => [
    GoRoute(
      path: notFound,
      builder: (context, state) => const NotFoundPage(),
    ),
    GoRoute(
      path: serverError,
      builder: (context, state) => const ServerErrorPage(),
    ),
    GoRoute(
      path: unauthorized,
      builder: (context, state) => const UnauthorizedPage(),
    ),
  ];
}
```

### 4. Testes

```dart
// ✅ Boa prática: Testes de navegação
class NavigationServiceTest {
  test('should navigate to login page', () {
    final mockContext = MockBuildContext();
    final navigationService = WkoutNavigationService();
    
    navigationService.go(mockContext, AuthRoutes.login);
    
    verify(mockContext.go(AuthRoutes.login)).called(1);
  });
}
```

## ❓ FAQ

### Q: Como adicionar um novo módulo?

**A:** Siga estes passos:

1. **Criar estrutura do módulo:**
```dart
// packages/new_module/lib/src/routes/new_module_routes.dart
class NewModuleRoutes implements WkoutModuleRoutes {
  static const String home = '/new-module';
  
  @override
  List<RouteBase> get routes => [
    GoRoute(
      path: home,
      builder: (context, state) => const NewModuleHomePage(),
    ),
  ];
}
```

2. **Registrar no módulo:**
```dart
// packages/new_module/lib/src/new_module.dart
class NewModule extends WkoutModule<NewModule> {
  @override
  Future<void> registerInjection() async {
    WkoutRouter().registerRoutes(NewModuleRoutes().routes);
  }
}
```

3. **Inicializar no app:**
```dart
// apps/workout_app/lib/main.dart
await NewModule().registerInjection();
```

### Q: Como navegar entre módulos?

**A:** Use constantes de rotas de outros módulos:

```dart
// No módulo A, navegando para módulo B
WkoutNavigationService().go(context, ModuleBRoutes.home);
```

### Q: Como passar parâmetros?

**A:** Use os métodos com parâmetros:

```dart
// Com dados extras
WkoutNavigationService().goWithExtra(
  context, 
  route, 
  {'userId': 123, 'data': 'example'}
);

// Com parâmetros de URL
WkoutNavigationService().go(
  context, 
  '/user/123/posts'
);
```

### Q: Como implementar autenticação?

**A:** Use guards ou middleware:

```dart
// packages/wkout_core/lib/router/wkout_router.dart
GoRouter createRouter() {
  return GoRouter(
    routes: _routes,
    redirect: (context, state) {
      final authService = WkoutInjector.I.get<AuthService>();
      if (!authService.isAuthenticated && state.location != '/login') {
        return '/login';
      }
      return null;
    },
  );
}
```

### Q: Como testar a navegação?

**A:** Mock o serviço de navegação:

```dart
// test/navigation_test.dart
class MockNavigationService extends Mock implements WkoutNavigationService {}

void main() {
  testWidgets('should navigate on button press', (tester) async {
    final mockNavigation = MockNavigationService();
    
    await tester.pumpWidget(MyWidget());
    await tester.tap(find.byType(ElevatedButton));
    
    verify(mockNavigation.go(any, AuthRoutes.login)).called(1);
  });
}
```

## 📚 Recursos Adicionais

- [Documentação do GoRouter](https://pub.dev/packages/go_router)
- [Padrões de Navegação Flutter](https://docs.flutter.dev/ui/navigation)
- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)

---

**Última atualização:** Dezembro 2024  
**Versão:** 1.0.0  
**Autor:** Bruno Marchi Pires