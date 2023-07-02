import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class SendTask extends StatefulWidget {
  const SendTask({super.key});

  @override
  State<SendTask> createState() => _SendTaskState();
}

class _SendTaskState extends State<SendTask> {
  String directory = '';
  List<String> strList = [];
  List<String> filNavne = [];

  void filNavneList() {
    String txt = '';
    for (int i = 0; i < strList.length; i++) {
      if (strList[i].endsWith('b7')) {
        List<String> filNavn = strList[i].split('/');
        filNavne.add(filNavn.last);
      }
    }
  }

  Future<void> getDir() async {
    final directory = await getApplicationDocumentsDirectory();
    await for (var entity
        in directory.list(recursive: true, followLinks: false)) {
      strList.add(entity.path);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDir();
    filNavneList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send opgave'),
      ),
      body: const Column(
        children: [],
      ),
    );
  }
}
