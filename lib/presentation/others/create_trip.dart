import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';

import 'package:client.gogogo/locale/locales.dart';

import '../components/custom_list_tile.dart';
import '../routes/routes.dart';
import '../themes/colors.dart';

class CreateTripPage extends StatelessWidget {
  const CreateTripPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CreateTripBody();
  }
}

class CreateTripBody extends StatefulWidget {
  const CreateTripBody({Key? key}) : super(key: key);

  @override
  _CreateTripBodyState createState() => _CreateTripBodyState();
}

class _CreateTripBodyState extends State<CreateTripBody> {
  //Completer<GoogleMapController> _mapController = Completer();
  // late GoogleMapController mapStyleController;
  // Set<Marker> _markers = {};
  bool showDeliveryCard = false;

  @override
  void initState() {
    /* rootBundle.loadString('assets/map_style.txt').then((string) {
      MapUtils.mapStyle = string;
    });*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: Stack(
        children: [
          /*    Container(
            height: MediaQuery.of(context).size.height,
            child: BlocBuilder<OrderMapBloc, OrderMapState>(
                builder: (context, state) {
              // print('polyyyy' + state.polylines.toString());
              return GoogleMap(
                zoomControlsEnabled: false,
                //  polylines: state.polylines,
                onTap: (val) {
                  Navigator.pushNamed(context, PageRoutes.selectLocation);
                },
                mapType: MapType.normal,
                initialCameraPosition: kGooglePlex,
                markers: _markers,
                onMapCreated: (GoogleMapController controller) async {
                  _mapController.complete(controller);
                  mapStyleController = controller;
                  mapStyleController.setMapStyle(MapUtils.mapStyle);
                  await MapUtils.getMarkerPic();
                  setState(() {
                    _markers.add(
                      Marker(
                        onTap: () {
                          Navigator.pushNamed(
                              context, PageRoutes.selectLocation);
                        },
                        markerId: MarkerId('mark1'),
                        position: LatLng(37.42796133580664, -122.085749655962),
                        icon: MapUtils.bitmapDesc1!,
                      ),
                    );
                    _markers.add(
                      Marker(
                        onTap: () {
                          Navigator.pushNamed(
                              context, PageRoutes.selectLocation);
                        },
                        markerId: MarkerId('mark2'),
                        position: LatLng(37.42496133180663, -122.081743655960),
                        icon: MapUtils.bitmapDesc1!,
                      ),
                    );
                    _markers.add(
                      Marker(
                        onTap: () {
                          Navigator.pushNamed(
                              context, PageRoutes.selectLocation);
                        },
                        markerId: MarkerId('mark3'),
                        position: LatLng(37.42196183580660, -122.089743655967),
                        icon: MapUtils.bitmapDesc1!,
                      ),
                    );
                  });
                },
              );
            }),
          ),
      */
          PositionedDirectional(
              top: 24,
              start: 8,
              child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).colorScheme.background,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  })),
          PositionedDirectional(
            top: 100,
            start: 20,
            end: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, PageRoutes.selectLocation);
              },
              child: FadedScaleAnimation(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: theme.colorScheme.background,
                  ),
                  child: Row(
                    children: [
                      Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 6,
                            backgroundColor: lightGreenTextColor,
                          ),
                          RotatedBox(
                              quarterTurns: 1,
                              child: Text(' ---------- ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(height: 1.1))),
                          const CircleAvatar(
                            radius: 6,
                            backgroundColor: Colors.red,
                          ),
                        ],
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: CustomListTile(
                                      title: getTranslationOf(
                                          'trip_start_location'),
                                      subtitle:
                                          getTranslationOf('current_location')),
                                ),
                                Icon(
                                  Icons.my_location,
                                  color: theme.hintColor,
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                              ],
                            ),
                            Container(
                              height: 0.5,
                              color: theme.hintColor,
                              margin: const EdgeInsets.only(left: 16),
                            ),
                            CustomListTile(
                                title: getTranslationOf('trip_end_location'),
                                subtitle: getTranslationOf('tap_to_search')),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
