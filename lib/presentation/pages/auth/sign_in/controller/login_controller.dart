import 'package:flutter/material.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../../../data/models/Dtos/auth/signin_dto.dart';
import '../../../home/screen/home_page.dart';
import '../../forgot/forgot_password_screen.dart';
import '../../sign_up/register_ui.dart';
import '../../../../../data/providers/user_provider.dart';
import 'package:flutter_dropdown_alert/alert_controller.dart';

class LogInController extends FxController {
  TickerProvider ticker;
  final UserProvider up = UserProvider();
  LogInController(this.ticker);
  late TextEditingController emailTE = TextEditingController(text: '');
  late TextEditingController passwordTE = TextEditingController(text: '');
  GlobalKey<FormState> formKey = GlobalKey();
  int emailCounter = 0;
  int passwordCounter = 0;
  var loginprogres = false.obs;
  bool passwordVisible = true;

  var remember = false.obs;

  @override
  Future<void> initState() async {
    super.initState();
    var box = await Hive.openBox('Session');
    box.isEmpty ? remember.value = false : remember.value = box.get('remember');

    if (remember.value) {
      emailTE.text = box.get('userc');
      passwordTE.text = box.get('password');
    } else {
      emailTE = TextEditingController(text: '');
      passwordTE = TextEditingController(text: '');
    }
    // existSession();
  }

  void existSession() async {
    var box = await Hive.openBox('SessionFR');
    switch (box.isNotEmpty) {
      case true:
        // ignore: use_build_context_synchronously
        Navigator.of(context, rootNavigator: true).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomePage(), //home page
          ),
        );
        break;
      default:
    }
  }

  String? validateEmail(String? text) {
    if (text == null || text.isEmpty) {
      return "Porfavor introduzca el correo";
    } else if (!FxStringUtils.isEmail(text)) {
      return "Porfavor introduzca un correo válido";
    }
    return null;
  }

  String? validatePassword(String? text) {
    if (text == null || text.isEmpty) {
      //  Info.error("Error al Iniciar Sesión", context: context);
      return "Porfavor introduzca su contraseña";
    } else if (!FxStringUtils.validateStringRange(
      text,
    )) {
      //   Info.error("Error al Iniciar Sesión", context: context);

      return "La contraseña debe tener entre 8 y 20 caracteres";
    }
    return null;
  }

  void goToForgotPasswordScreen() {
    Navigator.of(context, rootNavigator: true).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const ForgotPasswordScreen(),
      ),
    );
  }

  Future<void> login() async {
    loginprogres.value = true;
    update();
    emailCounter = 0;
    passwordCounter = 0;
    var sms = "";
    try {
      if (formKey.currentState!.validate()) {
        SignDto user = SignDto(email: emailTE.text, pwd: passwordTE.text);
        rememberpass();
        var login = await up.login(user);
        // var a = await up.loginaes(user);
        sms = login.message;
        //  loginprogres = false;

        switch (sms) {
          case "Usuario no activado":
            AlertController.show(
              "Error al iniciar Sesión",
              "Usuario no activado",
              TypeAlert.warning,
            );
            /* Navigator.of(context, rootNavigator: true).pushReplacement(
            MaterialPageRoute(
              builder: (context) =>
                  const Verification(), //cambiar por code confirm
            ),
          );*/
            break;
          case "Ha iniciado sesión correctamente":
            // ignore: use_build_context_synchronously

            /*   AlertController.show(
              "Inicio de Sesión",
              "Ha iniciado sesión correctamente",
              TypeAlert.success,
            );*/

            // ignore: use_build_context_synchronously
            Navigator.of(context, rootNavigator: true).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );

            break;
          case "Credenciales Inválidas":
            AlertController.show(
              "Error al iniciar Sesión",
              sms,
              TypeAlert.error,
            );
            //  context: context);
            // error = true;
            break;

          default:
            AlertController.show(
              "Error al iniciar Sesión",
              "Server Error",
              TypeAlert.error,
            );
        }

        loginprogres.value = false;
        update();
        //  await await Future.delayed(const Duration(milliseconds: 1000));
        /* Navigator.of(context, rootNavigator: true).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const SplashScreen2(),
        ),
      );*/
      }
    } catch (e) {
      // // print(e.toString());
    } finally {
      loginprogres.value = false;
      update();
    }
  }

  rememberpass() async {
    var box = await Hive.openBox('Session');
    box.put('userc', emailTE.text);
    box.put('password', passwordTE.text);
    box.put('remember', remember.value);
  }

  deleteremember() async {
    var box = await Hive.openBox('Session');
    box.put('userc', "");
    box.put('password', "");
    box.put('remember', remember.value);
  }

  void goToRegisterScreen(BuildContext context) {
    Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (context) => const SignUpUI(),
      ),
    );
    // Navigator.pushNamed(context, '/registro');
  }

  @override
  String getTag() {
    return "login_controller";
  }
}
