import 'package:flutter/material.dart';
import 'package:b7/create/create_task_prepare.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:b7/post_position.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:b7/send/send_task.dart';
import 'package:b7/perform/perform_task.dart';

void main() => runApp(const MyApp());

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
  PostPosition postPosition = PostPosition();

  void _initCurLocation() async {
    curLoc = await mapController.currentLocation() as GeoPoint;
  }

  void _setCurrentLocation(GeoPoint p) {
    setState(() {
      curLoc = p;
    });
  }

  void _saveStartPosition() {
    postPosition.write('${curLoc.latitude}#${curLoc.longitude}');
  }
  
  @override
  Widget build(BuildContext context) {
    _initCurLocation();
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
                    title: 'Vælg generel placering',
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
                  'Posternes startposition',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 50),
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
                    'Opret opgave',
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
                    'Send opgave',
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
                    'Udfør opgave',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  )),
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
