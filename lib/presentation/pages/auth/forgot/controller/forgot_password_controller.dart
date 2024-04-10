import 'package:flutter/material.dart';
import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';
import 'package:flutx/flutx.dart';
import 'package:client.gogogo/presentation/pages/auth/sign_up/register_ui.dart';

import '../../../../../data/providers/user_provider.dart';
import '../../resetpassword/reset_password_screen.dart';

class ForgotPasswordController extends FxController {
  TickerProvider ticker;
  ForgotPasswordController(this.ticker);
  late TextEditingController emailTE;
  GlobalKey<FormState> formKey = GlobalKey();
  late AnimationController arrowController, emailController;
  late Animation<Offset> arrowAnimation, emailAnimation;
  int emailCounter = 0;
  var inprogres = false;
  UserProvider up = UserProvider();

  TextEditingController ad1 = TextEditingController();
  TextEditingController ad2 = TextEditingController();
  TextEditingController ad3 = TextEditingController();
  TextEditingController ad4 = TextEditingController();
  TextEditingController ad5 = TextEditingController();
  TextEditingController ad6 = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailTE = TextEditingController();
    arrowController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 500));
    emailController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 50));

    arrowAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(8, 0))
            .animate(CurvedAnimation(
      parent: arrowController,
      curve: Curves.easeIn,
    ));
    emailAnimation =
        Tween<Offset>(begin: const Offset(-0.01, 0), end: const Offset(0.01, 0))
            .animate(CurvedAnimation(
      parent: emailController,
      curve: Curves.easeIn,
    ));
    emailController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        emailController.reverse();
      }
      if (status == AnimationStatus.dismissed && emailCounter < 2) {
        emailController.forward();
        emailCounter++;
      }
    });
  }

  @override
  void dispose() {
    arrowController.dispose();
    emailController.dispose();
    super.dispose();
  }

  String? validateEmail(String? text) {
    if (text == null || text.isEmpty) {
      emailController.forward();
      return "Porfavor introduzca su email";
    } else if (!FxStringUtils.isEmail(text)) {
      emailController.forward();
      return "Porfavor introduzca un email valido";
    }
    return null;
  }

  Future<void> goToResetPasswordScreen() async {
    emailCounter = 0;
    if (formKey.currentState!.validate()) {
      arrowController.forward();
      await Future.delayed(const Duration(milliseconds: 500));
      Navigator.of(context, rootNavigator: true).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>
              const ResetPasswordScreen(), //reset password page
        ),
      );
    }
  }

  Future<void> forgotpass() async {
    inprogres = true;
    update();
    var email = emailTE.text;
    var sms = "";
    var error = false;
    try {
      var signup = await up.forgotpass(email);
      sms = signup.message;

      switch (signup.statusCode) {
        case 200:
          goToResetPasswordScreen();
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

        default:
          error = true;
      }
    } finally {
      inprogres = false;
      update();
      error
          ? AlertController.show(
              "Error",
              sms,
              TypeAlert.error,
            )
          : AlertController.show(
              "Ok",
              sms,
              TypeAlert.success,
            );
    }
  }

  void goToRegisterScreen() {
    Navigator.of(context, rootNavigator: true).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const SignUpUI(), //SignUpUI(),
      ),
    );
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

  @override
  String getTag() {
    return "forgot_password_controller";
  }
}
