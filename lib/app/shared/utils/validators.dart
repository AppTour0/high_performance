import 'dart:async';
import 'package:high_performance/app/shared/utils/utils.dart';

enum CardType {
  otherBrand,
  mastercard,
  visa,
  hipercard,
  elo,
  amex,
}

class Validators {
  Utils utils = Utils();

  /* final validateEmail = StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (EmailValidator.validate(email.trim().toLowerCase()) == true) {
      sink.add(email);
    } else {
      sink.addError('Digite um email válido!');
    }
  });

  String validateEmailForm(val) {
    if (val.isEmpty) {
      return "Não pode ser vazio";
    } else if (!EmailValidator.validate(val)) {
      return 'Digite um email válido!';
    }else
      return null;
  }

  String validateEmailConfirmForm({
    String val,
    String lastEmail
  }) {
    if (val.isEmpty) {
      return "Não pode ser vazio";
    } else if (!EmailValidator.validate(val.trim().toLowerCase())) {
      return 'Digite um email válido!';
    }else if (val.trim().toLowerCase() != lastEmail.trim().toLowerCase()) {
      return 'Os emails não correspondem!';
    }else
      return null;
  }

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    double strength = estimatePasswordStrength(password);

    if (password.isEmpty){
      sink.addError('Digite uma senha!');
    }else if(password.length < 8){
        sink.addError('A senha precisa ter no mínimo de 8 caracteres');
    }else if(strength < 0.3){
      sink.addError('Tente misturar letras, números\ne caracteres especiais');
    } else {
      sink.add(password);
    }
  }); */

  final validatePasswordConfirm =
      StreamTransformer<Map<String, String>, String>.fromHandlers(
          handleData: (data, sink) {
    if (data.isEmpty || data == null) {
      sink.addError('Digite uma senha!');
    }
    if (data[0].length > 0) {
      String password = data[0];
      String name = data[1];
      String lastName = data[2];
      String email = data[3];

      if (password.length < 8) {
        sink.addError('A senha precisa ter no mínimo de 8 caracteres');
      } else if (password.contains(name) ||
          password.contains(lastName) ||
          email.contains(password) ||
          name.contains(password) ||
          lastName.contains(password)) {
        sink.addError('A senha não pode haver seu nome ou trecho do email');
      } else {
        sink.add(password);
      }
    }
  });

  String validatePasswordLogin({String val, String lastEmail}) {
    if (val.isEmpty) {
      return "Não pode ser vazio";
    } else if (val.length < 8) {
      return 'Mínimo de 8 caracteres';
    } else
      return null;
  }

