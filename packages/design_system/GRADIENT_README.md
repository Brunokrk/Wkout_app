# Componente GradientBackground

Este componente permite criar fundos com degradê usando as cores do design system.

## Uso Básico

```dart
import 'package:design_system/design_system.dart';

GradientBackground(
  child: YourWidget(),
)
```

## Propriedades

- `child`: Widget filho obrigatório
- `begin`: Alinhamento inicial do degradê (padrão: `Alignment.topCenter`)
- `end`: Alinhamento final do degradê (padrão: `Alignment.bottomCenter`)
- `colors`: Lista de cores do degradê (padrão: cores primária e secundária com opacidade)
- `stops`: Lista de posições das cores (padrão: `[0.0, 1.0]`)

## Exemplos

### Degradê Padrão (Vertical)
```dart
GradientBackground(
  child: Scaffold(
    body: YourContent(),
  ),
)
```

### Degradê Personalizado
```dart
GradientBackground(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    AppColors.primary,
    AppColors.secondary,
    Colors.white,
  ],
  stops: [0.0, 0.5, 1.0],
  child: YourWidget(),
)
```

### Degradê com Opacidade
```dart
GradientBackground(
  colors: [
    AppColors.primary.withOpacity(0.9),
    AppColors.secondary.withOpacity(0.7),
  ],
  child: YourWidget(),
)
```

## Cores Disponíveis

- `AppColors.primary`: #8171e5 (Roxo)
- `AppColors.secondary`: #F3BA60 (Laranja)

## GradientBackgroundWidget

Também disponível uma versão simplificada:

```dart
GradientBackgroundWidget(
  padding: EdgeInsets.all(16),
  margin: EdgeInsets.all(8),
  child: YourWidget(),
)
```

Esta versão usa as cores primária e secundária sem opacidade e direção vertical. 