import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'dart:async';
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

  final MapController mapController = MapController();

  GeoPoint curPos = GeoPoint(latitude: 0.0, longitude: 0.0);
  GeoPoint chosenPos = GeoPoint(latitude: 2.0, longitude: 2.0);

  void _updateCurLocation() async {
    curPos = await mapController.currentLocation() as GeoPoint;
  }

  void _setCurrentLocation(GeoPoint p) {
    setState(() {
      curPos = p;
      chosenPos = p;
    });
  }

  GeoPoint _getChosenPosition() {
    return chosenPos;
  }

  void _setChosenLocation(GeoPoint p) {
    setState(() {
      chosenPos = p;
    });
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
    _setCurrentLocation(curPos);
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
          ElevatedButton(
              onPressed: () async {
                var p = await showSimplePickerLocation(
                  context: context,
                  isDismissible: false,
                  title: 'Vælg postens placering',
                  textConfirmPicker: 'Vælg',
                  minZoomLevel: 12,
                  maxZoomLevel: 18,
                  initZoom: 16,
                  initPosition: chosenPos,
                  initCurrentUserPosition: false,
                );
                if (p != null) {
                  _setCurrentLocation(p);
                }
              },
              child: const Text('Show picker address'),
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