  // senha forte
  static bool strengthPass(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  /* String validatePasswordForm({
    String val,
  }) {
    double strength = estimatePasswordStrength(val);

    if (val.isEmpty){
      return "Digite uma senha!";
    }else if(val.length < 8){
      return 'A senha precisa ter no mínimo de 8 caracteres';
    }else if(strength < 0.3){
      return 'Tente misturar letras, números\ne caracteres especiais';
    }else{
      return null;
    }
  } */

  String validatePasswordConfirmForm({String val, String lastPass}) {
    if (val.isEmpty) {
      return "Não pode ser vazio";
    } else if (val.length < 8) {
      return "A senha precisa ter no mínimo 8 caracteres.";
    } else if (val != lastPass) {
      return 'As senhas não correspondem!';
    } else
      return null;
  }

  final validateName =
      StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (name.length > 3) {
      sink.add(name);
    } else {
      sink.addError('Precisa ter mais do que 3 caracteres.');
    }
  });

  String validateNameForm(val) {
    if (val.isEmpty) {
      return "Não pode ser vazio";
    } else if (val.length < 3) {
      return "O nome precisa ter mais do que 3 caracteres.";
    } else
      return null;
  }

  final validateLastName =
      StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (name.length > 3) {
      sink.add(name);
    } else {
      sink.addError('O sobrenome precisa ter mais do que 3 caracteres.');
    }
  });

  final validateDescription =
      StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (name.length > 20) {
      sink.add(name);
    } else {
      sink.addError('Faça uma descrição um pouco maior.');
    }
  });

  final validateCellphone =
      StreamTransformer<String, String>.fromHandlers(handleData: (phone, sink) {
    if (phone.length > 14) {
      sink.add(phone);
    } else {
      sink.addError('Número pequeno para ser válido.');
    }
  });

  String validatePhoneForm(val) {
    if (val.isEmpty) {
      return "Não pode ser vazio";
    } else if (val.length < 12) {
      return "Número pequeno para ser válido.";
    } else
      return null;
  }

  String validateDescriptionForm(val) {
    if (val.isEmpty) {
      return "Não pode ser vazio";
    } else if (val.length < 15) {
      return "Deve ter mais que 15 caracteres";
    } else
      return null;
  }

  final validateAmount = StreamTransformer<String, String>.fromHandlers(
      handleData: (amount, sink) {
    if (amount == "") {
      sink.addError('O valor não pode ser vazio.');
    } else if (num.tryParse(amount) > 0) {
      sink.add(amount);
    } else {
      sink.addError('O valor não pode ser zero.');
    }
  });

  final validateDate = StreamTransformer<DateTime, DateTime>.fromHandlers(
      handleData: (date, sink) {
    if (date != null) {
      sink.add(date);
    } else {
      sink.addError('Selecione uma data.');
    }
  });

  /* final validateCPF = StreamTransformer<String, String>.fromHandlers(
      handleData: (cpf, sink) {
    if (CPFValidator.isValid(cpf)) {
      sink.add(cpf);
    } else {
      sink.addError('CPF inválido!');
    }
  });

  String validateCPFForm(val) {
    if (val.isEmpty) {
      return "Não pode ser vazio!";
    } else if (!CPFValidator.isValid(val)) {
      return "CPF inválido!";
    } else
      return null;
  }

  String validateCNPJForm(val) {
    if (val.isEmpty) {
      return "Não pode ser vazio!";
    } else if (!CNPJValidator.isValid(val)) {
      return "CNPJ inválido!";
    } else
      return null;
  } */

  String validateNotEmptyForm(val) {
    if (val.isEmpty) {
      return "Não pode ser vazio";
    } else
      return null;
  }

  String validateEmpty(val) {
    return null;
  }

  String validatePriceForm(String val) {
    var test = utils.parsePriceToDouble(val);
    if (val.isEmpty) {
      return "Não pode ser vazio";
    } else if (test == 0.00) {
      return "Não pode ser 0";
    } else
      return null;
  }

  final validateCardCVV =
      StreamTransformer<String, String>.fromHandlers(handleData: (cvv, sink) {
    if (cvv.length == 3) {
      sink.add(cvv);
    } else {
      sink.addError('Código inválido!');
    }
  });

  final validateCardDateStream =
      StreamTransformer<String, String>.fromHandlers(handleData: (date, sink) {
    var now = new DateTime.now();
    int month = 0;
    int year = 0;

    if (date.length > 1) {
      month = int.parse(date.substring(0, 2));
    }
    if (date.length > 4) {
      year = int.parse(date.substring(3));
    }

    if ((month >= 1) && (month <= 12)) {
      if (year > now.year) {
        sink.add(date);
      } else if (year == now.year && month >= now.month) {
        sink.add(date);
      } else {
        sink.addError('Data inválida!');
      }
    } else {
      sink.addError('Data inválida!');
    }
  });

  final validatePolicy =
      StreamTransformer<bool, bool>.fromHandlers(handleData: (policy, sink) {
    if (policy) {
      sink.add(policy);
    } else {
      sink.addError('É necessário concordar com os termos!');
    }
  });

  /// This function determines the Credit Card type based on the cardPatterns
  /// and returns it.
  final validateCardNumber = StreamTransformer<String, String>.fromHandlers(
      handleData: (cardNumber, sink) {
    /// Credit Card prefix patterns as of March 2019
    /// A [List<String>] represents a range.
    /// i.e. ['51', '55'] represents the range of cards starting with '51' to those starting with '55'
    Map<CardType, Set<List<String>>> cardNumPatterns =
        <CardType, Set<List<String>>>{
      CardType.visa: <List<String>>{
        <String>['4'],
      },
      CardType.mastercard: <List<String>>{
        <String>['51', '55'],
        <String>['2221', '2229'],
        <String>['223', '229'],
        <String>['23', '26'],
        <String>['270', '271'],
        <String>['2720'],
      },
      CardType.hipercard: <List<String>>{
        <String>['606282'],
        <String>['637095'],
        <String>['637568'],
        <String>['637599'],
        <String>['637609'],
        <String>['637612'],
      },
      CardType.amex: <List<String>>{
        <String>['34'],
        <String>['37'],
      },
      CardType.elo: {
        ['401178'],
        ['401179'],
        ['438935'],
        ['457631'],
        ['457632'],
        ['431274'],
        ['451416'],
        ['457393'],
        ['504175'],
        ['506699', '506778'],
        ['509000', '509999'],
        ['627780'],
        ['636297'],
        ['636368'],
        ['650031', '650033'],
        ['650035', '650051'],
        ['650405', '650439'],
        ['650485', '650538'],
        ['650541', '650598'],
        ['650700', '650718'],
        ['650720', '650727'],
        ['650901', '650978'],
        ['651652', '651679'],
        ['655000', '655019'],
        ['655021', '655058'],
      },
    };

    //Default card type is other
    CardType cardType = CardType.otherBrand;

    cardNumPatterns.forEach(
      (CardType type, Set<List<String>> patterns) {
        for (List<String> patternRange in patterns) {
          // Remove any spaces
          String ccPatternStr =
              cardNumber.replaceAll(RegExp(r'\s+\b|\b\s'), '');
          final int rangeLen = patternRange[0].length;
          // Trim the Credit Card number string to match the pattern prefix length
          if (rangeLen < cardNumber.length) {
            ccPatternStr = ccPatternStr.substring(0, rangeLen);
          }

          if (patternRange.length > 1 && ccPatternStr != "") {
            // Convert the prefix range into numbers then make sure the
            // Credit Card num is in the pattern range.
            // Because Strings don't have '>=' type operators
            final int ccPrefixAsInt = int.parse(ccPatternStr);
            final int startPatternPrefixAsInt = int.parse(patternRange[0]);
            final int endPatternPrefixAsInt = int.parse(patternRange[1]);
            if (ccPrefixAsInt >= startPatternPrefixAsInt &&
                ccPrefixAsInt <= endPatternPrefixAsInt) {
              // Found a match
              cardType = type;
              break;
            }
          } else {
            // Just compare the single pattern prefix with the Credit Card prefix
            if (ccPatternStr == patternRange[0]) {
              // Found a match
              cardType = type;
              break;
            }
          }
        }
      },
    );

    if (cardType.index > 0 && cardNumber.length >= 19) {
      sink.add(cardNumber);
    } else {
      sink.addError('Cartão inválido!');
    }
  });
}

