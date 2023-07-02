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
  String alertText = '';

  // this works!
  void _createAlertText() {
    alertText = '';
    for (var txt in filNavne) {
      List<String> tmp = txt.split('/');
      alertText += '${tmp.last}\n';
    }
  }

  // this works!
  void filNavneList() {
    filNavne.clear();
    for (var txt in strList) {
      if (txt.endsWith('b7')) {
        filNavne.add('$txt\n');
      }
    }
//    print('Filnavne: $filNavne Antal: ${filNavne.length}');
  }

  // this works
  Future<void> getDir() async {
    strList.clear();
    final directory = await getApplicationDocumentsDirectory();
    await for (var entity
        in directory.list(recursive: true, followLinks: false)) {
      strList.add(entity.path);
    }
//    print('dir: $strList Antal: ${strList.length}');
  }

  void _lateInit() async {
    await getDir();
    filNavneList();
    _createAlertText();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _lateInit();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send opgave'),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context){
                      return AlertDialog(
                        content: Text(alertText),
                      );
                    });
              },
              child: const Text('Hent filliste'),
          )
        ],
      ),
    );
  }
}
