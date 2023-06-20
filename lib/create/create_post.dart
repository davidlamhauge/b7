import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key, required this.postNr});

  final int postNr;

  @override
  State<CreatePost> createState() => _CreatePostState();
}


class _CreatePostState extends State<CreatePost> {

  final MapController mapController = MapController();
  late final LatLng curPos;

  @override
  Future<void> initState() async {
    // TODO: implement initState
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
            child:
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              center: LatLng(51.509364, -0.128928),
              zoom: 9.2,
            ),
            nonRotatedChildren: [
              RichAttributionWidget(
                attributions: [
                  TextSourceAttribution(
                    'OpenStreetMap contributors',
                    onTap: () => launchUrl(
                      Uri.parse('https://openstreetmap.org/copyright'),
                    ),
                  ),
                ],
              ),
            ],
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
            ],
          ),
          )
        ],
      ),
    );
  }

  launchUrl(Uri parse) {}
}
