import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:client.gogogo/presentation/pages/home/widgets/widget_error_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:client.gogogo/presentation/components/status_of_delivery.dart';
import 'package:client.gogogo/presentation/pages/request/screen/request_page.dart';
import '../widgets/app_drawer.dart';
import '../../../components/loading_effect.dart';
import '../../../themes/theme/app_theme.dart';
import '../controller/home_controller.dart';
import '../widgets/list_clientrequest.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late ThemeData theme;

  late HomeController controller;
  late OutlineInputBorder outlineInputBorder;
  List<Tasks> tasks = [];

  @override
  void initState() {
    super.initState();
    theme = AppTheme.shoppingLightTheme;

    controller = FxControllerStore.put(HomeController(this));
    outlineInputBorder = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<HomeController>(
        controller: controller,
        builder: (controller) {
          return Scaffold(
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              resizeToAvoidBottomInset: false,
              //  floatingActionButton: floatingB(theme: theme),
              drawer: const AppDrawer(),
              appBar: appBar(controller, context),
              body: bodyHome(
                theme: theme,
                controller: controller,
              ));
        });
  }

  AppBar appBar(HomeController controller, BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(35.0),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 15),
          child: TextFormField(
            onFieldSubmitted: (a) async {
              controller.getrequests();
              FocusScope.of(context).requestFocus(FocusNode());
            },
            onChanged: (text) {
              text.length == 0
                  ? {
                      controller.getrequests(),
                      FocusScope.of(context).requestFocus(FocusNode())
                    }
                  : null;
            },
            controller: controller.textsearch,
            style: FxTextStyle.bodyMedium(),
            cursorColor: theme.colorScheme.primary,
            decoration: InputDecoration(
              hintText: "Buscar Solicitudes ...",
              hintStyle:
                  FxTextStyle.bodySmall(color: theme.colorScheme.onBackground),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                  borderSide: BorderSide.none),
              enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                  borderSide: BorderSide.none),
              focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                  borderSide: BorderSide.none),
              filled: true,
              fillColor: theme.cardTheme.color,
              prefixIcon: Icon(
                FeatherIcons.search,
                size: 16,
                color: theme.colorScheme.onBackground.withAlpha(150),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  FeatherIcons.delete,
                  color: theme.colorScheme.onBackground,
                ),
                onPressed: () {
                  setState(() {
                    controller.textsearch.text = "";
                    controller.getrequests();
                  });
                },
              ),
              isDense: true,
            ),
            textInputAction: TextInputAction.search,
            textCapitalization: TextCapitalization.sentences,
          ),
        ),
      ),
      centerTitle: true,
      toolbarHeight: 86,
      backgroundColor: theme.appBarTheme.backgroundColor,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Builder(
            builder: (context) => IconButton(
                icon: Icon(
                  FeatherIcons.menu,
                  color: theme.primaryColor,
                ),
                onPressed: () => Scaffold.of(context).openDrawer()),
          ),
          Expanded(
              child: FxText.titleLarge(
            'Mis Solicitudes',
            textAlign: TextAlign.center,
            color: theme.primaryColor,
          )),
          Builder(
            builder: (context) => IconButton(
                icon: Icon(
                  FeatherIcons.bell,
                  color: theme.primaryColor,
                ),
                onPressed: () {}),
          ),
        ],
      ),
    );
  }
}

class bodyHome extends StatelessWidget {
  const bodyHome({
    super.key,
    required this.theme,
    required this.controller,
  });

  final ThemeData theme;
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/img/png/bg_main.png',
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
        ),
        RefreshIndicator(
          onRefresh: controller.getrequests,
          child: FadedSlideAnimation(
            beginOffset: const Offset(0, 0.3),
            endOffset: const Offset(0, 0),
            child: Obx(() => ListView(
                  padding: FxSpacing.only(top: 10, bottom: 50),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 10),
                      child: StatusOfDelivery(controller: controller),
                    ),
                    controller.loadrequest.value
                        ? FadedScaleAnimation(
                            child: LoadingEffect.getOrderLoadingScreen(context))
                        : controller.exeption.value
                            ? WidgetErrorLoading(controller)
                            : controller.requests.isNotEmpty
                                ? ListClientRequest(
                                    tasks: controller.requests,
                                    theme: theme,
                                    controller: controller)
                                : Padding(
                                    padding: const EdgeInsets.only(top: 120),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        FadedScaleAnimation(
                                          child: Visibility(
                                            visible: true,
                                            child: Image.asset(
                                              'assets/img/png/notfound.png',
                                              scale: 2.0,
                                            ),
                                          ),
                                        ),
                                        FadedScaleAnimation(
                                          child: FxText.bodyLarge(
                                            "No se encontraron solicitudes! ",
                                            color: theme.colorScheme.onPrimary,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                  ],
                )),
            // curve: Curves.linearToEaseOut,
          ),
        ),
        Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              backgroundColor: theme.primaryColor,
              child: const Icon(
                FeatherIcons.plus,
                size: 36,
              ),
              onPressed: () {
                //controller.getrequests();
                Navigator.of(context, rootNavigator: true)
                    .push(MaterialPageRoute(
                  builder: (context) =>
                      const RequestPage(edit: false, solicitud: null),
                ));
              },
            ))
      ],
    );
  }
}

class floatingB extends StatelessWidget {
  const floatingB({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: theme.primaryColor,
      child: const Icon(
        FeatherIcons.plus,
        size: 36,
      ),
      onPressed: () {
        //controller.getrequests();
        Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
          builder: (context) => const RequestPage(edit: false, solicitud: null),
        ));
      },
    );
  }
}
