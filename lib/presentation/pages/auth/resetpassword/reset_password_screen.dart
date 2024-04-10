import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../components/custom_button.dart';
import '../../../themes/theme/app_theme.dart';
import 'controller/reset_password_controller.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen>
    with TickerProviderStateMixin {
  late ThemeData theme;
  late ResetPasswordController controller;
  late OutlineInputBorder outlineInputBorder;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.shoppingTheme;

    controller = FxControllerStore.put(ResetPasswordController(this));
    outlineInputBorder = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<ResetPasswordController>(
        controller: controller,
        builder: (controller) {
          return Theme(
            data: theme.copyWith(
                colorScheme: theme.colorScheme.copyWith(
                    secondary: theme.colorScheme.primary.withAlpha(40))),
            child: _buildBody(),
          );
        });
  }

  Widget _buildBody() {
    return WillPopScope(
      onWillPop: () => controller.onWillPop(),
      child: Scaffold(
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
              child: ListView(
                padding: FxSpacing.fromLTRB(
                    20, FxSpacing.safeAreaTop(context) + 48, 20, 20),
                children: [
                  FxSpacing.height(40),
                  FxText.displaySmall(
                    'Recuperar Contraseña',
                    textAlign: TextAlign.center,
                    color: theme.colorScheme.onPrimary,
                  ),
                  FxSpacing.height(20),
                  FxText.bodyMedium(
                    'Cree una nueva contraseña utilizando\n el código que le enviamos por correo.',
                    muted: true,
                    textAlign: TextAlign.center,
                    color: theme.colorScheme.onPrimary,
                  ),
                  FxSpacing.height(32),
                  Form(
                    key: controller.formKey,
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              //right: 8.0,
                              left: 23.0,
                              right: 27),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  onChanged: (value) {
                                    switch (value.length) {
                                      case 0:
                                        FocusScope.of(context).previousFocus();
                                        break;
                                      case 1:
                                        FocusScope.of(context).nextFocus();
                                        break;
                                    }
                                  },
                                  style: FxTextStyle.bodyMedium(),
                                  decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      filled: true,
                                      isDense: true,
                                      fillColor: theme.cardTheme.color,
                                      hintText: "",
                                      enabledBorder: outlineInputBorder,
                                      focusedBorder: outlineInputBorder,
                                      border: outlineInputBorder,
                                      contentPadding: FxSpacing.all(16),
                                      hintStyle: FxTextStyle.bodyMedium(),
                                      isCollapsed: true),
                                  maxLines: 1,
                                  controller: controller.ad1,
                                  //       validator: controller.validatePassword,
                                  cursorColor: theme.colorScheme.onBackground,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                ),
                              ),
                              FxSpacing.width(2),
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  onChanged: (value) {
                                    switch (value.length) {
                                      case 0:
                                        FocusScope.of(context).previousFocus();
                                        break;
                                      case 1:
                                        FocusScope.of(context).nextFocus();
                                        break;
                                    }
                                  },
                                  style: FxTextStyle.bodyMedium(),
                                  decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      filled: true,
                                      isDense: true,
                                      fillColor: theme.cardTheme.color,
                                      hintText: "",
                                      enabledBorder: outlineInputBorder,
                                      focusedBorder: outlineInputBorder,
                                      border: outlineInputBorder,
                                      contentPadding: FxSpacing.all(16),
                                      hintStyle: FxTextStyle.bodyMedium(),
                                      isCollapsed: true),
                                  maxLines: 1,
                                  controller: controller.ad2,
                                  //   validator: controller.validatePassword,
                                  cursorColor: theme.colorScheme.onBackground,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                ),
                              ),
                              FxSpacing.width(2),
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  onChanged: (value) {
                                    switch (value.length) {
                                      case 0:
                                        FocusScope.of(context).previousFocus();
                                        break;
                                      case 1:
                                        FocusScope.of(context).nextFocus();
                                        break;
                                    }
                                  },
                                  style: FxTextStyle.bodyMedium(),
                                  decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      filled: true,
                                      isDense: true,
                                      fillColor: theme.cardTheme.color,
                                      hintText: "",
                                      enabledBorder: outlineInputBorder,
                                      focusedBorder: outlineInputBorder,
                                      border: outlineInputBorder,
                                      contentPadding: FxSpacing.all(16),
                                      hintStyle: FxTextStyle.bodyMedium(),
                                      isCollapsed: true),
                                  maxLines: 1,
                                  controller: controller.ad3,
                                  //     validator: controller.validatePassword,
                                  cursorColor: theme.colorScheme.onBackground,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                ),
                              ),
                              FxSpacing.width(2),
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  onChanged: (value) {
                                    switch (value.length) {
                                      case 0:
                                        FocusScope.of(context).previousFocus();
                                        break;
                                      case 1:
                                        FocusScope.of(context).nextFocus();
                                        break;
                                    }
                                  },
                                  style: FxTextStyle.bodyMedium(),
                                  decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      filled: true,
                                      isDense: true,
                                      fillColor: theme.cardTheme.color,
                                      hintText: "",
                                      enabledBorder: outlineInputBorder,
                                      focusedBorder: outlineInputBorder,
                                      border: outlineInputBorder,
                                      contentPadding: FxSpacing.all(16),
                                      hintStyle: FxTextStyle.bodyMedium(),
                                      isCollapsed: true),
                                  maxLines: 1,
                                  controller: controller.ad4,
                                  //      validator: controller.validatePassword,
                                  cursorColor: theme.colorScheme.onBackground,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                ),
                              ),
                              FxSpacing.width(2),
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  onChanged: (value) {
                                    switch (value.length) {
                                      case 0:
                                        FocusScope.of(context).previousFocus();
                                        break;
                                      case 1:
                                        FocusScope.of(context).nextFocus();
                                        break;
                                    }
                                  },
                                  style: FxTextStyle.bodyMedium(),
                                  decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      filled: true,
                                      isDense: true,
                                      fillColor: theme.cardTheme.color,
                                      hintText: "",
                                      enabledBorder: outlineInputBorder,
                                      focusedBorder: outlineInputBorder,
                                      border: outlineInputBorder,
                                      contentPadding: FxSpacing.all(16),
                                      hintStyle: FxTextStyle.bodyMedium(),
                                      isCollapsed: true),
                                  maxLines: 1,
                                  controller: controller.ad5,
                                  //  validator: controller.validatePassword,
                                  cursorColor: theme.colorScheme.onBackground,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                ),
                              ),
                              FxSpacing.width(2),
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  onChanged: (value) {
                                    switch (value.length) {
                                      case 0:
                                        FocusScope.of(context).previousFocus();
                                        break;
                                      case 1:
                                        FocusScope.of(context).nextFocus();
                                        break;
                                    }
                                  },
                                  style: FxTextStyle.bodyMedium(),
                                  decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      filled: true,
                                      isDense: true,
                                      fillColor: theme.cardTheme.color,
                                      hintText: "",
                                      enabledBorder: outlineInputBorder,
                                      focusedBorder: outlineInputBorder,
                                      border: outlineInputBorder,
                                      contentPadding: FxSpacing.all(16),
                                      hintStyle: FxTextStyle.bodyMedium(),
                                      isCollapsed: true),
                                  maxLines: 1,
                                  controller: controller.ad6,
                                  // validator: controller.validatePassword,
                                  cursorColor: theme.colorScheme.onBackground,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        FxSpacing.height(10),
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
                                  hintText: "Nueva Contraseña",
                                  enabledBorder: outlineInputBorder,
                                  focusedBorder: outlineInputBorder,
                                  border: outlineInputBorder,
                                  contentPadding: FxSpacing.all(16),
                                  hintStyle: FxTextStyle.bodyMedium(),
                                  isCollapsed: true),
                              maxLines: 1,
                              obscureText: controller.passwordVisible,
                              controller: controller.passwordTE,
                              validator: controller.validatePassword11,
                              cursorColor: theme.colorScheme.onBackground,
                            ),
                          ),
                        ),
                        FxSpacing.height(10),
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 25.0,
                            left: 25.0,
                          ),
                          child: SlideTransition(
                            position: controller.resetPasswordAnimation,
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
                                  hintText: "Confirmar Nueva Contraseña",
                                  enabledBorder: outlineInputBorder,
                                  focusedBorder: outlineInputBorder,
                                  border: outlineInputBorder,
                                  contentPadding: FxSpacing.all(16),
                                  hintStyle: FxTextStyle.bodyMedium(),
                                  isCollapsed: true),
                              maxLines: 1,
                              obscureText: controller.passwordVisible,
                              controller: controller.confirmPasswordTE,
                              validator: controller.validatePassword12,
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
                    loading: controller.inprogres,
                    onTap: () {
                      controller.recoverpass();
                    },
                  ),
                  // controller.recoverpass();
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