class ValidatorsForm {
  validateCardDate(date) {
    var now = new DateTime.now();
    int month = 0;
    int year = 0;
    int yearNow = int.tryParse(now.year.toString().substring(2));

    if (date.length > 1) {
      month = int.parse(date.substring(0, 2));
    }
    if (date.length > 4) {
      year = int.parse(date.substring(3));
    }

    if ((month >= 1) && (month <= 12)) {
      if (year > yearNow) {
        return true;
      } else if (year == yearNow && month >= now.month) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  /// This function determines the Credit Card type based on the cardPatterns
  /// and returns it.
  validateCardNumber(cardNumber) {
    /// Credit Card prefix patterns as of March 2019
    /// A [List<String>] represents a range.
    /// i.e. ['51', '55'] represents the range of cards starting with '51' to those starting with '55'
    Map<CardType, Set<List<String>>> cardNumPatterns =
        <CardType, Set<List<String>>>{
      CardType.visa: <List<String>>{
        <String>['4'],
      },
      CardType.mastercard: <List<String>>{
        <String>['51', '55'],
        <String>['2221', '2229'],
        <String>['223', '229'],
        <String>['23', '26'],
        <String>['270', '271'],
        <String>['2720'],
      },
      CardType.hipercard: <List<String>>{
        <String>['606282'],
        <String>['637095'],
        <String>['637568'],
        <String>['637599'],
        <String>['637609'],
        <String>['637612'],
      },
      CardType.amex: <List<String>>{
        <String>['34'],
        <String>['37'],
      },
      CardType.elo: {
        ['401178'],
        ['401179'],
        ['438935'],
        ['457631'],
        ['457632'],
        ['431274'],
        ['451416'],
        ['457393'],
        ['504175'],
        ['506699', '506778'],
        ['509000', '509999'],
        ['627780'],
        ['636297'],
        ['636368'],
        ['650031', '650033'],
        ['650035', '650051'],
        ['650405', '650439'],
        ['650485', '650538'],
        ['650541', '650598'],
        ['650700', '650718'],
        ['650720', '650727'],
        ['650901', '650978'],
        ['651652', '651679'],
        ['655000', '655019'],
        ['655021', '655058'],
      },
    };

    //Default card type is other
    CardType cardType = CardType.otherBrand;

    cardNumPatterns.forEach(
      (CardType type, Set<List<String>> patterns) {
        for (List<String> patternRange in patterns) {
          // Remove any spaces
          String ccPatternStr =
              cardNumber.replaceAll(RegExp(r'\s+\b|\b\s'), '');
          final int rangeLen = patternRange[0].length;
          // Trim the Credit Card number string to match the pattern prefix length
          if (rangeLen < cardNumber.length) {
            ccPatternStr = ccPatternStr.substring(0, rangeLen);
          }

          if (patternRange.length > 1 && ccPatternStr != "") {
            // Convert the prefix range into numbers then make sure the
            // Credit Card num is in the pattern range.
            // Because Strings don't have '>=' type operators
            final int ccPrefixAsInt = int.parse(ccPatternStr);
            final int startPatternPrefixAsInt = int.parse(patternRange[0]);
            final int endPatternPrefixAsInt = int.parse(patternRange[1]);
            if (ccPrefixAsInt >= startPatternPrefixAsInt &&
                ccPrefixAsInt <= endPatternPrefixAsInt) {
              // Found a match
              cardType = type;
              break;
            }
          } else {
            // Just compare the single pattern prefix with the Credit Card prefix
            if (ccPatternStr == patternRange[0]) {
              // Found a match
              cardType = type;
              break;
            }
          }
        }
      },
    );

    if (cardType.index == 5 && cardNumber.length >= 18) {
      return true;
    } else if (cardType.index > 0 && cardNumber.length >= 19) {
      return true;
    } else {
      return false;
    }
  }
}
