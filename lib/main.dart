import 'package:flutter/material.dart';
import 'package:b7/create/create_task_prepare.dart';
import 'package:flutter/services.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:b7/helper_classes.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:b7/send/send_task.dart';
import 'package:b7/perform/perform_task.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((fn) {
    runApp(const MaterialApp(
      home: MyApp(),
    ));
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MyHome());
  }
}

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final MapController mapController = MapController(
    initMapWithUserPosition: false,
    initPosition: GeoPoint(latitude: 55.7198, longitude: 8.6075),
  );

  GeoPoint curLoc = GeoPoint(latitude: 55.7198, longitude: 8.6075);
  PostPosition postPosition = PostPosition(); // init location for posts

  void _setCurrentLocation(GeoPoint p) {
    setState(() {
      curLoc = p;
    });
  }

  void _getStartPosition() async {
    String s1 = await postPosition.read();
    if (!s1.contains('error')) {
      List<String> s2 = s1.split('#');
      curLoc = GeoPoint(
          latitude: double.parse(s2[0]), longitude: double.parse(s2[1]));
    }
  }

  void _saveStartPosition() {
    postPosition.write('${curLoc.latitude}#${curLoc.longitude}');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getStartPosition();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('b7'),
        ),
        body: Center(
          child: Column(
            children: [
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  minimumSize: const Size(300, 32),
                ),
                onPressed: () async {
                  var p = await showSimplePickerLocation(
                    context: context,
                    isDismissible: false,
                    title: 'Generel start-lokation:',
                    titleStyle: const TextStyle(
                      fontSize: 22,
                      color: Colors.blue,
                    ),
                    textConfirmPicker: 'Vælg',
                    minZoomLevel: 2,
                    maxZoomLevel: 18,
                    initZoom: 16,
                    initCurrentUserPosition: false,
                    initPosition: GeoPoint(
                        latitude: curLoc.latitude, longitude: curLoc.longitude),
                  );
                  if (p != null) {
                    _setCurrentLocation(p);
                    _saveStartPosition();
                  }
                },
                child: const Text(
                  'Generel start-lokation',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 80),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    minimumSize: const Size(300, 32),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CreateTaskPrepare()),
                    );
                  },
                  child: const Text(
                    'Opret opgave/aktivitet',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  )),
              const SizedBox(height: 10),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    minimumSize: const Size(300, 32),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                        builder: (context) => const SendTask()),
                    );
                  },
                  child: const Text(
                    'Send opgave/aktivitet',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  )),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  minimumSize: const Size(300, 32),
                ),
                onPressed: () {},
                child: const Text(
                  'Udfør opgave/aktivitet',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
              const Spacer(),
              const Image(
                image: AssetImage('assets/b7bundlogo.png'),
                fit: BoxFit.fitWidth,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
