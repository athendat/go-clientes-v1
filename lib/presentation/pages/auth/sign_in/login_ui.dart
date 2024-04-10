import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:client.gogogo/presentation/pages/auth/forgot/forgot_password_screen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

//import '../../../routes/routes.dart';
import '../../../components/custom_button.dart';
import '../../../themes/theme/app_theme.dart';
import 'controller/login_controller.dart';

class SignInUI extends StatefulWidget {
  const SignInUI({Key? key}) : super(key: key);

  @override
  _SignInUIState createState() => _SignInUIState();
}

class _SignInUIState extends State<SignInUI> with TickerProviderStateMixin {
  late ThemeData theme;

  late LogInController controller;
  late OutlineInputBorder outlineInputBorder;
  var _check = false;
  @override
  void initState() {
    super.initState();
    theme = AppTheme.shoppingTheme;

    controller = FxControllerStore.put(LogInController(this));
    outlineInputBorder = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<LogInController>(
        controller: controller,
        builder: (controller) {
          return WillPopScope(
            onWillPop: onWillPop,
            child: Scaffold(
                //  resizeToAvoidBottomInset: false,
                body: Stack(
              children: [
                Image.asset(
                  'assets/img/png/bg_main.png',
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                ),
                FadedSlideAnimation(
                  beginOffset: const Offset(0, 0.3),
                  endOffset: const Offset(0, 0),
                  child: Form(
                    key: controller.formKey,
                    child: ListView(
                      children: [
                        FxSpacing.height(30),
                        FadedScaleAnimation(
                          child: Image.asset(
                            'assets/img/png/logotipo_loguin.png',
                            scale: 2.0,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              height: 4,
                              width: 80,
                            ),
                            FxText.bodyLarge(
                              'Bienvenido',
                              color: theme.colorScheme.onPrimary,
                            ),
                            Container(
                              height: 4,
                              width: 80,
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ],
                        ),
                        FxSpacing.height(20),
                        FxText.bodyLarge(
                          '¡Gracias por utilizar nuestra app!',
                          color: theme.colorScheme.onPrimary,
                          textAlign: TextAlign.center,
                        ),
                        FxSpacing.height(20),
                        Padding(
                          padding: const EdgeInsets.only(left: 24, right: 24),
                          child: TextFormField(
                            onChanged: (value) {
                              controller.emailTE
                                ..text = value.trim()
                                ..selection = TextSelection.collapsed(
                                    offset: controller.emailTE.text.length);
                            },
                            style: FxTextStyle.bodyMedium(),
                            decoration: InputDecoration(
                                errorStyle:
                                    FxTextStyle.bodyMedium(color: Colors.white),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                filled: true,
                                isDense: true,
                                fillColor: theme.cardTheme.color,
                                prefixIcon: Icon(
                                  FeatherIcons.mail,
                                  color: theme.colorScheme.onBackground,
                                ),
                                hintText: "Dirección de correo",
                                enabledBorder: outlineInputBorder,
                                focusedBorder: outlineInputBorder,
                                border: outlineInputBorder,
                                contentPadding: FxSpacing.all(16),
                                hintStyle: FxTextStyle.bodyMedium(),
                                isCollapsed: true),
                            maxLines: 1,
                            controller: controller.emailTE,
                            validator: controller.validateEmail,
                            cursorColor: theme.colorScheme.onBackground,
                          ),
                        ),
                        FxSpacing.height(20),
                        Padding(
                          padding: const EdgeInsets.only(left: 24, right: 24),
                          child: TextFormField(
                            style: FxTextStyle.bodyMedium(),
                            decoration: InputDecoration(
                                errorStyle:
                                    FxTextStyle.bodyMedium(color: Colors.white),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                filled: true,
                                isDense: true,
                                fillColor: theme.cardTheme.color,
                                prefixIcon: Icon(
                                  FeatherIcons.lock,
                                  color: theme.colorScheme.onBackground,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    controller.passwordVisible
                                        ? MdiIcons.eyeOffOutline
                                        : MdiIcons.eyeOutline,
                                    color: theme.colorScheme.onBackground,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      controller.passwordVisible =
                                          !controller.passwordVisible;
                                    });
                                  },
                                ),
                                hintText: "Contraseña",
                                enabledBorder: outlineInputBorder,
                                focusedBorder: outlineInputBorder,
                                border: outlineInputBorder,
                                contentPadding: FxSpacing.all(16),
                                hintStyle: FxTextStyle.bodyMedium(),
                                isCollapsed: true),
                            maxLines: 1,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (String text) {
                              controller.login();
                            },
                            controller: controller.passwordTE,
                            obscureText: controller.passwordVisible,
                            validator: controller.validatePassword,
                            cursorColor: theme.colorScheme.onBackground,
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(right: 25.0, bottom: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              FxButton.text(
                                  padding: FxSpacing.zero,
                                  onPressed: () {
                                    // Navigator.pushNamed(context, '/forgot');

                                    Navigator.of(context, rootNavigator: true)
                                        .push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ForgotPasswordScreen(),
                                      ),
                                    );
                                  },
                                  child: FxText.bodyLarge(
                                      "¿Olvidó su contraseña?",
                                      // decoration: TextDecoration.underline,
                                      color: theme.colorScheme.onPrimary)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0, top: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Obx(() => Checkbox(
                                  splashRadius: 25,
                                  value: controller.remember.value,
                                  activeColor: theme.colorScheme.primary,
                                  fillColor: MaterialStatePropertyAll(
                                      theme.colorScheme.primary),
                                  onChanged: (value) async {
                                    controller.remember.value =
                                        !controller.remember.value;
                                    !controller.remember.value
                                        ? await controller.deleteremember()
                                        : await controller.rememberpass();
                                  })),
                              FxText.bodyLarge(
                                "Recordar usuario",
                                // fontWeight: 450,
                                color: theme.colorScheme.background,
                                // decoration: TextDecoration.underline,
                              ),
                            ],
                          ),
                        ),
                        Obx(() => CustomButton(
                              loading: controller.loginprogres.value,
                              text: "Iniciar Sesión",
                              onTap: () async {
                                await controller.login();
                              },
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FxButton.text(
                                padding: FxSpacing.zero,
                                onPressed: () {
                                  //  Navigator.pushNamed(context, '/registro');
                                  controller.goToRegisterScreen(context);
                                },
                                child: FxText.bodyLarge("Crear cuenta",

                                    // decoration: TextDecoration.underline,
                                    color: theme.colorScheme.onPrimary)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // curve: Curves.linearToEaseOut,
                )
              ],
            )),
          );
        });
  }

  Future<bool> onWillPop() {
    SystemNavigator.pop();
    return Future.value(false);
  }
}
