import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({Key? key}) : super(key: key);

  @override
  State<CreateTask> createState() => _CreateTaskState();
}
/*
final path = '/storage/emulated/0/Download';
final checkPathExistence = await Directory(path).exists();
*/
class _CreateTaskState extends State<CreateTask> {
  String returnEmail = ''; // email to receive answers of task
  String task = ''; // unique id name of task from 1-20 chars
  bool _idOk = true;

  Future<Directory?>? _appDocumentsDirectory;

  final myController = TextEditingController();

  // check if unique id can be used as task AND directory name
  void _taskChanged() {
    setState(() async {
      task = myController.text;
      final String path = _appDocumentsDirectory as String;
      _idOk = await Directory('$path/$task').exists();
    });
  }

  @override
  void initState() {
    super.initState();
    // Start listening to changes.
    myController.addListener(_taskChanged);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Opret opgave'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          const Text(
            'Indtast unikt opgave-id:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextField(
            controller: myController,
            maxLength: 20,
            style: const TextStyle(
              fontSize: 18,
            ),
            decoration: const InputDecoration(
              hintText: 'opgave-id',
              helperText: 'NB! Ingen mellemrum i opgave-id!',
              contentPadding: EdgeInsets.fromLTRB(20, 5, 20, 5),
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            'Indtast email til besvarelser:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const TextField(
            style: TextStyle(
              fontSize: 18,
            ),
            decoration: InputDecoration(
              hintText: 'Din email',
              helperText: 'Email besvarelserne skal sendes til',
              contentPadding: EdgeInsets.fromLTRB(20, 5, 20, 5),
            ),
          ),
          const SizedBox(height: 20),
          _idOk ?
          Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Fortryd',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ):
          Column(
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'Videre',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Fortryd',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
