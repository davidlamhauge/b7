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
  const CreatePost({super.key, required this.id, required this.postNr});

  final String id;
  final int postNr;

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  int textLength = 0;
  final PostsDefined postsDefined = PostsDefined();
  final PostPosition postPosition = PostPosition();
  final TaskPath taskPath = TaskPath(); // for saving posts as they are defined

  final TextEditingController textEditingController = TextEditingController();

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
      return GeoPoint(
          latitude: double.parse(splitted[0]),
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

  void _updateTextLength() {
    setState(() {
      textLength = textEditingController.text.length;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    mapController.dispose();
    textEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initCurLocation();
    taskPath.createTaskFile(widget.id);
    textEditingController.addListener(_updateTextLength);
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
                ListTile(
                  leading: const Icon(
                    Icons.location_on,
                    size: 30,
                  ),
                  title: Text(
                    'Position for Post ${widget.postNr}:',
                    style: const TextStyle(
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
          const SizedBox(height: 50),
          const Text(
            'Opgavetekst:',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextField(
            controller: textEditingController,
            keyboardType: TextInputType.multiline,
            minLines: 1,
            maxLines: 6,
            maxLength: 250,
            decoration: const InputDecoration(
              helperText: 'Skriv opgaven her. Max 250 anslag.',
              fillColor: Color.fromARGB(40, 10, 30, 150),
              filled: true,
            ),
          ),
          const SizedBox(height: 30),
          textLength > 10
              ? ElevatedButton(
                  onPressed: () {},
                  child: const Text('Gem Post'),
                )
              : const SizedBox(height: 5),
        ],
      ),
    );
  }
}
