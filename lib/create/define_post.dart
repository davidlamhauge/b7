import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class DefinePost extends StatefulWidget {
  const DefinePost({super.key, required this.num});

  final int num;

  @override
  State<DefinePost> createState() => _DefinePostState();
}

class _DefinePostState extends State<DefinePost> {
/*
  final MapController mapController = MapController(
    initMapWithUserPosition: false,
    initPosition: GeoPoint(latitude: 55.72548, longitude: 9.10433),
    areaLimit: const BoundingBox.world(),
  );
*/
  final MapController mapController = MapController(
    initMapWithUserPosition: true,
  );

  late final GeoPoint loc;

  void _getCurLocation() async {
    loc = mapController.currentLocation() as GeoPoint;
  }

  @override

  void initState() {
    // TODO: implement initState
    _getCurLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post # ${widget.num}'),
      ),
      body: Column(
        children: [
          const Text('Kom nu...'),
          OSMFlutter(
            controller: mapController,
            initZoom: 12,
            minZoomLevel: 8,
            maxZoomLevel: 14,
            stepZoom: 1.0,
            userLocationMarker: UserLocationMaker(
              personMarker: const MarkerIcon(
                icon: Icon(
                  Icons.location_history_rounded,
                  color: Colors.red,
                  size: 48,
                ),
              ),
              directionArrowMarker: const MarkerIcon(
                icon: Icon(
                  Icons.double_arrow,
                  size: 48,
                ),
              ),
            ),


            roadConfiguration: const RoadOption(
              roadColor: Colors.yellowAccent,
            ),
            markerOption: MarkerOption(
                defaultMarker: const MarkerIcon(
              icon: Icon(
                Icons.person_pin_circle,
                color: Colors.blue,
                size: 56,
              ),
            )),
          ),
        ],
      ),
    );
  }
}
