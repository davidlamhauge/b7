import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key, required this.postNr});

  final int postNr;

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final MapController mapController = MapController(

    initMapWithUserPosition: false,
    initPosition: GeoPoint(latitude: 47.4358055, longitude: 8.4737324),
    areaLimit: BoundingBox(
      east: 10.4922941,
      north: 47.8084648,
      south: 45.817995,
      west: 5.9559113,
    ),
  );

  late final GeoPoint curPos;

  void _getCurLocation() async {
    curPos = await mapController.currentLocation() as GeoPoint;
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
        title: Text('Post # ${widget.postNr}'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 300,
            width: double.infinity,
            child: OSMFlutter(
              controller: mapController,
              trackMyPosition: true,
              initZoom: 15,
              minZoomLevel: 8,
              maxZoomLevel: 18,
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
                  Icons.person_pin_circle_sharp,
                  color: Colors.blue,
                  size: 56,
                ),
              )),
            ),
          ),
        ],
      ),
    );
  }

  launchUrl(Uri parse) {}
}
