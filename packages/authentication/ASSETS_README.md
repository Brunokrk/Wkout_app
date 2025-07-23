# Gerenciamento de Imagens no Pacote Authentication

Este documento explica como estruturar e usar imagens (SVG e PNG) no pacote `authentication`.

## Estrutura de Diretórios

```
packages/authentication/
├── assets/
│   └── images/
│       ├── svg/
│       │   └── logo.svg
│       └── png/
│           ├── user_icon.png
│           └── background.png
```

## Como Usar

### 1. Usando Constantes Predefinidas

```dart
import 'package:authentication/authentication.dart';

// Para SVG
AuthImageWidget(
  imagePath: AuthenticationImagePaths.logo,
  width: 100,
  height: 100,
)

// Para PNG
AuthImageWidget(
  imagePath: AuthenticationImagePaths.userIcon,
  width: 60,
  height: 60,
)
```

### 2. Usando Métodos Dinâmicos

```dart
// Para SVG
AuthImageWidget(
  imagePath: AuthenticationImagePaths.getSvgPath('logo'),
  width: 80,
  height: 80,
  color: Colors.blue,
)

// Para PNG
AuthImageWidget(
  imagePath: AuthenticationImagePaths.getPngPath('background'),
  width: 200,
  height: 100,
  fit: BoxFit.cover,
)
```

### 3. Usando o Widget AuthImageWidget

O `AuthImageWidget` detecta automaticamente se é SVG ou PNG baseado na extensão do arquivo:

```dart
AuthImageWidget(
  imagePath: 'caminho/para/imagem.svg', // Detecta como SVG
  width: 100,
  height: 100,
  color: Colors.red, // Aplica cor apenas para SVG
  fit: BoxFit.contain,
)
```

## Adicionando Novas Imagens

### 1. Adicione o arquivo na pasta correta:
- SVG: `assets/images/svg/`
- PNG: `assets/images/png/`

### 2. Adicione a constante no `AuthenticationImagePaths`:

```dart
class AuthenticationImagePaths {
  // ... código existente ...
  
  // Nova imagem SVG
  static const String newSvgImage = '$_basePath/svg/nova_imagem.svg';
  
  // Nova imagem PNG
  static const String newPngImage = '$_basePath/png/nova_imagem.png';
}
```

### 3. Use a imagem:

```dart
AuthImageWidget(
  imagePath: AuthenticationImagePaths.newSvgImage,
  width: 100,
  height: 100,
)
```

## Vantagens desta Estrutura

1. **Organização**: Imagens separadas por tipo (SVG/PNG)
2. **Reutilização**: Widget único para ambos os tipos
3. **Manutenibilidade**: Constantes centralizadas
4. **Flexibilidade**: Métodos para gerar caminhos dinamicamente
5. **Type Safety**: Constantes predefinidas evitam erros de digitação

## Configuração no pubspec.yaml

O pacote já está configurado para incluir os assets:

```yaml
flutter:
  assets:
    - assets/images/svg/
    - assets/images/png/
```

Isso permite que qualquer app que use o pacote `authentication` tenha acesso automático às imagens. 