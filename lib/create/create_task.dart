import 'package:b7/create/define_post.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

/*
Here you create the posts that the participants are going to visit.
You can add as many as you want,
 */

class CreateTask extends StatefulWidget {
  const CreateTask({Key? key, required this.email, required this.id})
      : super(key: key);

  final String email;
  final String id;

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  int postNr = 0; // number of post being created

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
                  const SizedBox(height: 20),
                  Text(
                    'Poster oprettet: $postNr',
                    style: const TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DefinePost(
                                num: postNr + 1,
                              ),
                            ),
                          );
                        },
                        child: const Text('Tilføj post...'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Færdig...'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
