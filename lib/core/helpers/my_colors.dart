import 'package:flutter/material.dart';

class MyColors {
  static Color primaryColor = const Color(0xFF37B34A);
  static Color onboardingColor = const Color(0xFFFFFFFF);
  static Color primaryColorDark = const Color(0xFF37B34A);
  static Color primaryOpacityColor = const Color(0xFFF3F5F3);

  static Color textfiledcolor = const Color(0xFFb5c0b7);
  static Color blueNurse = const Color(0xFF39eab6);
  static Color blueNurse57 = const Color(0xFF397AEA);
  static Color greenNurse57 = const Color(0xFF39eab6);
  static Color greentransp = const Color.fromARGB(136, 57, 234, 181);
  static Color greenc = const Color(0xFF7be8b4);
  static Color greencc = const Color.fromARGB(255, 170, 237, 205);

  static Color greenl = const Color.fromRGBO(98, 201, 151, 1);

  static Color greenNurseclear = const Color.fromARGB(43, 57, 234, 181);
  static Color blueNurseopacity37 = const Color(0xFFF3F3FB);
  static Color blueNurseopacity27 = const Color(0xFFA6C2F3);
  static Color greenNurse = const Color.fromARGB(255, 8, 222, 161);
  static Color? greyNurse = const Color.fromARGB(255, 61, 60, 60);
  static Color? greyc = const Color.fromARGB(255, 223, 221, 221);
  static Color? greyb = const Color.fromARGB(255, 61, 60, 60);
  static Color? greyb2 = const Color.fromARGB(255, 121, 119, 119);
  static Color? greyTextfilds = const Color.fromARGB(255, 246, 243, 243);
  static Color redb = const Color.fromARGB(255, 234, 57, 57);
  static Color greenGames = const Color.fromARGB(255, 234, 236, 235);

  static Color bluecard1 = const Color(0xFF30AAAE);
  static Color greencard1 = const Color(0xFF26db85);
}

class MyStyles {
  static List<Color> colorsloadingColors = [
    MyColors.blueNurse,
  ];

  static double cardfactorsize = 0.35;

