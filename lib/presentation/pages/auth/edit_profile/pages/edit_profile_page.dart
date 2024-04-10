import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:client.gogogo/presentation/pages/auth/edit_profile/widget/widget_error_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:client.gogogo/data/models/statescode.dart';
import 'package:client.gogogo/presentation/components/custom_button.dart';
import 'package:client.gogogo/presentation/components/line_container.dart';
import 'package:client.gogogo/presentation/components/loading_effect.dart';
import 'package:client.gogogo/presentation/pages/home/screen/home_page.dart';
import 'package:client.gogogo/presentation/themes/theme/app_theme.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/edit_profile_controller.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage>
    with TickerProviderStateMixin {
  late ThemeData theme;
  late EditProfileController controller;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.shoppingLightTheme;
    controller = FxControllerStore.put(EditProfileController(
      this,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<EditProfileController>(
        controller: controller,
        builder: (controller) {
          return Scaffold(
            // key: _drawerKey,

            appBar: appbar(),
            body: Obx(() => controller.loadinggetrequest.value
                ? FadedScaleAnimation(
                    child: LoadingEffect.getReviewLoadingScreen(context))
                : controller.exeption.value
                    ? WidgetErrorLoading(controller)
                    : bodyrequest(
                        controller,
                        context,
                      )),
          );
        });
  }

  Stack bodyrequest(
    EditProfileController controller,
    BuildContext context,
  ) {
    return Stack(
      children: [
        Container(
          color: theme.dividerColor,
        ),
        Form(
          key: controller.formKey,
          child: ListView(
            padding: FxSpacing.all(10),
            children: [
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: FadedScaleAnimation(
                                child: controller.avatar.value != ""
                                    ? CachedNetworkImage(
                                        width: 100,
                                        height: 100,
                                        imageUrl: controller.avatar.value,
                                        placeholder: (context, url) =>
                                            CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      )
                                    : CachedNetworkImage(
                                        width: 100,
                                        height: 100,
                                        imageUrl:
                                            "http://via.placeholder.com/150x150",
                                        placeholder: (context, url) =>
                                            CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                              )),
                          controller.isreadonly.value
                              ? Container()
                              : GestureDetector(
                                  onTap: () => {_showDialog()},
                                  child: CircleAvatar(
                                    backgroundColor: theme.primaryColor,
                                    radius: 12,
                                    child: Icon(
                                      Icons.camera_alt_sharp,
                                      size: 14,
                                      color: theme.colorScheme.background,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ],
                  )),
              FxSpacing.height(10),
              Material(
                elevation: 2.5,
                shadowColor: theme.primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(20),
                child: FxContainer.bordered(
                  color: theme.colorScheme.background,
                  padding: FxSpacing.only(right: 15),
                  borderRadius: BorderRadius.circular(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, top: 15),
                        child: FxText.bodyLarge("Nombre"),
                      ),
                      TextFormField(
                        enabled: !controller.isreadonly.value,
                        style: FxTextStyle.bodyMedium(
                            color:
                                theme.colorScheme.onBackground.withAlpha(130),
                            fontWeight: 600,
                            letterSpacing: 0.2),
                        decoration: InputDecoration(
                          hintStyle: FxTextStyle.bodyLarge(
                              fontWeight: 500,
                              letterSpacing: 0,
                              color:
                                  theme.colorScheme.onBackground.withAlpha(70)),
                          hintText: "Nombre",
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          isDense: true,
                          contentPadding: const EdgeInsets.only(
                              left: 16, top: 2, bottom: 16),
                        ),
                        autofocus: false,
                        keyboardType: TextInputType.emailAddress,
                        controller: controller.nombre,
                        // validator: controller.validateText,
                      ),
                      const LineContainer(),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16.0, top: 15),
                                  child: FxText.bodyLarge("Primer Apellido"),
                                ),
                                TextFormField(
                                  enabled: !controller.isreadonly.value,
                                  style: FxTextStyle.bodyMedium(
                                      color: theme.colorScheme.onBackground
                                          .withAlpha(130),
                                      fontWeight: 600,
                                      letterSpacing: 0.2),
                                  decoration: InputDecoration(
                                    hintStyle: FxTextStyle.bodyLarge(
                                        fontWeight: 500,
                                        letterSpacing: 0,
                                        color: theme.colorScheme.onBackground
                                            .withAlpha(70)),
                                    hintText: "Apellido",
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    isDense: true,
                                    contentPadding: const EdgeInsets.only(
                                        left: 16, top: 2, bottom: 16),
                                  ),
                                  autofocus: false,
                                  keyboardType: TextInputType.text,
                                  controller: controller.apellido1,
                                  //  validator: controller.validateText,
                                ),
                                const LineContainer(),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16.0, top: 15),
                                  child: FxText.bodyLarge("Segundo Apellido"),
                                ),
                                TextFormField(
                                  enabled: !controller.isreadonly.value,
                                  style: FxTextStyle.bodyMedium(
                                      color: theme.colorScheme.onBackground
                                          .withAlpha(130),
                                      fontWeight: 600,
                                      letterSpacing: 0.2),
                                  decoration: InputDecoration(
                                    hintStyle: FxTextStyle.bodyLarge(
                                        fontWeight: 500,
                                        letterSpacing: 0,
                                        color: theme.colorScheme.onBackground
                                            .withAlpha(70)),
                                    hintText: "Apellido",
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    isDense: true,
                                    contentPadding: const EdgeInsets.only(
                                        left: 16, top: 2, bottom: 16),
                                  ),
                                  autofocus: false,
                                  keyboardType: TextInputType.text,
                                  controller: controller.apellido2,
                                  //  validator: controller.validateText,
                                ),
                                const LineContainer(),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16.0, top: 15),
                                  child: FxText.bodyLarge("Teléfono"),
                                ),
                                TextFormField(
                                  enabled: !controller.isreadonly.value,
                                  style: FxTextStyle.bodyMedium(
                                      color: theme.colorScheme.onBackground
                                          .withAlpha(130),
                                      fontWeight: 600,
                                      letterSpacing: 0.2),
                                  decoration: InputDecoration(
                                    hintStyle: FxTextStyle.bodyLarge(
                                        fontWeight: 500,
                                        letterSpacing: 0,
                                        color: theme.colorScheme.onBackground
                                            .withAlpha(70)),
                                    hintText: "+53",
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    isDense: true,
                                    contentPadding: const EdgeInsets.only(
                                        left: 16, top: 2, bottom: 16),
                                  ),
                                  autofocus: false,
                                  keyboardType: TextInputType.number,
                                  controller: controller.phone,
                                  //  validator: controller.validateText,
                                ),
                                const LineContainer(),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16.0, top: 15),
                                  child: FxText.bodyLarge("Código Postal"),
                                ),
                                TextFormField(
                                  enabled: !controller.isreadonly.value,
                                  style: FxTextStyle.bodyMedium(
                                      color: theme.colorScheme.onBackground
                                          .withAlpha(130),
                                      fontWeight: 600,
                                      letterSpacing: 0.2),
                                  decoration: InputDecoration(
                                    hintStyle: FxTextStyle.bodyLarge(
                                        fontWeight: 500,
                                        letterSpacing: 0,
                                        color: theme.colorScheme.onBackground
                                            .withAlpha(70)),
                                    hintText: "",
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    isDense: true,
                                    contentPadding: const EdgeInsets.only(
                                        left: 16, top: 2, bottom: 16),
                                  ),
                                  autofocus: false,
                                  keyboardType: TextInputType.number,
                                  controller: controller.zip,
                                  //  validator: controller.validateText,
                                ),
                                const LineContainer(),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16.0, top: 15, bottom: 5),
                                  child:
                                      FxText.bodyLarge("Carnet de identidad"),
                                ),
                                TextFormField(
                                  enabled: !controller.isreadonly.value,
                                  style: FxTextStyle.bodyMedium(
                                      color: theme.colorScheme.onBackground
                                          .withAlpha(130),
                                      fontWeight: 600,
                                      letterSpacing: 0.2),
                                  decoration: InputDecoration(
                                    hintStyle: FxTextStyle.bodyLarge(
                                        fontWeight: 500,
                                        letterSpacing: 0,
                                        color: theme.colorScheme.onBackground
                                            .withAlpha(70)),
                                    hintText: "",
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    isDense: true,
                                    contentPadding: const EdgeInsets.only(
                                        left: 16, top: 2, bottom: 16),
                                  ),
                                  autofocus: false,
                                  keyboardType: TextInputType.number,
                                  controller: controller.idnumber,
                                  validator: controller.validateCi,
                                ),
                                const LineContainer(),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16.0, top: 15),
                                  child: FxText.bodyLarge("Género"),
                                ),
                                IgnorePointer(
                                  ignoring: controller.isreadonly.value,
                                  child: DropdownButtonHideUnderline(
                                    child: ButtonTheme(
                                      alignedDropdown: true,
                                      child: DropdownButtonFormField<String?>(
                                        dropdownColor: theme.cardTheme.color,
                                        validator: (value) => value == null
                                            ? 'Seleccione Género'
                                            : null,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                        ),
                                        value: controller.gender.value == ""
                                            ? controller.genders[0]
                                            : controller.genders
                                                .where((i) =>
                                                    i ==
                                                    controller.gender.value)
                                                .first,

                                        icon: const Icon(
                                          Icons.arrow_circle_down,
                                          size: 16,
                                        ),
                                        elevation: 16,
                                        // style: MyStyles.textfieldforms,
                                        onChanged: (String? genero) {
                                          controller.gender.value = genero!;
                                        },
                                        items: controller.genders.map((item) {
                                          return DropdownMenuItem<String>(
                                            value: item,
                                            child: FxText.bodyMedium(
                                              '$item ',
                                              color: theme
                                                  .colorScheme.onBackground
                                                  .withAlpha(130),
                                              fontWeight: 500,
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ),
                                const LineContainer(),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16.0, top: 15),
                                  child: FxText.bodyLarge("Correo electrónico"),
                                ),
                                TextFormField(
                                  enabled: !controller.isreadonly.value,
                                  style: FxTextStyle.bodyMedium(
                                      color: theme.colorScheme.onBackground
                                          .withAlpha(130),
                                      fontWeight: 600,
                                      letterSpacing: 0.2),
                                  decoration: InputDecoration(
                                    hintStyle: FxTextStyle.bodyLarge(
                                        fontWeight: 500,
                                        letterSpacing: 0,
                                        color: theme.colorScheme.onBackground
                                            .withAlpha(70)),
                                    hintText: "email@email.com",
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    isDense: true,
                                    contentPadding: const EdgeInsets.only(
                                        left: 16, top: 2, bottom: 16),
                                  ),
                                  autofocus: false,
                                  keyboardType: TextInputType.text,
                                  controller: controller.email,
                                  //   validator: controller.validateText,
                                ),
                                const LineContainer(),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16.0, top: 15),
                                  child: FxText.bodyLarge("Provincia"),
                                ),
                                IgnorePointer(
                                  ignoring: controller.isreadonly.value,
                                  child: DropdownButtonHideUnderline(
                                    child: ButtonTheme(
                                      alignedDropdown: true,
                                      child: DropdownButtonFormField<String>(
                                        dropdownColor: theme.cardTheme.color,
                                        validator: (value) =>
                                            value == null || value == ""
                                                ? 'Seleccione la Provincia'
                                                : null,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                        ),
                                        value: controller.selectedstate.value,
                                        icon: const Icon(
                                          Icons.arrow_circle_down,
                                          size: 16,
                                        ),
                                        elevation: 16,
                                        // style: MyStyles.textfieldforms,
                                        onChanged: (String? player) {
                                          controller.selectedstate.value =
                                              player!;
                                          controller.filtersMunicipios();
                                        },
                                        items: controller.statess.map((item) {
                                          return DropdownMenuItem<String>(
                                            value: item,
                                            child: FxText.bodyMedium(
                                              '$item ',
                                              color: theme
                                                  .colorScheme.onBackground
                                                  .withAlpha(130),
                                              fontWeight: 500,
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ),
                                const LineContainer(),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16.0, top: 15),
                                  child: FxText.bodyLarge("Municipio"),
                                ),
                                IgnorePointer(
                                  ignoring: controller.isreadonly.value,
                                  child: DropdownButtonHideUnderline(
                                    child: ButtonTheme(
                                      alignedDropdown: true,
                                      child:
                                          DropdownButtonFormField<Municipios>(
                                        dropdownColor: theme.cardTheme.color,
                                        validator: (value) => value == null
                                            ? 'Seleccione el Municipio'
                                            : null,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                        ),
                                        value:
                                            controller.selectedstatecode.value,
                                        icon: const Icon(
                                          Icons.arrow_circle_down,
                                          size: 16,
                                        ),
                                        elevation: 16,
                                        // style: MyStyles.textfieldforms,
                                        onChanged: (Municipios? municipio) {
                                          controller.selectedstatecode.value =
                                              municipio!;
                                        },
                                        items:
                                            controller.statescode.map((item) {
                                          return DropdownMenuItem<Municipios>(
                                            value: item,
                                            child: FxText.bodyMedium(
                                              item.city,
                                              color: theme
                                                  .colorScheme.onBackground
                                                  .withAlpha(130),
                                              fontWeight: 500,
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ),
                                const LineContainer(),
                              ],
                            ),
                          ),
                        ],
                      ),
                      /*  Padding(
                        padding: const EdgeInsets.only(left: 16.0, top: 15),
                        child: FxText.bodyLarge("Barrio"),
                      ),
                      TextFormField(
                        enabled: !controller.isreadonly.value,
                        style: FxTextStyle.bodyMedium(
                            color:
                                theme.colorScheme.onBackground.withAlpha(130),
                            fontWeight: 600,
                            letterSpacing: 0.2),
                        decoration: InputDecoration(
                          hintStyle: FxTextStyle.bodyLarge(
                              fontWeight: 500,
                              letterSpacing: 0,
                              color:
                                  theme.colorScheme.onBackground.withAlpha(70)),
                          hintText: "....",
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          isDense: true,
                          contentPadding: const EdgeInsets.only(
                              left: 16, top: 2, bottom: 16),
                        ),
                        autofocus: false,
                        keyboardType: TextInputType.multiline,
                        controller: controller.town,
                        //   validator: controller.validateText,
                      ),
                      const LineContainer(),*/
                      const SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, top: 15),
                        child: FxText.bodyLarge("Dirección"),
                      ),
                      TextFormField(
                        enabled: !controller.isreadonly.value,
                        style: FxTextStyle.bodyMedium(
                            color:
                                theme.colorScheme.onBackground.withAlpha(130),
                            fontWeight: 600,
                            letterSpacing: 0.2),
                        decoration: InputDecoration(
                          hintStyle: FxTextStyle.bodyLarge(
                              fontWeight: 500,
                              letterSpacing: 0,
                              color:
                                  theme.colorScheme.onBackground.withAlpha(70)),
                          hintText: "....",
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          isDense: true,
                          contentPadding: const EdgeInsets.only(
                              left: 16, top: 2, bottom: 16),
                        ),
                        autofocus: false,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        controller: controller.addres,
                        //   validator: controller.validateText,
                      ),
                      const LineContainer(),
                      const SizedBox(
                        height: 16,
                      ),
                      Visibility(
                        visible: !controller.isreadonly.value,
                        child: CustomButton(
                          loading: controller.loadrequest.value,
                          text: "Actualizar",
                          borderRadius: BorderRadius.circular(30),
                          onTap: () async {
                            await controller.updateprofile();
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  AppBar appbar() {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      centerTitle: true,
      toolbarHeight: 60,
      backgroundColor: theme.appBarTheme.backgroundColor,
      automaticallyImplyLeading: false,
      actionsIconTheme: IconThemeData(color: theme.primaryColor),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Builder(
              builder: (context) => IconButton(
                    icon: Icon(
                      FeatherIcons.arrowLeft,
                      color: theme.primaryColor,
                    ),
                    onPressed: () => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()),
                        (Route<dynamic> route) => true),
                  )),
          Expanded(
              child: FxText.titleLarge(
            'Editar Perfil',
            textAlign: TextAlign.center,
            color: theme.primaryColor,
          )),
          const SizedBox(
            width: 5,
          ),
          Obx(() => IconButton(
              icon: Icon(
                controller.isreadonly.value
                    ? FeatherIcons.edit
                    : FeatherIcons.eye,
                color: theme.primaryColor,
              ),
              onPressed: () {
                setState(() {
                  controller.isreadonly.value = !controller.isreadonly.value;
                });
              })),
          const SizedBox(
            width: 5,
          ),
        ],
      ),
    );
  }

  _showDialog() {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: theme.dividerColor,
          contentPadding: FxSpacing.only(left: 16, right: 16),
          actionsAlignment: MainAxisAlignment.center,
          actionsPadding: FxSpacing.only(bottom: 16),
          title: Center(
            child: FxText.titleMedium('Seleccione la imagen de perfil',
                height: 1.2, fontWeight: 600),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.only(top: 16),
              ),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(theme.colorScheme.primary)),
                child: FxText.titleMedium('Tomar Foto',
                    color: theme.colorScheme.background,
                    fontWeight: 600,
                    letterSpacing: 0.3),
                onPressed: () async {
                  await controller.subirimagen(ImageSource.camera);
                  controller.goBack();
                },
              ),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(theme.colorScheme.primary)),
                child: FxText.titleMedium('Seleccionar de la Galeria',
                    color: theme.colorScheme.background,
                    fontWeight: 600,
                    letterSpacing: 0.3),
                onPressed: () async {
                  await controller.subirimagen(ImageSource.gallery);
                  controller.goBack();
                },
              ),
            ],
          ),
          actions: <Widget>[],
        );
      },
    );
  }
}
