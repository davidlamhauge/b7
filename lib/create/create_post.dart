import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:b7/post_position.dart';

class PostsDefined {
  int numberOfPosts = 0;

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

  final PostPosition postPosition = PostPosition();

  final MapController mapController = MapController(
    initMapWithUserPosition: false,
    initPosition: GeoPoint(latitude: 55.7198, longitude: 8.6075),
  );

  GeoPoint curLoc = GeoPoint(latitude: 55.7198, longitude: 8.6075);

  void _initCurLocation() async {
    curLoc = await _getSavedStartPos();
    _setCurrentLocation(curLoc);
  }

  Future<GeoPoint> _getSavedStartPos() async {
    String txt = await postPosition.read();
    if (!txt.contains('error')) {
      final splitted = txt.split('#');
      return GeoPoint(latitude: double.parse(splitted[0]),
          longitude: double.parse(splitted[1]));
    } else {
      return curLoc;
    }
  }

  void _setCurrentLocation(GeoPoint p) {
    setState(() {
      curLoc = p;
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
    _initCurLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (curLoc == GeoPoint(latitude: 55.7198, longitude: 8.6075)) {
      _initCurLocation();
    }
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
                minZoomLevel: 2,
                maxZoomLevel: 18,
                initZoom: 16,
                initCurrentUserPosition: false,
                initPosition: curLoc,
              );
              if (p != null) {
                _setCurrentLocation(p);
              }
            },
            child: const Text('Vælg postens placering'),
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
                    'Position for Post:',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'Længdegrad: ${curLoc.latitude} ',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                Text(
                  'Breddegrad: ${curLoc.longitude} ',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