  static var boxdcarusel = BoxDecoration(
      borderRadius: BorderRadius.circular(MyStyles.radios10),
      boxShadow: const [
        BoxShadow(
          color: Color.fromARGB(62, 143, 145, 146),
          blurRadius: 3,
          offset: Offset(0, 5),
        ),
      ],
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          MyColors.greenNurse57,
          // MyColors.greenc,
          MyColors.greenc,
        ],
      ));

  static var boxdcaruselLastvotes = BoxDecoration(
      borderRadius: BorderRadius.circular(MyStyles.radios10),
      boxShadow: const [
        BoxShadow(
          color: Color.fromARGB(62, 143, 145, 146),
          blurRadius: 3,
          offset: Offset(0, 5),
        ),
      ],
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          MyColors.bluecard1,
          MyColors.greencard1,
        ],
      ));

  static var boxcaruselpatrocinadores = BoxDecoration(
      borderRadius: BorderRadius.circular(MyStyles.radios10),
      boxShadow: const [
        BoxShadow(
          color: Color.fromARGB(62, 143, 145, 146),
          blurRadius: 3,
          offset: Offset(0, 5),
        ),
      ],
      color: Colors.transparent);

  static TextStyle logtextst = const TextStyle(
      fontSize: 17,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w500,
      color: Colors.black);

  static TextStyle logtextst2 = const TextStyle(
      fontSize: 15,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.normal,
      color: Colors.black);

  static const double radiosN = 25;
  static const double radios10 = 10;

  static const String letterprimary = 'Roboto';
  static const String lettersecundary = 'Poppins';

  static TextStyle menuuser = TextStyle(
      color: MyColors.greyNurse,
      fontWeight: FontWeight.w300,
      fontFamily: 'PoppinsR',
      fontSize: 13);

  static TextStyle quizenum = const TextStyle(
      color: Colors.black87,
      fontWeight: FontWeight.w600,
      fontFamily: 'PoppinsR',
      fontSize: 15);

  //style text top card games
  static TextStyle textcardgames = const TextStyle(
      color: Color.fromARGB(255, 74, 73, 73),
      fontWeight: FontWeight.bold,
      fontFamily: 'PoppinsR',
      fontSize: 13);
  static TextStyle listgoal = const TextStyle(
      color: Color.fromARGB(255, 74, 73, 73),
      fontWeight: FontWeight.normal,
      fontFamily: 'PoppinsR',
      fontSize: 10);
  static TextStyle textcardgames2 = const TextStyle(
      color: Color.fromARGB(255, 249, 247, 247),
      fontWeight: FontWeight.bold,
      fontFamily: 'PoppinsR',
      fontSize: 15);
  static TextStyle textcardgames3 = const TextStyle(
      color: Color.fromARGB(255, 249, 247, 247),
      fontWeight: FontWeight.bold,
      fontFamily: 'PoppinsR',
      fontSize: 26);
  static TextStyle textcardgamesP = const TextStyle(
      color: Color.fromARGB(255, 74, 73, 73),
      fontWeight: FontWeight.bold,
      fontFamily: 'PoppinsR',
      fontSize: 13);

  static TextStyle textscoreVote = const TextStyle(
      color: Color.fromARGB(255, 74, 73, 73),
      fontWeight: FontWeight.bold,
      fontFamily: 'PoppinsR',
      fontSize: 45);

  //dialog info votes styles
  static TextStyle textdialog = const TextStyle(
      color: Color.fromARGB(255, 74, 73, 73),
      fontWeight: FontWeight.normal,
      fontFamily: 'PoppinsR',
      fontSize: 10);

  //old
  static TextStyle menupopup = TextStyle(
      fontSize: 12,
      fontFamily: 'PoppinsR',
      fontWeight: FontWeight.normal,
      color: MyColors.blueNurse);
  static TextStyle textfieldformsg = const TextStyle(
      fontSize: 12,
      fontFamily: 'PoppinsR',
      fontWeight: FontWeight.normal,
      color: Colors.grey);
  static TextStyle textfieldforms = const TextStyle(
      fontSize: 12,
      fontFamily: 'PoppinsR',
      fontWeight: FontWeight.normal,
      color: Colors.black);
  static TextStyle encabezadoBlueL1 = TextStyle(
      color: MyColors.blueNurse,
      fontWeight: FontWeight.bold,
      fontFamily: 'OstrichSans-Black',
      fontSize: 15);
  static TextStyle encabezadoGreyL1 = TextStyle(
      color: MyColors.greyNurse,
      fontWeight: FontWeight.bold,
      fontFamily: 'OstrichSans-Black',
      fontSize: 15);
  // ignore: prefer_const_constructors
  static TextStyle tabsStyle = TextStyle(
      color: MyColors.onboardingColor,
      fontFamily: 'PoppinsR',
      fontWeight: FontWeight.bold,
      fontSize: 12);
  static TextStyle textStyle = TextStyle(
      color: MyColors.onboardingColor,
      fontWeight: FontWeight.bold,
      fontFamily: 'PoppinsR',
      fontSize: 10);
  static TextStyle textStylerank = TextStyle(
      color: MyColors.greyb,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.bold,
      fontFamily: 'PoppinsR',
      fontSize: 15);
  static TextStyle textStylerank2 = TextStyle(
      color: MyColors.greyb,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w300,
      fontFamily: 'PoppinsR',
      fontSize: 12);
  static TextStyle contdateBBlue = TextStyle(
      color: MyColors.blueNurse,
      fontWeight: FontWeight.bold,
      fontFamily: 'PoppinsR',
      fontSize: 10);
  static TextStyle textStyle2 = TextStyle(
      color: MyColors.onboardingColor,
      fontWeight: FontWeight.normal,
      fontFamily: 'PoppinsR',
      fontSize: 10);
  static TextStyle contdate = const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.normal,
      fontFamily: 'PoppinsR',
      fontSize: 10);
  static TextStyle homepoints = const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w400,
      fontFamily: 'PoppinsR',
      fontSize: 13);
  static TextStyle homepointsB = const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontFamily: 'PoppinsR',
      fontSize: 13);
  static TextStyle contdateB = const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontFamily: 'PoppinsR',
      fontSize: 10);
  static TextStyle dialogTreatments1 = TextStyle(
      color: MyColors.greyNurse,
      fontWeight: FontWeight.bold,
      fontFamily: 'Roboto',
      fontSize: 12);
  static TextStyle dialogDocStatus = TextStyle(
      color: MyColors.onboardingColor,
      fontWeight: FontWeight.bold,
      fontFamily: 'Roboto',
      fontSize: 15);
  static TextStyle dialogTreatments2 = TextStyle(
      color: MyColors.greyNurse,
      fontWeight: FontWeight.bold,
      fontFamily: 'PoppinsR',
      fontSize: 15);

  static TextStyle appBarBlue = TextStyle(
      color: MyColors.greyb,
      fontWeight: FontWeight.w600,
      fontFamily: 'Roboto',
      fontSize: 20);
  static TextStyle appBarWhite = TextStyle(
      color: MyColors.onboardingColor,
      fontWeight: FontWeight.bold,
      fontFamily: 'OstrichSans-Black',
      fontSize: 20);
}

class Themes {
  static ThemeData theme1 = ThemeData(
    fontFamily: 'Roboto',
    primaryColor: MyColors.bluecard1,
    inputDecorationTheme: const InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(MyStyles.radiosN)),
        borderSide: BorderSide(width: 0.5, color: Colors.greenAccent),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(MyStyles.radiosN)),
        borderSide: BorderSide(width: 0.5, color: Colors.amberAccent),
      ),
    ),
  );
}
