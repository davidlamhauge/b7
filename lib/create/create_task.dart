import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:path_provider/path_provider.dart';

//import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({Key? key, required this.email, required this.id})
      : super(key: key);

  final String email;
  final String id;

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
//  final PopupController _popupController = PopupController();
  final MapController mapController = MapController(
    initMapWithUserPosition: false,
//    initMapWithUserPosition: true,
    initPosition: GeoPoint(latitude: 14.599512, longitude: 120.984222),
    areaLimit: const BoundingBox.world(),
  );
  final double _zoom = 7;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Opret opgave'),
        ),
        body: Center(
            child: Column(
          children: [
            const SizedBox(height: 10),
            Center(
              child: Column(
                children: [
                  const Text(
                    'Email:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(widget.email),
                  const Text(
                    'Opgave id:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(widget.id),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
                height: 300,
                width: double.infinity,
                child: OSMFlutter(
                  controller: mapController,
                  trackMyPosition: true,
                  initZoom: 15,
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
                ))
          ],
        )));
  }
}
