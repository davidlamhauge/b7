import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';

class PostsDefined {
  int numberOfPosts = 0;
  GeoPoint lastLocation = GeoPoint(latitude: 9, longitude: 53);

  // to be called when new post is accepted
  _addPost() {
    numberOfPosts++;
  }

  // to be called when existing post is deleted
  subtractPost() {
    numberOfPosts--;
  }

  int getNumberOfPosts() {
    return numberOfPosts;
  }
}

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

  GeoPoint curPos = GeoPoint(latitude: 0, longitude: 0);

  void _updateCurLocation() async {
    curPos = await mapController.currentLocation() as GeoPoint;
  }

  GeoPoint _getCurPos() {
    _updateCurLocation();
    return curPos;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    mapController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    _updateCurLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Post nr ${widget.postNr}',
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 250,
            width: double.infinity,
            child: OSMFlutter(
              controller: mapController,
              trackMyPosition: true,
              isPicker: true,
              initZoom: 15,
              minZoomLevel: 8,
              maxZoomLevel: 18,
              stepZoom: 1.0,
              roadConfiguration: const RoadOption(
                roadColor: Colors.yellowAccent,
              ),
              markerOption: MarkerOption(
                defaultMarker: const MarkerIcon(
                  icon: Icon(
                    Icons.person_pin_circle_sharp,
                    color: Colors.blue,
                    size: 80,
                  ),
                ),
              ),
            ),
          ),
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const ListTile(
                  leading: Icon(
                      Icons.location_on,
                  size: 30,
                  ),
                  title: Text(
                    'Position:',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'Længdegrad: ${curPos.latitude} ',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                Text(
                  'Breddegrad: ${curPos.longitude} ',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(flex: 10),
        ],
      ),
    );
  }
}
