import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:client.gogogo/core/helpers/environment.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../components/icon_container.dart';
import '../../../themes/theme/app_theme.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ContactUsBody();
  }
}

class ContactUsBody extends StatefulWidget {
  const ContactUsBody({Key? key}) : super(key: key);

  @override
  _ContactUsBodyState createState() => _ContactUsBodyState();
}

class _ContactUsBodyState extends State<ContactUsBody> {
  bool showDeliveryCard = false;
  late ThemeData theme;
  @override
  void initState() {
    super.initState();
    theme = AppTheme.shoppingLightTheme;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'assets/img/png/bg_main.png',
              fit: BoxFit.fill,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          AppBar(
            surfaceTintColor: Colors.transparent,
            iconTheme: IconThemeData(color: theme.colorScheme.primary),
            backgroundColor: Colors.transparent,
            title: FxText.titleLarge('Contáctenos',
                color: theme.colorScheme.primary),
          ),
          PositionedDirectional(
            top: 200,
            start: 0,
            end: 0,
            bottom: 30,
            child: FadedSlideAnimation(
              beginOffset: const Offset(0.0, 0.3),
              endOffset: const Offset(0, 0),
              fadeCurve: Curves.linearToEaseOut,
              child: ListView(
                children: [
                  Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 20),
                    decoration: BoxDecoration(
                        color: theme.appBarTheme.backgroundColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 20,
                              spreadRadius: 10,
                              color: theme.appBarTheme.backgroundColor!)
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FxText(
                          'Nuestra ubicación',
                          color: theme.cardColor.withAlpha(150),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            FxText(
                              "La Sola #307 entre Santa Catalina y  Milagros,\n municipio Diez de Octubre,provincia La Habana,\n República de Cuba",
                              color: theme.cardColor,
                            ),
                            const Spacer(),
                            const IconContainer(
                              icon: Icons.near_me,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 20),
                    decoration: BoxDecoration(
                        color: theme.appBarTheme.backgroundColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            color: theme.appBarTheme.backgroundColor!,
                          )
                        ]),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FxText(
                                'Nuestros Contactos',
                                color: theme.cardColor.withAlpha(150),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              FxText(
                                'Telefono',
                                color: theme.cardColor.withAlpha(150),
                              ),
                              FxText(
                                "+5350952149",
                                color: theme.cardColor,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              FxText(
                                'Correo electrónico',
                                color: theme.cardColor.withAlpha(150),
                              ),
                              FxText(
                                "info@go-go-go.app",
                                color: theme.cardColor,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              FxText(
                                'Telegram',
                                color: theme.cardColor.withAlpha(150),
                              ),
                              FxText(
                                "https://t.me/contacto_client.gogogo",
                                color: theme.cardColor,
                              )
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 35,
                            ),
                            GestureDetector(
                              onTap: () => makecall(),
                              child: const IconContainer(
                                icon: Icons.call,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () => sendmail(),
                              child: const IconContainer(
                                icon: Icons.mail,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () => sendTelegram(),
                              child: const IconContainer(
                                icon: Icons.telegram,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  /* Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 20),
                    decoration: BoxDecoration(
                        color: theme.appBarTheme.backgroundColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 7,
                              spreadRadius: 4,
                              color: theme.appBarTheme.backgroundColor!)
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FxText(
                          'Escribanos',
                          color: theme.cardColor.withAlpha(150),
                        ),
                        TextFormField(
                          style: FxTextStyle.bodyMedium(
                              color: theme.cardColor,
                              fontWeight: 600,
                              letterSpacing: 0.2),
                          decoration: InputDecoration(
                            hintStyle: FxTextStyle.bodyLarge(
                              fontWeight: 500,
                              letterSpacing: 0,
                              color: theme.cardColor.withAlpha(150),
                            ),
                            hintText: ".......",
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            isDense: true,
                            contentPadding: const EdgeInsets.only(
                                left: 0, top: 2, bottom: 0),
                          ),
                          autofocus: false,
                          keyboardType: TextInputType.multiline,
                          // controller: controller.observ,
                          //  validator: controller.validateText,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ),
              */
                ],
              ),
            ),
          ),
          /*  PositionedDirectional(
              bottom: 0,
              start: 0,
              end: 0,
              child: CustomButton(
                loading: false,
                text: getTranslationOf("submit"),
                borderRadius: BorderRadius.zero,
                margin: EdgeInsets.zero,
              ))*/
        ],
      ),
    );
  }

  Future<void> makecall() async {
    final Uri url = Uri(
      scheme: 'tel',
      path: Environment.numerphone,
    );
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    } else {
      await launchUrl(url);
    }
  }

  Future<void> sendmail() async {
    final Uri url = Uri(
      scheme: 'mailto',
      path: Environment.email,
      query: encodeQueryParameters(<String, String>{
        'subject': 'Sobre client.gogogo app movil!',
      }),
    );
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    } else {
      await launchUrl(url);
    }
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  void sendTelegram() async {
    final Uri url =
        Uri(scheme: 'https', host: 'telegram.me', path: Environment.telegram);
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }

    /* // print("launchingUrl: $url");
    if (await canLaunch(url)) {
      await launch(url);
    }*/
  }
}
