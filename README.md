# 🏋️ Wkout App - Projeto de Estudo em Modularização

## 🎯 Objetivo do Projeto

Este projeto tem como objetivo **estudar e desenvolver um aplicativo Flutter completamente modularizado**, explorando as melhores práticas de arquitetura de software, separação de responsabilidades e escalabilidade. O foco principal é demonstrar como construir aplicações complexas mantendo baixo acoplamento e alta coesão entre os módulos.

### 🚀 Principais Objetivos de Aprendizado

- **Arquitetura Modular**: Implementar uma estrutura onde cada funcionalidade é um módulo independente
- **Injeção de Dependência**: Utilizar padrões de DI para gerenciar dependências entre módulos
- **Navegação Modular**: Desenvolver um sistema de roteamento que respeite a modularidade
- **Clean Architecture**: Aplicar princípios de Clean Architecture em cada módulo
- **Testabilidade**: Garantir que cada módulo seja testável de forma isolada
- **Escalabilidade**: Criar uma base sólida para crescimento do projeto

## 🏗️ Estrutura do Projeto

```
Wkout_app/
├── 📱 apps/
│   └── workout_app/                    # Aplicação principal
│       ├── lib/
│       │   ├── main.dart              # Ponto de entrada
│       │  
│       ├── android/                   # Configurações Android
│       ├── ios/                       # Configurações iOS
│       └── pubspec.yaml              # Dependências do app
│
├── 📦 packages/                       # Módulos do projeto
│   ├── authentication/                # Módulo de autenticação
│   │   ├── lib/
│   │   │   ├── src/
│   │   │   │   ├── data/             # Camada de dados
│   │   │   │   │   ├── domain/       # Camada de domínio
│   │   │   │   │   └── presentation/ # Camada de apresentação
│   │   │   │   └── routes/           # Rotas do módulo
│   │   │   └── authentication.dart   # Export principal
│   │   └── pubspec.yaml
│   │
│   ├── design_system/                 # Sistema de design
│   │   ├── lib/
│   │   │   ├── src/
│   │   │   │   ├── components/       # Componentes reutilizáveis
│   │   │   │   ├── theme/            # Temas da aplicação
│   │   │   │   └── tokens/           # Tokens de design
│   │   │   └── design_system.dart
│   │   └── pubspec.yaml
│   │
│   └── wkout_core/                    # Módulo core (infraestrutura)
│       ├── lib/
│       │   ├── base/                  # Classes base
│       │   ├── client/                # Cliente HTTP/Supabase
│       │   ├── data/                  # DTOs e serviços base
│       │   ├── exceptions/            # Tratamento de exceções
│       │   ├── injector/              # Injeção de dependência
│       │   ├── module/                # Sistema de módulos
│       │   ├── response/              # Respostas padronizadas
│       │   ├── router/                # Sistema de navegação
│       │   └── wkout_core.dart
│       └── pubspec.yaml
│
├── 📚 docs/                           # Documentação
│   └── NAVEGACAO_MODULAR.md          # Guia de navegação modular
│
├── 📋 melos.yaml                      # Configuração do monorepo
└── 📄 pubspec.yaml                    # Dependências raiz
```

## 🧩 Arquitetura Modular

### 📦 Módulos do Projeto

#### 1. **wkout_core** - Infraestrutura Base
- **Responsabilidade**: Fornecer serviços e classes base para todos os módulos
- **Componentes**:
  - `WkoutInjector`: Sistema de injeção de dependência
  - `WkoutRouter`: Sistema de navegação centralizado
  - `WkoutModule`: Interface para módulos
  - `WkoutBaseViewModel`: ViewModel base
  - `WkoutSupabaseClient`: Cliente para Supabase

#### 2. **authentication** - Módulo de Autenticação
- **Responsabilidade**: Gerenciar autenticação de usuários
- **Funcionalidades**:
  - Login/Registro de usuários
  - Gerenciamento de sessão
  - Perfil do usuário
- **Arquitetura**: Clean Architecture (Data, Domain, Presentation)

#### 3. **design_system** - Sistema de Design
- **Responsabilidade**: Fornecer componentes e tokens de design
- **Componentes**:
  - Botões, inputs, loading
  - Temas (claro/escuro)
  - Tokens de cores, tipografia, espaçamento

#### 4. **workout_app** - Aplicação Principal
- **Responsabilidade**: Orquestrar módulos e configurar a aplicação
- **Funcionalidades**:
  - Inicialização de módulos
  - Configuração do router
  - Setup da aplicação

## 🔄 Fluxo de Dados

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Presentation  │───▶│     Domain      │───▶│      Data       │
│     (UI)        │    │   (Business)    │    │   (External)    │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                       │                       │
         │                       │                       │
         ▼                       ▼                       ▼
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   ViewModel     │    │   Use Cases     │    │   Repository    │
│   (State)       │    │   (Logic)       │    │   (Data Access) │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

## 🚀 Como Executar

### Pré-requisitos
- Flutter SDK 3.6.1+
- Dart SDK 3.6.1+
- Melos (para gerenciamento do monorepo)

### Instalação

```bash
# 1. Clonar o repositório
git clone https://github.com/seu-usuario/wkout-app.git
cd wkout-app

# 2. Instalar dependências
melos bootstrap

# 3. Executar a aplicação
melos run dev
```

### Comandos Úteis

```bash
# Executar testes
melos test

```

## 🧪 Testes

Cada módulo possui seus próprios testes:

```bash
# Testes do módulo de autenticação
cd packages/authentication
flutter test

# Testes do módulo core
cd packages/wkout_core
flutter test

# Todos os testes
melos test
```

## 📚 Documentação

- [Guia de Navegação Modular](docs/NAVEGACAO_MODULAR.md)

## 🎯 Benefícios da Arquitetura

### ✅ **Modularidade**
- Cada módulo é independente e pode ser desenvolvido/testado isoladamente
- Fácil adição de novos módulos sem afetar os existentes
- Reutilização de módulos em outros projetos

### ✅ **Escalabilidade**
- Estrutura preparada para crescimento
- Fácil onboarding de novos desenvolvedores
- Separação clara de responsabilidades

### ✅ **Testabilidade**
- Cada módulo pode ser testado independentemente
- Mocks e fakes facilitados pela injeção de dependência
- Cobertura de testes por módulo

### ✅ **Manutenibilidade**
- Código organizado e bem estruturado
- Fácil localização de funcionalidades
- Refatoração segura por módulo

## 🔧 Tecnologias Utilizadas

- **Flutter**: Framework de UI
- **Dart**: Linguagem de programação
- **Melos**: Gerenciamento de monorepo
- **Supabase**: Backend as a Service
- **Provider**: Gerenciamento de estado
- **GoRouter**: Navegação
- **GetIt**: Injeção de dependência

## 👥 Equipe

- **Desenvolvedor Principal**: Bruno Marchi Pires
- **Arquitetura**: Clean Architecture + Modular Design
- **Metodologia**:  Clean Code

---

**🎓 Projeto de Estudo em Arquitetura Modular Flutter**

*Desenvolvido para explorar e demonstrar as melhores práticas de desenvolvimento de aplicações Flutter modulares.* 