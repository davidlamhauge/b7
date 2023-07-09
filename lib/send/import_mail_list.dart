import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:b7/helper_classes.dart';
import 'dart:io';

/*
      case 1: // importer og returnerer mail-liste fra filsystem som String
      case 2: // hent tidligere oprettet csv-fil i Document-directory
      case 3: // opret ny csv-fil der gemmes til Document-directory
      case 4: // Skriv emailadresse, og send til en ad gangen
 */
// case 1: importer og returnerer mail-liste fra filsystem som String

class ImportMailList extends StatefulWidget {
  const ImportMailList({super.key});

  @override
  State<ImportMailList> createState() => _ImportMailListState();
}

class _ImportMailListState extends State<ImportMailList> {
  String directory = '';
  String returnString = ''; // String to return
  List fil = [];

  // Make New Function
  void _listofFiles() async {
    Directory directory = await getApplicationDocumentsDirectory();
    setState(() {
      fil = directory.listSync();
    });
  }

  Future<String> returnCsvContent() async {
    final pickedFile = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );
    if (pickedFile != null) {
      print('Mailliste før return: ${pickedFile.names.first.toString()}');
      return pickedFile.names.first.toString();
    }
    return 'error';
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
          onPressed: ()  {
            returnCsvContent();
            Navigator.pop(context, returnString);
          },
          child: const Text('Vælg mail-liste af typen *.csv'),
        ),
      ],
    );
  }
}
