typedef StringValidator = String? Function(String? value);

class Validators {
  static StringValidator required({String message = 'Campo obrigatório'}) {
    return (value) {
      final text = (value ?? '').trim();
      if (text.isEmpty) return message;
      return null;
    };
  }

  static StringValidator fullName({
    String emptyMessage = 'Informe seu nome completo',
    String partsMessage = 'Informe nome e sobrenome',
    int minLength = 3,
    String shortMessage = 'Nome muito curto',
  }) {
    return (value) {
      final text = (value ?? '').trim();
      if (text.isEmpty) return emptyMessage;
      if (text.length < minLength) return shortMessage;
      if (text.split(RegExp(r'\s+')).length < 2) return partsMessage;
      return null;
    };
  }

  static StringValidator email({String invalidMessage = 'E-mail inválido'}) {
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    return (value) {
      final text = (value ?? '').trim();
      if (text.isEmpty) return 'Informe seu e-mail';
      if (!emailRegex.hasMatch(text)) return invalidMessage;
      return null;
    };
  }

  static StringValidator password({
    int minLength = 8,
    String emptyMessage = 'Informe uma senha',
    String lengthMessage = 'Mínimo de 8 caracteres',
    String compositionMessage = 'Use letras e números',
  }) {
    final hasLetterRegex = RegExp(r'[A-Za-z]');
    final hasNumberRegex = RegExp(r'\d');
    return (value) {
      final text = (value ?? '').trim();
      if (text.isEmpty) return emptyMessage;
      if (text.length < minLength) return lengthMessage;
      if (!hasLetterRegex.hasMatch(text) || !hasNumberRegex.hasMatch(text)) {
        return compositionMessage;
      }
      return null;
    };
  }
}

