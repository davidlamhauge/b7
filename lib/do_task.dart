import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DoTask extends StatefulWidget {
  const DoTask({Key? key}) : super(key: key);

  @override
  State<DoTask> createState() => _DoTaskState();
}
/*
final path = '/storage/emulated/0/Download';
final checkPathExistence = await Directory(path).exists();
*/
class _DoTaskState extends State<DoTask> {
  String returnEmail = ''; // email to receive answers of task
  String task = ''; // name of task from 1-20 chars
  bool idOk = false;

  Future<Directory?>? _appDocumentsDirectory;

  final myController = TextEditingController();

  Future<bool> _dirOk(String txt) async {
    final String path = _appDocumentsDirectory as String;
    idOk = await Directory('$path/$txt').exists();
    return idOk;
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
            maxLength: 20,
            style: const TextStyle(
              fontSize: 18,
            ),
            decoration: const InputDecoration(
              hintText: 'opgave-id',
              helperText: 'NB! Ingen mellemrum i opgave-id!',
              contentPadding: EdgeInsets.fromLTRB(20, 5, 20, 5),
            ),
            onChanged: (value) => _dirOk(value),
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
        ],
      ),
    );
  }
}
