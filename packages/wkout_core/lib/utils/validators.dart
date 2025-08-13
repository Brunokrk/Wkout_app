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

  static StringValidator birthDate({
    String emptyMessage = 'Informe sua data de nascimento',
    String formatMessage = 'Formato inválido. Use DD/MM/AAAA',
    String invalidDateMessage = 'Data inválida',
    String ageMessage = 'Você deve ter pelo menos 13 anos',
    int minAge = 13,
  }) {
    return (value) {
      final text = (value ?? '').trim();
      if (text.isEmpty) return emptyMessage;
      
      // Verifica o formato DD/MM/AAAA
      final dateRegex = RegExp(r'^(\d{2})/(\d{2})/(\d{4})$');
      final match = dateRegex.firstMatch(text);
      
      if (match == null) return formatMessage;
      
      final day = int.tryParse(match.group(1)!);
      final month = int.tryParse(match.group(2)!);
      final year = int.tryParse(match.group(3)!);
      
      if (day == null || month == null || year == null) return formatMessage;
      
      // Valida se a data é válida
      try {
        final date = DateTime(year, month, day);
        
        // Verifica se a data criada corresponde aos valores informados
        if (date.day != day || date.month != month || date.year != year) {
          return invalidDateMessage;
        }
        
        // Verifica se a data não é no futuro
        final now = DateTime.now();
        if (date.isAfter(now)) {
          return 'Data de nascimento não pode ser no futuro';
        }
        
        // Verifica a idade mínima
        final age = now.year - date.year;
        final monthDiff = now.month - date.month;
        final dayDiff = now.day - date.day;
        
        int actualAge = age;
        if (monthDiff < 0 || (monthDiff == 0 && dayDiff < 0)) {
          actualAge--;
        }
        
        if (actualAge < minAge) {
          return ageMessage;
        }
        
        return null;
      } catch (e) {
        return invalidDateMessage;
      }
    };
  }
}

