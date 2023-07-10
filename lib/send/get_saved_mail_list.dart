import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class GetSavedMailList extends StatefulWidget {
  const GetSavedMailList({super.key});

  @override
  State<GetSavedMailList> createState() => _GetSavedMailListState();
}

class _GetSavedMailListState extends State<GetSavedMailList> {

  String returnString = '';
  String directory = '';
  List files = [];
  List<String> csvFiles = [];

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  void _listOfFiles() async {
    directory = await _localPath;
    files = Directory(directory).listSync();
  }

  void _setReturnString(List<String> s) {
    csvFiles = s;
  }

  void getCsvContent() async {
    final localPath = await _localPath;
    print('Localpath; $localPath');
    files = Directory(localPath).listSync();
    List<String> strList = files.toString().split(',');
    csvFiles.clear();
    for (int i = 0; i < strList.length; i++) {
      if (strList[i].contains('.csv')) {
        csvFiles.add(strList[i]);
      }
    }
    print('dir LocalPath: $files');
    print('dir csvFiles: $csvFiles');
    _setReturnString(csvFiles);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCsvContent();
  }


@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Hent mail-liste'),
    ),
    body: Column(
      children: [
        ElevatedButton(
          onPressed: () =>
              Navigator.of(context).pop(csvFiles),
          child: const Text('Hent mail-liste'),
        ),
      ],
    ),
  );
}}
