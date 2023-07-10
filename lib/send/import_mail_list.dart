import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:b7/helper_classes.dart';
import 'dart:io';


// importer og returnerer mail-liste fra filsystem som String

class ImportMailList extends StatefulWidget {
  const ImportMailList({super.key});

  @override
  State<ImportMailList> createState() => _ImportMailListState();
}

class _ImportMailListState extends State<ImportMailList> {
  String returnString = ''; // String to return

  void _setReturnString(String s) {
      returnString = s;
  }

  Future<File> _saveToAppDir(PlatformFile file) async {
    final appDir = await getApplicationDocumentsDirectory();
    final cacheFile = File('${appDir.path}/${file.name}');
    return File(file.path!).copy(cacheFile.path);
  }
  
  void getCsvContent() async {
    final pickedFile = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['csv'],
      initialDirectory: getApplicationDocumentsDirectory().toString(),
    );
    if (pickedFile != null) {
      final file = pickedFile.files.first;
      final newFile = await _saveToAppDir(file);
      print('newFile: ${newFile.path}');
      String txt = await newFile.readAsString();
      print('Mailliste før return: ${txt.toString()}');
      _setReturnString(txt);
      FilePickerStatus.done;
    } else {
      returnString = 'error';
      FilePickerStatus.done;
    }
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
        title: const Text('Importer mail-liste (*.csv)'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () =>
              Navigator.of(context).pop(returnString),
            child: const Text('Returner mail-liste'),
          ),
        ],
      ),
    );
  }
}
