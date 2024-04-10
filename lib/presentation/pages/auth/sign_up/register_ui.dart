import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../components/custom_button.dart';
import '../../../themes/colors.dart';
import '../../../themes/theme/app_theme.dart';
import '../sign_in/login_ui.dart';
import 'controller/register_controller.dart';

class SignUpUI extends StatefulWidget {
  const SignUpUI({Key? key}) : super(key: key);

  @override
  _SignUpUIState createState() => _SignUpUIState();
}

class _SignUpUIState extends State<SignUpUI> with TickerProviderStateMixin {
  late ThemeData theme;

  late RegisterController controller;
  late OutlineInputBorder outlineInputBorder;
  @override
  void initState() {
    super.initState();
    theme = AppTheme.shoppingTheme;

    controller = FxControllerStore.put(RegisterController(this));
    outlineInputBorder = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<RegisterController>(
        controller: controller,
        builder: (controller) {
          return Scaffold(
            body: Stack(
              children: [
                Image.asset(
                  'assets/img/png/bg_main.png',
                  fit: BoxFit.fill,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                ),
                FadedSlideAnimation(
                  beginOffset: const Offset(0, 0.3),
                  endOffset: const Offset(0, 0),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: ListView(
                      children: [
                        AppBar(
                          surfaceTintColor: Colors.transparent,
                          centerTitle: true,
                          iconTheme: IconThemeData(
                            color: theme.colorScheme.onPrimary,
                          ),
                          backgroundColor: Colors.transparent,
                          elevation: 0.0,
                          title: FxText.displaySmall(
                            'Registrar',
                            textAlign: TextAlign.center,
                            color: theme.colorScheme.onPrimary,
                          ),
                        ),
                        FxSpacing.height(60),
                        FxSpacing.height(20),
                        Form(
                          key: controller.formKey,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 25.0,
                                  left: 25.0,
                                ),
                                child: SlideTransition(
                                  position: controller.nameAnimation,
                                  child: TextFormField(
                                    style: FxTextStyle.bodyMedium(),
                                    decoration: InputDecoration(
                                        errorStyle: FxTextStyle.bodyMedium(
                                            color: Colors.white),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.never,
                                        filled: true,
                                        isDense: true,
                                        fillColor: theme.cardTheme.color,
                                        prefixIcon: Icon(
                                          FeatherIcons.user,
                                          color: theme.colorScheme.onBackground,
                                        ),
                                        hintText: "Nombre",
                                        enabledBorder: outlineInputBorder,
                                        focusedBorder: outlineInputBorder,
                                        border: outlineInputBorder,
                                        contentPadding: FxSpacing.all(16),
                                        hintStyle: FxTextStyle.bodyMedium(),
                                        isCollapsed: true),
                                    maxLines: 1,
                                    controller: controller.nameTE,
                                    validator: controller.validateName,
                                    cursorColor: theme.colorScheme.onBackground,
                                  ),
                                ),
                              ),
                              FxSpacing.height(20),
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 25.0,
                                  left: 25.0,
                                ),
                                child: SlideTransition(
                                  position: controller.lastnameAnimation,
                                  child: TextFormField(
                                    style: FxTextStyle.bodyMedium(),
                                    decoration: InputDecoration(
                                        errorStyle: FxTextStyle.bodyMedium(
                                            color: Colors.white),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.never,
                                        filled: true,
                                        isDense: true,
                                        fillColor: theme.cardTheme.color,
                                        prefixIcon: Icon(
                                          FeatherIcons.user,
                                          color: theme.colorScheme.onBackground,
                                        ),
                                        hintText: "Primer Apellido",
                                        enabledBorder: outlineInputBorder,
                                        focusedBorder: outlineInputBorder,
                                        border: outlineInputBorder,
                                        contentPadding: FxSpacing.all(16),
                                        hintStyle: FxTextStyle.bodyMedium(),
                                        isCollapsed: true),
                                    maxLines: 1,
                                    controller: controller.lastnameTE,
                                    validator: controller.validateLastName,
                                    cursorColor: theme.colorScheme.onBackground,
                                  ),
                                ),
                              ),
                              FxSpacing.height(20),
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 25.0,
                                  left: 25.0,
                                ),
                                child: SlideTransition(
                                  position: controller.lastnameAnimation,
                                  child: TextFormField(
                                    style: FxTextStyle.bodyMedium(),
                                    decoration: InputDecoration(
                                        errorStyle: FxTextStyle.bodyMedium(
                                            color: Colors.white),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.never,
                                        filled: true,
                                        isDense: true,
                                        fillColor: theme.cardTheme.color,
                                        prefixIcon: Icon(
                                          FeatherIcons.user,
                                          color: theme.colorScheme.onBackground,
                                        ),
                                        hintText: "Segundo Apellido",
                                        enabledBorder: outlineInputBorder,
                                        focusedBorder: outlineInputBorder,
                                        border: outlineInputBorder,
                                        contentPadding: FxSpacing.all(16),
                                        hintStyle: FxTextStyle.bodyMedium(),
                                        isCollapsed: true),
                                    maxLines: 1,
                                    controller: controller.seglastnameTE,
                                    // validator: controller.validateLastName,
                                    cursorColor: theme.colorScheme.onBackground,
                                  ),
                                ),
                              ),
                              FxSpacing.height(20),
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 25.0,
                                  left: 25.0,
                                ),
                                child: SlideTransition(
                                  position: controller.emailAnimation,
                                  child: TextFormField(
                                    onChanged: (value) {
                                      controller.emailTE
                                        ..text = value.trim()
                                        ..selection = TextSelection.collapsed(
                                            offset:
                                                controller.emailTE.text.length);
                                    },
                                    style: FxTextStyle.bodyMedium(),
                                    decoration: InputDecoration(
                                        errorStyle: FxTextStyle.bodyMedium(
                                            color: Colors.white),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.never,
                                        filled: true,
                                        isDense: true,
                                        fillColor: theme.cardTheme.color,
                                        prefixIcon: Icon(
                                          FeatherIcons.mail,
                                          color: theme.colorScheme.onBackground,
                                        ),
                                        hintText: "Correo electrónico",
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
                              ),
                              FxSpacing.height(20),
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 25.0,
                                  left: 25.0,
                                ),
                                child: SlideTransition(
                                  position: controller.passwordAnimation,
                                  child: TextFormField(
                                    style: FxTextStyle.bodyMedium(),
                                    decoration: InputDecoration(
                                      errorStyle: FxTextStyle.bodyMedium(
                                          color: Colors.white),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      filled: true,
                                      isDense: true,
                                      fillColor: theme.cardTheme.color,
                                      prefixIcon: Icon(
                                        FeatherIcons.lock,
                                        color: theme.colorScheme.onBackground,
                                      ),
                                      hintText: "Contraseña",
                                      enabledBorder: outlineInputBorder,
                                      focusedBorder: outlineInputBorder,
                                      border: outlineInputBorder,
                                      contentPadding: FxSpacing.all(16),
                                      hintStyle: FxTextStyle.bodyMedium(),
                                      isCollapsed: true,
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
                                    ),
                                    maxLines: 1,
                                    obscureText: controller.passwordVisible,
                                    controller: controller.passwordTE,
                                    validator: controller.validatePassword11,
                                    cursorColor: theme.colorScheme.onBackground,
                                  ),
                                ),
                              ),
                              FxSpacing.height(20),
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 25.0,
                                  left: 25.0,
                                ),
                                child: SlideTransition(
                                  position: controller.passwordAnimation,
                                  child: TextFormField(
                                    style: FxTextStyle.bodyMedium(),
                                    decoration: InputDecoration(
                                        errorStyle: FxTextStyle.bodyMedium(
                                            color: Colors.white),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.never,
                                        filled: true,
                                        isDense: true,
                                        fillColor: theme.cardTheme.color,
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            controller.passwordVisible
                                                ? MdiIcons.eyeOffOutline
                                                : MdiIcons.eyeOutline,
                                            color:
                                                theme.colorScheme.onBackground,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              controller.passwordVisible =
                                                  !controller.passwordVisible;
                                            });
                                          },
                                        ),
                                        prefixIcon: Icon(
                                          FeatherIcons.lock,
                                          color: theme.colorScheme.onBackground,
                                        ),
                                        hintText: "Repetir Contraseña",
                                        enabledBorder: outlineInputBorder,
                                        focusedBorder: outlineInputBorder,
                                        border: outlineInputBorder,
                                        contentPadding: FxSpacing.all(16),
                                        hintStyle: FxTextStyle.bodyMedium(),
                                        isCollapsed: true),
                                    maxLines: 1,
                                    controller: controller.passwordTEE,
                                    validator: controller.validatePassword12,
                                    obscureText: controller.passwordVisible,
                                    cursorColor: theme.colorScheme.onBackground,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        FxSpacing.height(20),
                        CustomButton(
                          text: 'Aceptar',
                          loading: controller.inprogress,
                          onTap: () {
                            controller.registrar();
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FxButton.text(
                                padding: FxSpacing.zero,
                                onPressed: () {
                                  //  Navigator.pushNamed(context, '/registro');
                                  // Navigator.pushNamed(context, '/login');

                                  Navigator.of(context, rootNavigator: true)
                                      .pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => const SignInUI(),
                                    ),
                                  );
                                },
                                child: FxText.bodyLarge("Tengo una cuenta",
                                    decoration: TextDecoration.underline,
                                    color: theme.colorScheme.onPrimary)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // curve: Curves.linearToEaseOut,
                ),
              ],
            ),
          );
        });
  }
}
