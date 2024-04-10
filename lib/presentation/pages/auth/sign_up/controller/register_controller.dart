import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';
import 'package:flutx/flutx.dart';
import 'package:client.gogogo/presentation/pages/auth/sign_in/login_ui.dart';
import 'package:hive/hive.dart';

import '../../../../../data/models/Dtos/auth/signup_dto.dart';
import '../../../../../data/providers/user_provider.dart';
import '../../verification/activate_code_page.dart';

class RegisterController extends FxController {
  TickerProvider ticker;

  bool passwordVisible = true;
  RegisterController(this.ticker);
  late TextEditingController nameTE,
      emailTE,
      lastnameTE,
      seglastnameTE,
      passwordTE,
      passwordTEE;
  GlobalKey<FormState> formKey = GlobalKey();
  late AnimationController arrowController,
      nameController,
      emailController,
      passwordController,
      lastnameController,
      seglastnameController;
  UserProvider up = UserProvider();

  late Animation<Offset> arrowAnimation,
      nameAnimation,
      lastnameAnimation,
      seglastnameAnimation,
      emailAnimation,
      passwordAnimation;
  int nameCounter = 0;
  int emailCounter = 0;
  int passwordCounter = 0;
  int lastnameCounter = 0;
  int seglastnameCounter = 0;
  bool inprogress = false;

