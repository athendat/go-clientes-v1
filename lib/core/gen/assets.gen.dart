/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImgGen {
  const $AssetsImgGen();

  /// File path: assets/img/icon.png
  AssetGenImage get icon => const AssetGenImage('assets/img/icon.png');

  $AssetsImgPngGen get png => const $AssetsImgPngGen();

  /// File path: assets/img/splash.png
  AssetGenImage get splash => const AssetGenImage('assets/img/splash.png');

  /// List of all assets
  List<AssetGenImage> get values => [icon, splash];
}

class $AssetsImgPngGen {
  const $AssetsImgPngGen();

  /// File path: assets/img/png/Layer 1344 copy.png
  AssetGenImage get layer1344Copy =>
      const AssetGenImage('assets/img/png/Layer 1344 copy.png');

  /// File path: assets/img/png/Logo TrucksUp.png
  AssetGenImage get logoTrucksUp =>
      const AssetGenImage('assets/img/png/Logo TrucksUp.png');

  /// File path: assets/img/png/Profile pic.png
  AssetGenImage get profilePic =>
      const AssetGenImage('assets/img/png/Profile pic.png');

  /// File path: assets/img/png/bg.2.png
  AssetGenImage get bg2 => const AssetGenImage('assets/img/png/bg.2.png');

  /// File path: assets/img/png/bg.png
  AssetGenImage get bg => const AssetGenImage('assets/img/png/bg.png');

  /// File path: assets/img/png/bg_main.png
  AssetGenImage get bgMain => const AssetGenImage('assets/img/png/bg_main.png');

  /// File path: assets/img/png/bg_main2.png
  AssetGenImage get bgMain2 =>
      const AssetGenImage('assets/img/png/bg_main2.png');

  /// File path: assets/img/png/fondo app.jpg
  AssetGenImage get fondoApp =>
      const AssetGenImage('assets/img/png/fondo app.jpg');

  /// File path: assets/img/png/map_style.txt
  String get mapStyle => 'assets/img/png/map_style.txt';

  /// File path: assets/img/png/notfound.png
  AssetGenImage get notfound =>
      const AssetGenImage('assets/img/png/notfound.png');

  /// File path: assets/img/png/pin.png
  AssetGenImage get pin => const AssetGenImage('assets/img/png/pin.png');

  /// File path: assets/img/png/pin2.png
  AssetGenImage get pin2 => const AssetGenImage('assets/img/png/pin2.png');

  /// File path: assets/img/png/pin3.png
  AssetGenImage get pin3 => const AssetGenImage('assets/img/png/pin3.png');

  /// File path: assets/img/png/pin4.png
  AssetGenImage get pin4 => const AssetGenImage('assets/img/png/pin4.png');

  /// File path: assets/img/png/pind.png
  AssetGenImage get pind => const AssetGenImage('assets/img/png/pind.png');

  /// File path: assets/img/png/pinred.png
  AssetGenImage get pinred => const AssetGenImage('assets/img/png/pinred.png');

  /// File path: assets/img/png/pinwithpic.png
  AssetGenImage get pinwithpic =>
      const AssetGenImage('assets/img/png/pinwithpic.png');

  /// File path: assets/img/png/splash.png
  AssetGenImage get splash => const AssetGenImage('assets/img/png/splash.png');

  /// File path: assets/img/png/truck.jpg
  AssetGenImage get truckJpg => const AssetGenImage('assets/img/png/truck.jpg');

  /// File path: assets/img/png/truck.png
  AssetGenImage get truckPng => const AssetGenImage('assets/img/png/truck.png');

  /// File path: assets/img/png/truck2.jpg
  AssetGenImage get truck2 => const AssetGenImage('assets/img/png/truck2.jpg');

  /// File path: assets/img/png/truck3.jpg
  AssetGenImage get truck3 => const AssetGenImage('assets/img/png/truck3.jpg');

  /// File path: assets/img/png/truck4.jpg
  AssetGenImage get truck4 => const AssetGenImage('assets/img/png/truck4.jpg');

  /// List of all assets
  List<dynamic> get values => [
        layer1344Copy,
        logoTrucksUp,
        profilePic,
        bg2,
        bg,
        bgMain,
        bgMain2,
        fondoApp,
        mapStyle,
        notfound,
        pin,
        pin2,
        pin3,
        pin4,
        pind,
        pinred,
        pinwithpic,
        splash,
        truckJpg,
        truckPng,
        truck2,
        truck3,
        truck4
      ];
}

class Assets {
  Assets._();

  static const $AssetsImgGen img = $AssetsImgGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
