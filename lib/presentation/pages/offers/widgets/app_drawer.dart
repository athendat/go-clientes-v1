import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:client.gogogo/presentation/pages/auth/edit_profile/pages/edit_profile_page.dart';
import 'package:client.gogogo/presentation/pages/contactus/pages/contact_us.dart';
import 'package:client.gogogo/presentation/pages/home/screen/terms_and_conditions.dart';
import 'package:client.gogogo/presentation/themes/theme/app_theme.dart';

import '../controller/drawer_controller.dart' as drawer;

class AppDrawerItems {
  final String? name;
  final IconData icon;

  AppDrawerItems(this.name, this.icon);
}

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> with TickerProviderStateMixin {
  late ThemeData theme;

  late drawer.DrawerController controller;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.shoppingLightTheme;

    controller = FxControllerStore.put(drawer.DrawerController(this));
  }

  @override
  Widget build(BuildContext context) {
    List<AppDrawerItems> appDrawerItems = [
      AppDrawerItems('Inicio', Icons.home),
      AppDrawerItems('Mi Perfil', Icons.person),
      AppDrawerItems('Términos y Condiciones', Icons.policy_rounded),
      AppDrawerItems('Contáctenos', Icons.phone),
      AppDrawerItems('Cerrar Sesión', Icons.logout_sharp),
    ];
    return FxBuilder<drawer.DrawerController>(
        controller: controller,
        builder: (controller) {
          return Container(
            color: theme.cardColor,
            child: Drawer(
              elevation: 0.0,
              child: ListView(
                children: [
                  const SizedBox(
                    height: 28,
                  ),
                  Center(
                    child: SizedBox(
                      height: 120,
                      width: 120,
                      child: FadedScaleAnimation(
                          child: Obx(() => FxContainer.bordered(
                                color: theme.colorScheme.primary.withAlpha(120),
                                paddingAll: 2,
                                borderRadiusAll: 100,
                                child: controller.avatar.value != ""
                                    ? ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: CachedNetworkImage(
                                          width: 118,
                                          height: 118,
                                          imageUrl: controller.avatar.value,
                                          placeholder: (context, url) =>
                                              CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      )
                                    : Icon(
                                        Icons.person,
                                        color: theme.colorScheme.background,
                                        size: 80,
                                      ),
                              ))),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(() => FxText.bodyLarge(
                        controller.nameuser.value == ""
                            ? "Error al cargar name"
                            : controller.nameuser.value,
                        textAlign: TextAlign.center,
                        fontWeight: 700,
                      )),
                  const SizedBox(
                    width: 8,
                  ),
                  FxText.bodyMedium(
                    '',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  FadedSlideAnimation(
                    beginOffset: const Offset(0.3, 0.3),
                    endOffset: const Offset(0, 0),
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: appDrawerItems.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 4),
                            leading: Icon(
                              appDrawerItems[index].icon,
                              color: theme.primaryColor,
                            ),
                            title: FxText.bodyLarge(
                              appDrawerItems[index].name!,
                            ),
                            onTap: index == 0
                                ? () {
                                    Navigator.pop(context);
                                  }
                                : index == 1
                                    ? () {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const EditProfilePage(),
                                          ),
                                        );
                                      }
                                    : index == 2
                                        ? () {
                                            Navigator.pop(context);
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const TermsAndConditions(),
                                              ),
                                            );
                                          }
                                        : index == 3
                                            ? () {
                                                Navigator.pop(context);
                                                Navigator.of(context,
                                                        rootNavigator: true)
                                                    .push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const ContactUsPage(),
                                                  ),
                                                );
                                              }
                                            : index == 4
                                                ? () {
                                                    controller.logout();
                                                  }
                                                : () {
                                                    controller.logout();
                                                  },
                          );
                        }),
                    // curve: Curves.easeInCubic,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
