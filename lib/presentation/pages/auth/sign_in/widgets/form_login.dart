/*import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../components/custom_button.dart';
import '../../../../components/entry_field.dart';
import '../controller/login_controller.dart';

class FormLogin extends StatelessWidget {
  const FormLogin(
      {super.key,
      required this.theme,
      required LogInController this.controller});

  final ThemeData theme;
  final LogInController controller;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: ListView(
        children: [
          FadedScaleAnimation(
            child: Image.asset(
              'assets/img/png/Logo TrucksUp.png',
              scale: 3.0,
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
          const SizedBox(
            height: 24,
          ),
          FxText.bodyLarge(
            'Gracias por utilizar nuestra app!',
            color: theme.colorScheme.onPrimary,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 24,
          ),
          EntryField(
            validator: controller.validateEmail,
            icon: const Icon(MdiIcons.account),
            texteditcontroller: controller.emailTE,
            hintText: 'usuario@gogo.app',
          ),
          EntryField(
            validator: controller.validatePassword,
            icon: const Icon(MdiIcons.lock),
            hintText: '********',
            texteditcontroller: controller.passwordTE,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FxButton.text(
                    padding: FxSpacing.zero,
                    onPressed: () {
                      Navigator.pushNamed(context, '/registro');
                    },
                    child: FxText.bodyLarge("Olvidó su contraseña ?",
                        decoration: TextDecoration.underline,
                        color: theme.colorScheme.onPrimary)),
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
                      decoration: TextDecoration.underline,
                      color: theme.colorScheme.onPrimary)),
            ],
          ),
        ],
      ),
    );
  }
}
*/