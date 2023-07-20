
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:b7/send/get_mail_list.dart';


class SendTask extends StatefulWidget {
  const SendTask({super.key});

  @override
  State<SendTask> createState() => _SendTaskState();
}

class _SendTaskState extends State<SendTask> {

  String directory = '';
  List<String> b7List = [];
  List<String> filNavne = [];
  String alertText = '';

  var buttons = <Widget>[];

  Widget _getWidget() {
    if (buttons.isNotEmpty) {
      return Column(
        children: [
          for (var btn in buttons)
            btn
        ],
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
    return Column(
      children: [
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
      ]
    );
  }

  Widget returnButton(String short, String long) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(
            builder: (context) =>
        GetMailList(kort: short, lang: long)));
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
    for (var txt in b7List) {
      if (txt.endsWith('b7')) {
        filNavne.add('$txt\n');
      }
    }
  }

  // this works
  Future<void> getDir() async {
    b7List.clear();
    final directory = await getApplicationDocumentsDirectory();
    await for (var entity
        in directory.list(recursive: false, followLinks: false)) {
      b7List.add(entity.path);
    }
  }

  void _lateInit() async {
    await getDir(); // gets files from appDocDir
    filNavneList(); // moves *.b7 files to strList
    _createAlertText(); // creates string with filenames of *.b7
    buttons.clear(); // clears buttons Widget-array
    for (int i = 0; i < filNavne.length; i++) {
      List<String> tmp = filNavne[i].split('/');
      setState(() {  // sets state with filename and absolute path
        buttons.add(returnButton(tmp.last, filNavne[i]));
      });
    }
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
      body: SingleChildScrollView(
          child: Center(
              child: getBody(),
          ),
      ),
    );
  }
}

