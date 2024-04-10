import 'package:flutter/material.dart';
import 'package:flutter_dropdown_alert/dropdown_alert.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:client.gogogo/presentation/pages/auth/edit_profile/pages/edit_profile_page.dart';
import 'package:client.gogogo/presentation/themes/theme/app_theme.dart';
import 'package:provider/provider.dart';

import 'data/localizations/app_localization_delegate.dart';
import 'data/localizations/language.dart';
import 'presentation/pages/auth/sign_in/login_ui.dart';
import 'presentation/themes/theme/app_notifier.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppNotifier>(
      builder: (BuildContext context, AppNotifier value, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.shoppingTheme,
          builder: (context, child) {
            return Directionality(
              textDirection: AppTheme.textDirection,
              child: Stack(
                children: [
                  child!,
                  const DropdownAlert(
                      //  titleStyle: appTheme.textTheme.bodyLarge,
                      // contentStyle: AppTheme.shoppingTheme.textTheme.bodyLarge,
                      )
                ],
              ),
            );
          },

          // home: IntroScreen(),
          // home: SplashScreen(),

          home: SignInUI(),
          /*  routes: {
            // Cuando naveguemos hacia la ruta "/", crearemos el Widget FirstScreen
            '/': (context) => const SignInUI(),
            // Cuando naveguemos hacia la ruta "/second", crearemos el Widget SecondScreen
            '/home': (context) => const HomePage(),
            '/registro': (context) => const SignUpUI(),
            '/login': (context) => const SignInUI(),
            '/forgot': (context) => const ForgotPasswordScreen(),
            '/resetpasword': (context) => const ResetPasswordScreen(),
            '/request': (context) => const RequestPage(
                  edit: false,
                  solicitud: null,
                ),
            '/requestedit': (context) => RequestPage(
                  edit: true,
                  solicitud: null,
                ),
            '/reqselect': (context) => const RequestSelectPage(edit: false),
            '/reqselectedit': (context) => const RequestSelectPage(edit: true),
            '/contactus': (context) => const ContactUsPage(),
            '/terms': (context) => const TermsAndConditions(),
          },*/
        );
      },
    );
  }
}
