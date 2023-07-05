import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:b7/helper_classes.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;

/*
      case 1: // importer mail-liste fra filsystem
      case 2: // hent tidligere oprettet csv-fil i Document-directory
      case 3: // opret ny csv-fil der gemmes til Document-directory
      case 4: // Skriv emailadresse, og send til en ad gangen
 */

class ImportMailList extends StatefulWidget {
  const ImportMailList({super.key});

  @override
  State<ImportMailList> createState() => _ImportMailListState();
}

class _ImportMailListState extends State<ImportMailList> {
  PostStorage postStorage = PostStorage();
  String directory = '';
  List fil = [];

  // Make New Function
  void _listofFiles() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    setState(() {
      fil = directory.listSync();
    });
  }

  Future<void> deleteFile(io.File file) async {
    try {
      if (await file.exists()) {
        await file.delete();
        print('file deleted!');
      }
    } catch (e) {
      print('ERROR deleting file');
    }
  }

  Future<io.File> saveFilePermanently(PlatformFile file) async {
    final appStorage = await getApplicationDocumentsDirectory();
    io.File newFile = io.File('${appStorage.path}/${file.name}');
    final saveFile = io.File(file.path!).copy(newFile.path);
    deleteFile(newFile);
    return saveFile;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listofFiles();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowedExtensions: ['csv'],
            );
            if (result != null) {
              final file = result.files.first;
              final newFile = await saveFilePermanently(file);
              for (var txt in fil) {
                print(txt);
              }
              print('Old File: ${file.path}');
              print('New File: ${newFile.path}');
            }
          },
          child: const Text('Vælg mail-liste af typen *.csv'),
        ),
      ],
    );
  }
}
