import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';


class CreateTask extends StatefulWidget {
  const CreateTask({Key? key, required this.email, required this.id}) : super(key: key);

  final String email;
  final String id;

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Opret opgave'),
      ),
    );
  }
}
