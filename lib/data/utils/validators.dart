import 'dart:core';

import 'package:flutx/flutx.dart';

class Validators {
  String? validateText(String? text) {
    if (text == null || text.isEmpty) {
      return "Porfavor introduzca el texto";
    }
    return null;
  }

  String? validatenumb(String? text) {
    if (text == null || text.isEmpty) {
      return "Porfavor introduzca el texto";
    } else if (!FxStringUtils.isDigitIncluded(text)) {
      return "Porfavor introduzca un correo válido";
    }
    return null;
  }

  String? validateEmail(String? text) {
    if (text == null || text.isEmpty) {
      return "Porfavor introduzca el correo";
    } else if (!FxStringUtils.isEmail(text)) {
      return "Porfavor introduzca un correo válido";
    }
    return null;
  }
}
