# My Tasks - Flutter

Aplicação de Lista de Tarefas desenvolvida com Flutter. Funciona em Android, iOS, Web e Desktop.

## 🎯 Características

- ✅ Criar, editar e deletar tarefas
- 📱 Interface responsiva e intuitiva
- 💾 Armazenamento local com SQLite
- 🎨 Modo claro e escuro
- 🏷️ Categorias de tarefas
- ⭐ Marcar como importante
- 📊 Estatísticas em tempo real
- 📤 Exportar tarefas em JSON
- 🔔 Notificações locais
- 📱 Sincronização automática

## 🚀 Instalação e Setup

### Pré-requisitos

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (versão 3.0+)
- [Android Studio](https://developer.android.com/studio) ou [Xcode](https://developer.apple.com/xcode/)
- Git

### Passos de Instalação

```bash
# Clone o repositório
git clone https://github.com/torsyvet1-cloud/Wegah-Galaga-Arcade.git
cd flutter-my-tasks

# Obtenha as dependências
flutter pub get

# Execute o app em desenvolvimento
flutter run
```

## 📦 Build para Android

### Gerar APK (Debug)

```bash
flutter build apk --debug
```

### Gerar APK (Release)

```bash
flutter build apk --release
```

O arquivo APK estará em: `build/app/outputs/flutter-apk/app-release.apk`

### Gerar AAB (Android App Bundle)

```bash
flutter build appbundle --release
```

O arquivo AAB estará em: `build/app/outputs/bundle/release/app-release.aab`

### Configurar Assinatura

Crie um arquivo `android/key.properties`:

```properties
storePassword=sua_senha
keyPassword=sua_senha_chave
keyAlias=minha_chave
storePath=caminho/para/chave.jks
```

## 🏢 Publicar na Google Play Store

### 1. Criar AAB assinado

```bash
flutter build appbundle --release
```

### 2. Acessar Google Play Console

- Vá para [Google Play Console](https://play.google.com/console)
- Crie um novo app
- Faça upload do AAB
- Preencha informações da loja
- Envie para análise

## 📂 Estrutura do Projeto

```
flutter-my-tasks/
├── lib/
│   ├── main.dart                 # Ponto de entrada
│   ├── models/
│   │   └── task.dart            # Modelo de tarefa
│   ├── screens/
│   │   ├── home_screen.dart      # Tela principal
│   │   ├── task_detail_screen.dart
│   │   └── settings_screen.dart
│   ├── providers/
│   │   └── task_provider.dart    # State management
│   ├── database/
│   │   └── database_helper.dart  # Gerenciador de BD
│   ├── widgets/
│   │   ├── task_item.dart        # Widget de tarefa
│   │   ├── task_form.dart        # Formulário de tarefa
│   │   └── stat_card.dart
│   └── utils/
│       ├── constants.dart        # Constantes
│       └── theme.dart            # Temas
├── pubspec.yaml                 # Dependências
├── android/                     # Configuração Android
├── ios/                         # Configuração iOS
└── README.md
```

## 📚 Dependências Principais

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.0.0              # State management
  sqflite: ^2.2.0               # Banco de dados SQLite
  path_provider: ^2.0.0         # Acesso a diretórios
  intl: ^0.18.0                 # Internacionalização
  flutter_local_notifications: ^14.0.0
  shared_preferences: ^2.0.0
  json_annotation: ^4.8.0
```

## 🎨 Temas

### Modo Claro
- Cores principais: Azul e Roxo
- Fundo: Branco
- Texto: Preto escuro

### Modo Escuro
- Cores principais: Azul e Roxo
- Fundo: Cinza escuro
- Texto: Branco

## 🛠️ Desenvolvimento

### Executar testes

```bash
flutter test
```

### Gerar código (JSON serialization)

```bash
flutter pub run build_runner build
```

### Formato de código

```bash
flutter format lib/
```

### Análise de código

```bash
flutter analyze
```

## 📱 Plataformas Suportadas

- ✅ **Android** 5.0+ (API 21+)
- ✅ **iOS** 11.0+
- ✅ **Web** (Chrome, Firefox, Safari)
- ✅ **Windows**
- ✅ **macOS**
- ✅ **Linux**

## 🐛 Bugs Conhecidos

Nenhum no momento! Reporte issues no [GitHub Issues](https://github.com/torsyvet1-cloud/Wegah-Galaga-Arcade/issues)

## 📝 Licença

MIT License - veja LICENSE para detalhes

## 👨‍💻 Autor

Desenvolvido com ❤️ por **Wegah**

## 🤝 Contribuindo

Contribuições são bem-vindas! Por favor:

1. Fork o projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 📞 Suporte

Para suporte, abra uma issue no GitHub ou entre em contato.

---

**Aproveite o app! 🚀📱**