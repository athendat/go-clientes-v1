import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

LatLng ltl = const LatLng(23.0719070, -82.3552980);
CameraPosition _initialCameraPosition =
    CameraPosition(target: ltl, zoom: 14);
var helloWorldProvider =
    Provider<CameraPosition>((_) => _initialCameraPosition);
