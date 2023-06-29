import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:b7/helper_classes.dart';

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
  const CreatePost(
      {super.key, required this.id, required this.email, required this.postNr});

  final String email;
  final String id;
  final int postNr;

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  String finalText = '';
  String allSummedUp = '';

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

  void _updateFinalText(String txt) {
    finalText += txt;
  }

  String _getFinalText() {
    return finalText;
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
    taskPath.write('${widget.id}§${widget.email}\n');
    textEditingController.addListener(_updateTextLength);
    postsDefined._addPost();
  }

  @override
  Widget build(BuildContext context) {
    if (curLoc == GeoPoint(latitude: 55.7198, longitude: 8.6075)) {
      _initCurLocation();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Post nr ${postsDefined.numberOfPosts}',
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
                    'Position for Post ${postsDefined.numberOfPosts}:',
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
          const SizedBox(height: 30),
          Text(
            'Opgavetekst til Post ${postsDefined.numberOfPosts}:',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
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
          const SizedBox(height: 20),
          textLength > 10
              ? ElevatedButton(
                  onPressed: () {
                    String txt = textEditingController.text;
                    String task =
                        '${postsDefined.numberOfPosts}§${curLoc.latitude}§${curLoc.longitude}§$txt\n|';
                    _updateFinalText(task);
                    // write: Post number, latitude, longitude, task text
//                    taskPath.write('${postsDefined.numberOfPosts}§${curLoc.latitude}§${curLoc.longitude}§$txt\n');
                    taskPath.write(task);
                    textEditingController.clear();
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Post nr ${postsDefined.numberOfPosts - 1}:',
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.purple,
                                  ),
                                ),
                                Text(
                                    'Location: ${curLoc.latitude.toStringAsFixed(4)}, ${curLoc.longitude.toStringAsFixed(4)}'),
                                Text('Spørgsmål: $txt'),
                              ],
                            ),
                          );
                        });
                    postsDefined._addPost();
                  },
                  child: Text('Gem Post ${postsDefined.numberOfPosts}'),
                )
              : const SizedBox(height: 5),
          ElevatedButton(
            onPressed: () {
              allSummedUp = '';
              String s = _getFinalText();
              List<String> strList = s.split('|');
              List<String> details = strList[0].split('§');
/*              for (int i = 0; i < strList.length; i++) {
                List<String> details = strList[i].split('§');
                allSummedUp +=
                    'Post ${details[0]}\nLokation ${double.parse(details[1]).toStringAsFixed(3)},'
                    ' ${double.parse(details[2]).toStringAsFixed(3)}\nOpgave:\n${details[3]}';
              } */
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(details.length as String),
                    );
                  });
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            child: const Text('Ikke flere poster!'),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
