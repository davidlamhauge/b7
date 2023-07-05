import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:b7/create/create_task.dart';

class CreateTaskPrepare extends StatefulWidget {
  const CreateTaskPrepare({Key? key}) : super(key: key);

  @override
  State<CreateTaskPrepare> createState() => _CreateTaskPrepareState();
}

/*
final path = '/storage/emulated/0/Download';
final checkPathExistence = await Directory(path).exists();
*/
class _CreateTaskPrepareState extends State<CreateTaskPrepare> {
  String returnEmail = ''; // email to receive answers of task
  String taskId = ''; // unique id name of task from 1-20 chars
  bool valid = false;

  Future<Directory?>? _appDocDir;

  final idController = TextEditingController();
  final emailController = TextEditingController();

  void _requestAppDocDir() {
    setState(() async {
      _appDocDir = (await getApplicationDocumentsDirectory()) as Future<Directory?>?;
    });
  }

  void _showOkButton() {
    setState(() {
      valid = returnEmail.isNotEmpty && taskId.isNotEmpty;
    });
  }

  // check if unique id can be used as task AND directory name
  void _emailChanged() {
    setState(() {
      returnEmail = emailController.text;
    });
  }

  // check if unique id can be used as task AND directory name
  void _idChanged() {
    setState(() {
      taskId = idController.text;
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    idController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    idController.addListener(_idChanged);
    emailController.addListener(_emailChanged);
    _requestAppDocDir();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forbered opret opgave'),
      ),
      body: Column(
        children: [
          TextField(
            controller: emailController,
            style: const TextStyle(
              fontSize: 18,
            ),
            decoration: const InputDecoration(
              hintText: 'Din email til besvarelser',
              helperText: 'Den email besvarelserne skal sendes til.',
              contentPadding: EdgeInsets.fromLTRB(20, 5, 20, 5),
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: idController,
            maxLength: 20,
            style: const TextStyle(
              fontSize: 18,
            ),
            decoration: const InputDecoration(
              hintText: 'Unikt opgave-id',
              helperText: 'Opgavens unikke navn, (Ingen mellemrum eller \'#\')',
              contentPadding: EdgeInsets.fromLTRB(20, 5, 20, 5),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Fortryd...'),
              ),
              taskId.isNotEmpty
                  ? ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CreateTask(email: returnEmail, id: taskId)),
                        );
                      },
                      child: const Text('OK'),
                    )
                  : const SizedBox(width: 20),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
