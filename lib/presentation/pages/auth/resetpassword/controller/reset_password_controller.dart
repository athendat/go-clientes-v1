import 'package:flutter/material.dart';
import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';
import 'package:flutx/flutx.dart';
import 'package:client.gogogo/presentation/pages/auth/sign_in/login_ui.dart';
import 'package:client.gogogo/presentation/pages/home/screen/home_page.dart';

import '../../../../../data/providers/user_provider.dart';

class ResetPasswordController extends FxController {
  TickerProvider ticker;
  ResetPasswordController(this.ticker);
  late TextEditingController confirmPasswordTE, passwordTE;
  GlobalKey<FormState> formKey = GlobalKey();
  late AnimationController arrowController,
      passwordController,
      resetPasswordController;
  late Animation<Offset> arrowAnimation,
      passwordAnimation,
      resetPasswordAnimation;
  int passwordCounter = 0;
  int resetPasswordCounter = 0;
  bool passwordVisible = true;
  var inprogres = false;

  TextEditingController ad1 = TextEditingController();
  TextEditingController ad2 = TextEditingController();
  TextEditingController ad3 = TextEditingController();
  TextEditingController ad4 = TextEditingController();
  TextEditingController ad5 = TextEditingController();
  TextEditingController ad6 = TextEditingController();
  UserProvider up = UserProvider();

  @override
  void initState() {
    super.initState();
    confirmPasswordTE = TextEditingController(text: '');
    passwordTE = TextEditingController(text: '');
    arrowController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 500));
    passwordController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 50));
    resetPasswordController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 50));

    arrowAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(8, 0))
            .animate(CurvedAnimation(
      parent: arrowController,
      curve: Curves.easeIn,
    ));
    passwordAnimation =
        Tween<Offset>(begin: const Offset(-0.01, 0), end: const Offset(0.01, 0))
            .animate(CurvedAnimation(
      parent: passwordController,
      curve: Curves.easeIn,
    ));
    resetPasswordAnimation =
        Tween<Offset>(begin: const Offset(-0.01, 0), end: const Offset(0.01, 0))
            .animate(CurvedAnimation(
      parent: resetPasswordController,
      curve: Curves.easeIn,
    ));

    passwordController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        passwordController.reverse();
      }
      if (status == AnimationStatus.dismissed && passwordCounter < 2) {
        passwordController.forward();
        passwordCounter++;
      }
    });
    resetPasswordController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        resetPasswordController.reverse();
      }
      if (status == AnimationStatus.dismissed && resetPasswordCounter < 2) {
        resetPasswordController.forward();
        resetPasswordCounter++;
      }
    });
  }

  @override
  void dispose() {
    arrowController.dispose();
    passwordController.dispose();
    resetPasswordController.dispose();
    super.dispose();
  }

  /*String? validateConfirmPassword(String? text) {
    if (text == null || text.isEmpty) {
      resetPasswordController.forward();
      return "Please enter password";
    } else if (!FxStringValidator.validateStringRange(
      text,
    )) {
      resetPasswordController.forward();
      return "Password length must between 8 and 20";
    } else if (passwordTE.text != text) {
      resetPasswordController.forward();
      return "Both passwords are not same";
    }
    return null;
  }*/

  String? validatePassword12(String? pass) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (pass!.isEmpty) {
      return 'Porfavor introduzca la contraseña';
    } else {
      if (pass != passwordTE.text) {
        return "Las contraseñas no coinciden";
      } else if (!regex.hasMatch(pass)) {
        return 'Contraseña inválida, debe contener Mayúsculas ,\n minúsculas,números y caracteres especiales \n además de al menos 8 caracteres o más ';
      } else {
        return null;
      }
    }
  }

  String? validatePassword11(String? pass) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (pass!.isEmpty) {
      return 'Porfavor introduzca la contraseña';
    } else {
      if (pass != confirmPasswordTE.text) {
        return "Las contraseñas no coinciden";
      } else if (!regex.hasMatch(pass)) {
        return 'Contraseña inválida, debe contener Mayúsculas ,\n minúsculas,números y caracteres especiales \n además de al menos 8 caracteres o más ';
      } else {
        return null;
      }
    }
  }

  Future<void> resetPassword() async {
    resetPasswordCounter = 0;
    if (formKey.currentState!.validate()) {
      arrowController.forward();
      await Future.delayed(const Duration(milliseconds: 500));
      Navigator.of(context, rootNavigator: true).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    }
  }

  Future<void> recoverpass() async {
    if (formKey.currentState!.validate()) {
      inprogres = true;
      arrowController.forward();
      update();
      var code =
          ad1.text + ad2.text + ad3.text + ad4.text + ad5.text + ad6.text;
      var pass = passwordTE.text;
      var sms = "";
      var error = false;
      try {
        var signup = await up.recoverpass(code, pass);
        sms = signup.message;

        switch (signup.statusCode) {
          case 200:
            goToLogInScreen();
            break;
          case 400:
            arrowController.reverse();
            error = true;
            break;
          case 401:
            arrowController.reverse();
            error = true;
            break;
          case 403:
            arrowController.reverse();
            error = true;
            break;
          case 404:
            arrowController.reverse();
            error = true;
            break;

          default:
            arrowController.reverse();
            error = true;
            break;
        }
      } finally {
        inprogres = false;
        update();
        error
            ? AlertController.show(
                "Lo sentimos",
                sms,
                TypeAlert.error,
              )
            : AlertController.show(
                "Enhorabuena",
                sms,
                TypeAlert.success,
              );
      }
    }
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
        content: FxText.titleSmall(sms, color: theme.colorScheme.onPrimary),
        backgroundColor: theme.colorScheme.primary,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void goToLogInScreen() {
    Navigator.of(context, rootNavigator: true).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const SignInUI(),
      ),
    );
  }

  @override
  String getTag() {
    return "reset_password_controller";
  }

  Future<bool> onWillPop() async {
    Navigator.of(context, rootNavigator: true).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const SignInUI(),
      ),
    );
    return true;
  }
}
