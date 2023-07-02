import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class PickLocation extends StatefulWidget {
  const PickLocation({super.key, required this.curLoc});

  final GeoPoint curLoc;

  @override
  State<PickLocation> createState() => _PickLocationState();
}

class _PickLocationState extends State<PickLocation> {
  GeoPoint point = GeoPoint(latitude: 0, longitude: 0);
  bool locationChanged = false;

  void _locationChanged(GeoPoint p) {
    setState(() {
      locationChanged = true;
      point = p;
    });
  }

  void _sendPickedLocationBack(GeoPoint p) {
    Navigator.pop(context, p);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick Location'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              var p = await showSimplePickerLocation(
                context: context,
                isDismissible: true,
                title: 'Vælg postens placering',
                textConfirmPicker: 'Vælg',
                minZoomLevel: 2,
                maxZoomLevel: 18,
                initZoom: 16,
                initCurrentUserPosition: false,
                initPosition: widget.curLoc,
              );
              _locationChanged(p!);
            },
            child: const Text('Vælg postens placering'),
          ),
          const SizedBox(height: 30),
          locationChanged
              ? ElevatedButton(
                  onPressed: () {
                    _sendPickedLocationBack(point);
                  },
                  child: const Text('Post lokation valgt!'),
                )
              : const SizedBox(height: 3),
        ],
      ),
    );
  }
}
