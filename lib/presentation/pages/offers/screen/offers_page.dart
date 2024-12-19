import 'package:animation_wrappers/animation_wrappers.dart';
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
import '../controller/offers_controller.dart';
import '../widgets/list_offers.dart';
import '../widgets/widget_error_loading.dart';


class OffersPage extends StatefulWidget {
  final String requestId;
  final String requestNo;

  const OffersPage({Key? key, required this.requestId, required this.requestNo}) : super(key: key);
  
  @override 
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<OffersPage> with TickerProviderStateMixin {
  late ThemeData theme;

  late OffersController controller;
  late OutlineInputBorder outlineInputBorder;
  

  @override
  void initState() {
    super.initState();
    theme = AppTheme.shoppingLightTheme;

    controller = FxControllerStore.put(OffersController(this,widget.requestId));
    outlineInputBorder = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<OffersController>(
        controller: controller,
        builder: (controller) {
          return Scaffold(
              //drawer: const AppDrawer(),
              appBar: AppBar(
                      iconTheme: IconThemeData(color: theme.primaryColor, ),
                      title: FxText.titleLarge(
                          'Ofertas: ${widget.requestNo}',
                          textAlign: TextAlign.center, 
                          color: theme.primaryColor,
                        ),),//appBar(controller, context),
              body: bodyHome(
                theme: theme,
                controller: controller,
              ));
        });
  }

  AppBar appBar(OffersController controller, BuildContext context) {
    return AppBar(
    
    centerTitle: true,
    toolbarHeight: 50,
    backgroundColor: theme.appBarTheme.backgroundColor,
    actions: [],
    automaticallyImplyLeading: false,
    title: Stack(
     // mainAxisSize: MainAxisSize.max,
      children: [ 
       Builder(
          builder: (context) => IconButton(
              icon: Icon(
                FeatherIcons.arrowLeft,
                color: const Color.fromARGB(255, 155, 141, 15),
              ),
              onPressed: () => controller.goBack()),
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
  final OffersController controller;

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
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: RefreshIndicator(
          onRefresh: controller.getBids,
          child: FadedSlideAnimation(
            beginOffset: const Offset(0, 0.3),
            endOffset: const Offset(0, 0),
            child: Obx(() => 
                    controller.loadrequest.value
                        ? FadedScaleAnimation(
                            child: LoadingEffect.getOrderLoadingScreen(context))
                        : controller.exeption.value
                            ? WidgetErrorLoading(controller)
                            : controller.bids.isNotEmpty
                                ? ListClientOffers(
                                    offers: controller.bids,
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
                ),
            // curve: Curves.linearToEaseOut,
          ),
        ),),
      ],
    );
  }
}
