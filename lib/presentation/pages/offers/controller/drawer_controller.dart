import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get.dart';
import 'package:client.gogogo/presentation/pages/auth/sign_in/login_ui.dart';
import 'package:hive/hive.dart';

enum ProductViewType { grid, list }

class DrawerController extends FxController {
  TickerProvider ticker;
  DrawerController(this.ticker);

  var nameuser = "".obs;
  var avatar = "".obs;

  @override
  Future<void> initState() async {
    super.initState();
    var box = await Hive.openBox('SessionFR');
    nameuser.value = box.get('name') + " " + box.get('lastname');
    avatar.value = box.get('avatar') ?? "";
  }

  double findAspectRatio() {
    double width = MediaQuery.of(context).size.width;
    return ((width - 58) / 2) / (250);
  }

  void goBack() {
    Navigator.pop(context);
  }

  Future<bool> onWillPop() async {
    return true;
  }

  void logout() async {
    await Hive.deleteBoxFromDisk('SessionFR');

    //  Navigator.of(context).pushReplacementNamed('/login');
    // ignore: use_build_context_synchronously
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const SignInUI()),
        (Route<dynamic> route) => false);
  }

  @override
  String getTag() {
    return "drawer_controller";
  }
}
