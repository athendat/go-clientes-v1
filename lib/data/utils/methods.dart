import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image/image.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:path_provider/path_provider.dart';

//import '../../app.dart';
//import '../../bootstrap.dart';
import '../../core/gen/assets.gen.dart';
import '../../presentation/themes/theme/app_theme.dart';

Future<void> initMethod() async {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await initHybridComposition();
  await initHiveForFlutter();
  AppTheme.init();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

//  await bootstrap(App.new);
}

Future<void> initHybridComposition() async {
  if (!kIsWeb && Platform.isAndroid) {
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    final sdkVersion = androidInfo.version.sdkInt;
    if (sdkVersion != null && sdkVersion >= 29) {
      MapboxMap.useHybridComposition = true;
    } else {
      MapboxMap.useHybridComposition = false;
    }
  }
}

Future<File> createPdfFileFromBase64(String base64Pdf) async {
  final bytes = base64Decode(base64Pdf);
  final directory = await getTemporaryDirectory();
  final pdfFile = File('${directory.path}/tempPdf.pdf');
  await pdfFile.writeAsBytes(bytes, flush: true);
  return pdfFile;
}

// create image from base64

Future<File> createImageFileFromBase64(String base64Image) async {
  Uint8List bytes;
  if (isValidBase64Image(base64Image)) {
    bytes = base64Decode(base64Image);
  } else {
    // Carga la imagen predeterminada de los activos
    final byteData = await rootBundle.load(Assets.img.png.bg.path);
    bytes = byteData.buffer.asUint8List();
  }

  final directory = await getTemporaryDirectory();
  final imageFile = File('${directory.path}/${base64Image.hashCode}.jpg');
  await imageFile.writeAsBytes(bytes, flush: true);
  return imageFile;
}

bool isValidBase64Image(String base64Image) {
  try {
    final bytes = base64Decode(base64Image);
    final image = decodeImage(bytes);
    return image != null;
  } catch (e) {
    return false;
  }
}
