import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';

import '../../../components/custom_button.dart';
import '../../../themes/theme/app_theme.dart';
import 'controller/forgot_password_controller.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    with TickerProviderStateMixin {
  late ThemeData theme;

  late ForgotPasswordController controller;
  late OutlineInputBorder outlineInputBorder;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.shoppingTheme;
    controller = FxControllerStore.put(ForgotPasswordController(this));
    outlineInputBorder = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<ForgotPasswordController>(
        controller: controller,
        builder: (controller) {
          return _buildBody();
        });
  }

  Widget _buildBody() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                  '¿Olvidó su contraseña?',
                  textAlign: TextAlign.center,
                  color: theme.colorScheme.onPrimary,
                ),
                FxSpacing.height(20),
                FxText.bodyMedium(
                  'Cree una nueva contraseña utilizando el código que le \nenviamos por correo',
                  muted: true,
                  color: theme.colorScheme.onPrimary,
                  textAlign: TextAlign.center,
                ),
                FxSpacing.height(32),
                Form(
                  key: controller.formKey,
                  child: SlideTransition(
                    position: controller.emailAnimation,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: TextFormField(
                        style: FxTextStyle.bodyMedium(),
                        decoration: InputDecoration(
                            errorStyle:
                                FxTextStyle.bodyMedium(color: Colors.white),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            filled: true,
                            isDense: true,
                            fillColor: theme.cardTheme.color,
                            prefixIcon: Icon(
                              FeatherIcons.mail,
                              color: theme.colorScheme.onBackground,
                            ),
                            hintText: "Email Address",
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
                ),
                FxSpacing.height(20),
                CustomButton(
                  loading: controller.inprogres,
                  text: "Recuperar",
                  onTap: () async {
                    await controller.forgotpass();
                  },
                ),
                FxSpacing.height(16),
                Center(
                  child: FxButton.text(
                    onPressed: () {
                      controller.goToRegisterScreen();
                    },
                    splashColor: theme.colorScheme.primary.withAlpha(40),
                    child: FxText.labelLarge("No tengo una cuenta",
                        decoration: TextDecoration.underline,
                        color: theme.colorScheme.primary),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
