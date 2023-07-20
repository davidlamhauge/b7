import 'package:b7/send/get_saved_mail_list.dart';
import 'package:flutter/material.dart';
import 'package:b7/send/import_mail_list.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'dart:io';
import 'package:csv/csv.dart';

class GetMailList extends StatefulWidget {
  const GetMailList({super.key, required this.kort, required this.lang});

  final String kort; // filnavnet alene
  final String lang; // filnavnet i absolut længde

  @override
  State<GetMailList> createState() => _GetMailListState();
}

class _GetMailListState extends State<GetMailList> {
  bool mailListChosen = false;
  String mailListe = '';

// ***************************************************************************
  String directory = '';
  List<String> strList = [];
  List<String> filNavne = [];
  List<List<dynamic>> csvContent = [];
  String buttonText = '';
  String fileName = '';

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<String> readCsv() async {
    try {
      final file = _localFile;
      print('File toString: ${file.toString()}');

      // Read the file
      final contents = file.toString();

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return 'error';
    }
  }

  Future<File> _localFile() async {
    try {
//      final path = await _localPath;
      String newFile = fileName.replaceAll('csv', 'txt');
      print('Newfile: $newFile');
      final csvFile = File(newFile);
      return csvFile;
    } catch (e) {
      return File('');
    }
  }

  var buttons = <Widget>[];

  Widget _getWidget() {
    if (buttons.isNotEmpty) {
      return Column(
        children: [for (var btn in buttons) btn],
      );
    } else {
      return const Text(
        'Ingen *.b7 filer at vise',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.red,
        ),
      );
    }
  }

  Widget getBody() {
    return Column(children: [
      const SizedBox(height: 30),
      const Text(
        'Vælg opgave der skal sendes:',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.purple,
        ),
      ),
      const SizedBox(height: 20),
      _getWidget(),
    ]);
  }

  void getCsvFileContent(String path) async {
//    final csvFile = await rootBundle.loadString(path);
  fileName = path;
  String s = _localFile().toString();

//    csvContent = input.print('csvContent:  $csvContent');
//    csvContent = const CsvToListConverter().convert(csvFile);

//    csvContent = const CsvToListConverter().convert(csvFile);
    /*
    try {
      final file = File(path);
      return csvContent;

    } catch (e) {
      return csvContent;
    }
    */
  }

  Future<String> readCsvFile(String path) async {
    try {
      final file = File(path);

      // Read the file
      final contents = await file.readAsString();

      return path;
    } catch (e) {
      // If encountering an error, return '' (empty string)
      return 'error';
    }
  }

  Widget returnButton(String short, String long) {
    return ElevatedButton(
      onPressed: () async {
        Future<String> s = readCsv();
        print('String s: ${s.toString()}');
        /*
        String s = await _localFile();
        print('Filnavne til MAIL: $s');
        for (var mail in filNavne) {
          final Email email = Email(
            body: 'God fornøjelse!',
            subject: 'Opgave: ${widget.kort} vedhæftet',
            recipients: [mail],
            cc: ['cc@example.com'],
            bcc: ['bcc@example.com'],
            attachmentPaths: [(widget.lang)],
            isHTML: false,
          );

          await FlutterEmailSender.send(email);
        }
        */
      },
      child: Text(
        short,
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }

  // this works!
  void _createButtonText() {
    buttonText = '';
    for (var txt in filNavne) {
      List<String> tmp = txt.split('/');
      buttonText += '${tmp.last}\n';
    }
  }

  // this works!
  void filNavneList() {
    filNavne.clear();
    for (var txt in strList) {
      if (txt.endsWith('csv')) {
        filNavne.add('$txt\n');
      }
    }
  }

  // this works
  Future<void> getDir() async {
    strList.clear();
    final directory = await getApplicationDocumentsDirectory();
    await for (var entity
        in directory.list(recursive: false, followLinks: false)) {
      strList.add(entity.path);
    }
  }

  void _lateInit() async {
    await getDir();
    filNavneList();
    _createButtonText();
    buttons.clear();
    for (int i = 0; i < filNavne.length; i++) {
      List<String> tmp = filNavne[i].split('/');
//      print('BtnParam1: ${tmp.last} btnParam2: ${filNavne[i]}');
      fileName = tmp.last;
      setState(() {
        buttons.add(returnButton(tmp.last, filNavne[i]));
      });
    }
  }

  void _setMailListChosen() {
    setState(() {
      mailListChosen = true;
    });
  }

  void _updateMaillist(String txt) {
    setState(() {
      mailListe = txt;
    });
  }

// ***************************************************************************

  @override
  Widget build(BuildContext context) {
    _lateInit();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Hent/lav mail-liste'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(height: 30),
            Text(
              'Opgave: ${widget.kort}',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            mailListChosen
                ? const SizedBox(height: 10)
                : Column(
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ImportMailList()));
                          _updateMaillist(result.toString());
                          print('Mailliste returneret: $mailListe');
                        },
                        child: const Text('Importer mail-liste'),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () async {
                          final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const GetSavedMailList()));
                          _updateMaillist(result.toString());
                          _setMailListChosen();
                          print('Gemt Mailliste returneret: $mailListe');
                        },
                        child:
                            const Text('Hent oprettet/importeret mail-liste'),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          _setMailListChosen();
                        },
                        child: const Text('Opret ny mail-liste'),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          _setMailListChosen();
                        },
                        child: const Text('Send til en person ad gangen'),
                      ),
                    ],
                  ),
            mailListChosen
                ? Column(
                    children: [
                      _getWidget(),
                    ],
                  )
                : const SizedBox(height: 10),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
