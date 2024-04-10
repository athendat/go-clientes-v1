import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutx/flutx.dart';

import '../../../components/custom_button.dart';
import '../../../themes/theme/app_theme.dart';
import 'controller/activate_code_controller.dart';

class ActivationCodePage extends StatefulWidget {
  const ActivationCodePage({Key? key}) : super(key: key);

  @override
  _ActivationCodePageState createState() => _ActivationCodePageState();
}

class _ActivationCodePageState extends State<ActivationCodePage>
    with TickerProviderStateMixin {
  late ThemeData theme;

  late ActivateCodeController controller;
  late OutlineInputBorder outlineInputBorder;
  @override
  void initState() {
    super.initState();
    theme = AppTheme.shoppingTheme;

    controller = FxControllerStore.put(ActivateCodeController(this));
    outlineInputBorder = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<ActivateCodeController>(
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
                  child: ListView(
                    padding: FxSpacing.fromLTRB(
                        20, FxSpacing.safeAreaTop(context) + 48, 20, 20),
                    children: [
                      FxSpacing.height(20),
                      FxText.displaySmall(
                        'Activar Cuenta',
                        textAlign: TextAlign.center,
                        color: theme.colorScheme.onPrimary,
                      ),
                      const SizedBox(
                        height: 34,
                      ),
                      FxText.bodyLarge(
                        color: theme.colorScheme.onPrimary,
                        'Se le notifico al email:' ' \n ${controller.emailreg}',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FxText.bodyLarge(
                        color: theme.colorScheme.onPrimary,
                        'Introduzca el código recibido',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Form(
                        key: controller.formKey,
                        child: Column(
                          // mainAxisSize: MainAxisSize.min,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: FxSpacing.fromLTRB(20, 0, 20, 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      onChanged: (value) {
                                        switch (value.length) {
                                          case 0:
                                            FocusScope.of(context)
                                                .previousFocus();
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
                                      cursorColor:
                                          theme.colorScheme.onBackground,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(1),
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                    ),
                                  ),
                                  FxSpacing.width(3),
                                  Expanded(
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      onChanged: (value) {
                                        switch (value.length) {
                                          case 0:
                                            FocusScope.of(context)
                                                .previousFocus();
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
                                      cursorColor:
                                          theme.colorScheme.onBackground,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(1),
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                    ),
                                  ),
                                  FxSpacing.width(3),
                                  Expanded(
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      onChanged: (value) {
                                        switch (value.length) {
                                          case 0:
                                            FocusScope.of(context)
                                                .previousFocus();
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
                                      cursorColor:
                                          theme.colorScheme.onBackground,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(1),
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                    ),
                                  ),
                                  FxSpacing.width(3),
                                  Expanded(
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      onChanged: (value) {
                                        switch (value.length) {
                                          case 0:
                                            FocusScope.of(context)
                                                .previousFocus();
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
                                      cursorColor:
                                          theme.colorScheme.onBackground,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(1),
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                    ),
                                  ),
                                  FxSpacing.width(3),
                                  Expanded(
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      onChanged: (value) {
                                        switch (value.length) {
                                          case 0:
                                            FocusScope.of(context)
                                                .previousFocus();
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
                                      cursorColor:
                                          theme.colorScheme.onBackground,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(1),
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                    ),
                                  ),
                                  FxSpacing.width(3),
                                  Expanded(
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      onChanged: (value) {
                                        switch (value.length) {
                                          case 0:
                                            FocusScope.of(context)
                                                .previousFocus();
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
                                      cursorColor:
                                          theme.colorScheme.onBackground,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(1),
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            /* FxSpacing.height(20),
                SlideTransition(
                  position: controller.passwordAnimation,
                  child: TextFormField(
                    style: FxTextStyle.bodyMedium(),
                    decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        filled: true,
                        isDense: true,
                        fillColor: theme.cardTheme.color,
                        hintText: "Nueva Contraseña",
                        enabledBorder: outlineInputBorder,
                        focusedBorder: outlineInputBorder,
                        border: outlineInputBorder,
                        contentPadding: FxSpacing.all(16),
                        hintStyle: FxTextStyle.bodyMedium(),
                        isCollapsed: true),
                    maxLines: 1,
                    controller: controller.passwordTE,
                    validator: controller.validatePassword,
                    cursorColor: theme.colorScheme.onBackground,
                  ),
                ),*/
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      CustomButton(
                        loading: controller.inprogres,
                        onTap: () {
                          controller.activateu();
                        },
                      ),
                    ],
                  ),
                  // curve: Curves.linearToEaseOut,
                ),
              ],
            ),
          );
        });
  }
}
