import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

// ignore: constant_identifier_names
const MAPBOX_ACCESS_TOKEN =
    'sk.eyJ1IjoiYW5kaWVsZGV2IiwiYSI6ImNsanJhYXF4czBncTQzanM1NHA2bWMxenMifQ.2juV5bVXicruUB7URUM_TA';

class MapScreenBox extends StatefulWidget {
  const MapScreenBox({super.key});

  @override
  State<MapScreenBox> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreenBox> {
  LatLng? myPosition;
  late var makers = [
    Marker(
      point: myPosition!,
      builder: (context) {
        return const Icon(
          Icons.person_pin,
          color: Colors.blueAccent,
          size: 40,
        );
      },
    )
  ];

  Future<Position> determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('error');
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  void getCurrentLocation() async {
    Position position = await determinePosition();
    setState(() {
      myPosition = LatLng(position.latitude, position.longitude);
      //  // print(myPosition);
    });
  }

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: const Text('Mapa'),
        backgroundColor: Colors.blueAccent,
      ),
      body: myPosition == null
          ? const CircularProgressIndicator()
          : FlutterMap(
              options: MapOptions(
                  onTap: (tapPosition, point) {
                    makers.add(Marker(
                      point: LatLng(point.latitude, point.longitude),
                      builder: (context) {
                        return const Icon(
                          Icons.person_pin,
                          color: Color.fromARGB(255, 255, 68, 121),
                          size: 40,
                        );
                      },
                    ));
                  },
                  center: myPosition,
                  minZoom: 5,
                  maxZoom: 25,
                  zoom: 18),
              nonRotatedChildren: [
                TileLayer(
                  urlTemplate:
                      'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
                  additionalOptions: const {
                    'accessToken': MAPBOX_ACCESS_TOKEN,
                    'id': 'mapbox/streets-v12'
                  },
                ),
                MarkerLayer(
                  markers: makers,
                )
              ],
            ),
    );
  }
}
