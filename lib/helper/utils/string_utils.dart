
import 'package:flutter_pw_validator/Resource/Strings.dart';

class ValidationUtils {
  static bool isStingEmpty(String string) {
    return string.trim().isEmpty ? true : false;
  }

  static bool validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10}$)';
    RegExp regExp =  RegExp(pattern);
    if (isStingEmpty(value)) {
      return false;
    } else if (!regExp.hasMatch(value)) {
      return false;
    }
    return true;
  }

  static bool validateEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    return (!RegExp(pattern).hasMatch(value!)) ? false : true;
  }

  static bool validateRut(String? value) {
    String pattern =
        r'^(\d{1,3}(?:\.\d{1,3}){2}-[\dkK])$';
    return (!RegExp(pattern).hasMatch(value!)) ? false : true;
  }

  static bool validateNumber(String? value) {
    String pattern =
        r'^[0-9]*$';
    return (!RegExp(pattern).hasMatch(value!)) ? false : true;
  }

}


class   SpanishString implements FlutterPwValidatorStrings {
  @override
  final String atLeast = 'Al menos - carácteres';
  @override
  final String uppercaseLetters = '- Letra mayúscula';
  @override
  final String numericCharacters = '- Carácter numérico';
  @override
  final String specialCharacters = '- Personaje especial';
  @override
  final String normalLetters = "- Carta";
}