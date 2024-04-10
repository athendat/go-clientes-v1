import 'package:flutter/material.dart';

import '../others/create_trip.dart';
import '../pages/auth/sign_in/login_ui.dart';
import '../pages/auth/sign_up/register_ui.dart';
import '../pages/auth/verification/activate_code_page.dart';
import '../pages/home/screen/home_page.dart';

class PageRoutes {
  static const String signIn = "signIn";
  static const String signUp = "signUp";
  static const String verification = "verification";
  static const String home = "home";
  static const String truckAndTripInfo = "truckAndTripInfo";
  static const String createTrip = "createTrip";
  static const String selectLocation = "selectLocation";
  static const String myTrucks = "myTrucks";
  static const String truckInfo = "truckInfo";
  static const String myDrivers = "myDrivers";
  static const String driverInfo = "driverInfo";
  static const String myAccount = "myAccount";
  static const String termsAndConditions = "termsAndConditions";
  static const String contactUs = "contactUs";
  static const String changeLanguage = "changeLanguage";

  Map<String, WidgetBuilder> routes() {
    return {
      signIn: (context) => const SignInUI(),
      signUp: (context) => const SignUpUI(),
      verification: (context) => const ActivationCodePage(),
      home: (context) => const HomePage(),
      createTrip: (context) => const CreateTripPage(),
    };
  }
}
