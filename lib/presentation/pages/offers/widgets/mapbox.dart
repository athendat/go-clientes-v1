import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class Mapboxwidget extends StatelessWidget {
  const Mapboxwidget({
    super.key,
    required this.value,
  });

  final CameraPosition value;

  @override
  Widget build(BuildContext context) {
    return MapboxMap(
      accessToken:
          "sk.eyJ1IjoiYW5kaWVsZGV2IiwiYSI6ImNsanJhYXF4czBncTQzanM1NHA2bWMxenMifQ.2juV5bVXicruUB7URUM_TA",
      initialCameraPosition: value,
      myLocationEnabled: true,
    );
  }
}
