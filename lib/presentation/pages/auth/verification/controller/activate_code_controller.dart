import 'package:flutter/material.dart';
import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';
import 'package:flutx/flutx.dart';
import 'package:client.gogogo/presentation/pages/auth/sign_in/login_ui.dart';
import 'package:client.gogogo/presentation/pages/home/screen/home_page.dart';
import 'package:hive/hive.dart';

import '../../../../../data/providers/user_provider.dart';

class ActivateCodeController extends FxController {
  TickerProvider ticker;
  ActivateCodeController(this.ticker);
  late TextEditingController confirmPasswordTE, passwordTE;
  GlobalKey<FormState> formKey = GlobalKey();

  int passwordCounter = 0;
  int resetPasswordCounter = 0;
  var emailreg = "";
  var inprogres = false;

  TextEditingController ad1 = TextEditingController();
  TextEditingController ad2 = TextEditingController();
  TextEditingController ad3 = TextEditingController();
  TextEditingController ad4 = TextEditingController();
  TextEditingController ad5 = TextEditingController();
  TextEditingController ad6 = TextEditingController();
  UserProvider up = UserProvider();

  @override
  Future<void> initState() async {
    super.initState();
    var box = await Hive.openBox('RegFR');
    emailreg = box.get('emailreg').toString();
    update();
    confirmPasswordTE = TextEditingController(text: '');
    passwordTE = TextEditingController(text: '');
  }

  String? validatePassword(String? text) {
    if (text == null || text.isEmpty) {
      // passwordController.forward();
      return "Please enter password";
    } else if (!FxStringUtils.validateStringRange(
      text,
    )) {
      // passwordController.forward();
      return "Password length must between 8 and 20";
    }
    return null;
  }

  Future<void> resetPassword() async {
    resetPasswordCounter = 0;
    if (formKey.currentState!.validate()) {
      // arrowController.forward();
      await Future.delayed(const Duration(milliseconds: 500));
      Navigator.of(context, rootNavigator: true).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    }
  }

  Future<void> activate() async {
    resetPasswordCounter = 0;
    if (ad1.text.isNotEmpty &&
        ad2.text.isNotEmpty &&
        ad3.text.isNotEmpty &&
        ad4.text.isNotEmpty &&
        ad5.text.isNotEmpty &&
        ad6.text.isNotEmpty) {
      Navigator.of(context, rootNavigator: true).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    }
  }

  Future<void> recoverpass() async {
    // inprogress = true;
    var code = ad1.text + ad2.text + ad3.text + ad4.text + ad5.text + ad6.text;
    var pass = passwordTE.text;
    var sms = "";
    var error = false;
    try {
      var signup = await up.recoverpass(code, pass);
      sms = signup.message;

      switch (signup.statusCode) {
        case 200:
          //  Get.toNamed('/login');
          break;
        case 400:
          error = true;
          break;
        case 401:
          error = true;
          break;
        case 403:
          error = true;
          break;
        case 404:
          error = true;
          break;

        default:
          error = true;
          break;
      }
    } finally {
      // inprogressactivef.value = false;
    }
  }

  Future<void> activateu() async {
    inprogres = true;
    update();
    var sms = "";
    bool error = false;
    try {
      // box.put('emailreg', "andieldev@gmail.com");
      if (ad1.text.isNotEmpty &&
          ad2.text.isNotEmpty &&
          ad3.text.isNotEmpty &&
          ad4.text.isNotEmpty &&
          ad5.text.isNotEmpty &&
          ad6.text.isNotEmpty) {
        var code =
            ad1.text + ad2.text + ad3.text + ad4.text + ad5.text + ad6.text;

        var signup = await up.activate(code);
        sms = signup.message;

        switch (signup.statusCode) {
          case 404:
            resetTextConfirm();
            Navigator.of(context, rootNavigator: true).pushReplacement(
              MaterialPageRoute(
                builder: (context) => Container(), //Reset pasword
              ),
            );
            break;
          case 200:
            await Hive.deleteBoxFromDisk('RegFR');
            sms = "Se ha activado el usuario correctamente";
            Navigator.of(context, rootNavigator: true).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const SignInUI(),
              ),
            );
            break;

          default:
            error = true;
            sms = "Server Error!";
        }
      } else {
        error = true;
        sms = "Porvavor introduzca correctamente el codigo de activacion!";
      }
    } finally {
      inprogres = false;
      update();
      error
          ? AlertController.show(
              "Error al activar el usuario",
              sms,
              TypeAlert.error,
            )
          : AlertController.show(
              "Activacion Satisfactoria",
              sms,
              TypeAlert.success,
            );
    }
  }

  void resetTextConfirm() {
    ad1.clear();
    ad2.clear();
    ad3.clear();
    ad4.clear();
    ad5.clear();
    ad6.clear();
    update();
  }

  void showSnackBarWithFloatingError(String sms) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: FxText.titleSmall(sms, color: theme.colorScheme.onPrimary),
        backgroundColor: theme.colorScheme.error,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void showSnackBarWithFloating(String sms) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: FxText.titleSmall(sms, color: theme.colorScheme.primary),
        backgroundColor: theme.colorScheme.primary,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  String getTag() {
    return "reset_password_controller";
  }
}