  @override
  void initState() {
    super.initState();
    nameTE = TextEditingController();
    emailTE = TextEditingController();
    passwordTE = TextEditingController();
    passwordTEE = TextEditingController();
    lastnameTE = TextEditingController();
    seglastnameTE = TextEditingController();

    arrowController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 500));
    nameController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 50));
    emailController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 50));
    passwordController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 50));
    lastnameController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 50));
    seglastnameController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 50));
    arrowAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(8, 0))
            .animate(CurvedAnimation(
      parent: arrowController,
      curve: Curves.easeIn,
    ));
    nameAnimation =
        Tween<Offset>(begin: const Offset(-0.01, 0), end: const Offset(0.01, 0))
            .animate(CurvedAnimation(
      parent: nameController,
      curve: Curves.easeIn,
    ));
    emailAnimation =
        Tween<Offset>(begin: const Offset(-0.01, 0), end: const Offset(0.01, 0))
            .animate(CurvedAnimation(
      parent: emailController,
      curve: Curves.easeIn,
    ));
    passwordAnimation =
        Tween<Offset>(begin: const Offset(-0.01, 0), end: const Offset(0.01, 0))
            .animate(CurvedAnimation(
      parent: passwordController,
      curve: Curves.easeIn,
    ));
    lastnameAnimation =
        Tween<Offset>(begin: const Offset(-0.01, 0), end: const Offset(0.01, 0))
            .animate(CurvedAnimation(
      parent: lastnameController,
      curve: Curves.easeIn,
    ));
    seglastnameAnimation =
        Tween<Offset>(begin: const Offset(-0.01, 0), end: const Offset(0.01, 0))
            .animate(CurvedAnimation(
      parent: seglastnameController,
      curve: Curves.easeIn,
    ));

    nameController.addStatusListener((status) {
      log(status.toString());
      if (status == AnimationStatus.completed) {
        nameController.reverse();
      }
      if (status == AnimationStatus.dismissed && nameCounter < 2) {
        nameController.forward();
        nameCounter++;
      }
    });
    emailController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        emailController.reverse();
      }
      if (status == AnimationStatus.dismissed && emailCounter < 2) {
        emailController.forward();
        emailCounter++;
      }
    });
    passwordController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        passwordController.reverse();
      }
      if (status == AnimationStatus.dismissed && passwordCounter < 2) {
        passwordController.forward();
        passwordCounter++;
      }
    });
    lastnameController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        lastnameController.reverse();
      }
      if (status == AnimationStatus.dismissed && lastnameCounter < 2) {
        lastnameController.forward();
        lastnameCounter++;
      }
    });
    seglastnameController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        seglastnameController.reverse();
      }
      if (status == AnimationStatus.dismissed && seglastnameCounter < 2) {
        seglastnameController.forward();
        seglastnameCounter++;
      }
    });
  }

  String? validateEmail(String? text) {
    if (text == null || text.isEmpty) {
      emailController.forward();
      return "Porfavor introduzca el email";
    } else if (!FxStringUtils.isEmail(text)) {
      emailController.forward();
      return "Porfavor introduzca un email valido";
    }
    return null;
  }

  String? validatePassword(String? text) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (text == null || text.isEmpty) {
      passwordController.forward();

      return "Porfavor introduzca la contraseña";
    } else if (!regex.hasMatch(text)) {
      passwordController.forward();

      return "Contraseña inválida, debe contener Mayúsculas ,\n minúsculas,números y caracteres especiales \n además de al menos 8 caracteres o más ";
    }
    return null;
  }

  String? validateName(String? text) {
    if (text == null || text.isEmpty) {
      nameController.forward();
      return "Porfavor introduzca el nombre";
    } else if (!FxStringUtils.validateStringRange(text, 4, 20)) {
      nameController.forward();
      return "Password length must between 4 and 20";
    }
    return null;
  }

  String? validateLastName(String? text) {
    if (text == null || text.isEmpty) {
      lastnameController.forward();
      return "Porfavor introduzca el apellido";
    } else if (!FxStringUtils.validateStringRange(text, 4, 40)) {
      lastnameController.forward();
      return "Los Apellidos deben contener de 4 a 40 caracteres";
    }
    return null;
  }

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
      if (pass != passwordTEE.text) {
        return "Las contraseñas no coinciden";
      } else if (!regex.hasMatch(pass)) {
        return 'Contraseña inválida, debe contener Mayúsculas ,\n minúsculas,números y caracteres especiales \n además de al menos 8 caracteres o más ';
      } else {
        return null;
      }
    }
  }

  @override
  void dispose() {
    arrowController.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> register() async {
    passwordCounter = 0;
    nameCounter = 0;
    emailCounter = 0;
    if (formKey.currentState!.validate()) {
      arrowController.forward();
      await Future.delayed(const Duration(milliseconds: 500));
      Navigator.of(context, rootNavigator: true).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const SignInUI(),
        ),
      );
    }
  }

  void goToActivateScreen() {
    Navigator.of(context, rootNavigator: true).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const ActivationCodePage(),
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

  Future<void> registrar() async {
    if (formKey.currentState!.validate()) {
      var boxr = await Hive.openBox('RegFR');

      passwordCounter = 0;
      nameCounter = 0;
      emailCounter = 0;
      lastnameCounter = 0;

      inprogress = true;
      update();
      bool error = false;
      var email = emailTE.text;
      //email = email.replaceAll(" ", "");
      var sms = "";
      try {
        // arrowController.forward();
        var user = SigupDto(
            name: nameTE.text,
            lastname1: lastnameTE.text,
            lastname2: seglastnameTE.text,
            email: email,
            pwd: passwordTE.text);

        var signup = await up.signup(user);
        sms = signup.message;
        if (signup.statusCode == 201) {
          boxr.put('emailreg', emailTE.text);
          goToActivateScreen();
          resetFormReg();
        } else {
          error = true;
        }
      } finally {
        inprogress = false;
        update();
        error
            ? AlertController.show(
                "Error al registrar el usuario",
                sms,
                TypeAlert.error,
              )
            : AlertController.show(
                "Usuario Registrado correctamente",
                sms,
                TypeAlert.success,
              );
      }
    } else {
      arrowController.reverse();
    }
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

  void showSnackBarWithFloatingError(String sms) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: FxText.titleSmall(sms, color: theme.colorScheme.onPrimary),
        backgroundColor: theme.colorScheme.error,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void resetFormReg() {
    nameTE.clear();
    lastnameTE.clear();
    emailTE.clear();
    passwordTE.clear();
    passwordTEE.clear();
  }

  @override
  String getTag() {
    return "register_controller";
  }
}
