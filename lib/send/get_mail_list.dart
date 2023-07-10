import 'package:b7/send/get_saved_mail_list.dart';
import 'package:flutter/material.dart';
import 'package:b7/send/import_mail_list.dart';

class GetMailList extends StatefulWidget {
  const GetMailList({super.key, required this.kort, required this.lang});

  final String kort; // filnavnet alene
  final String lang; // filnavnet i absolut længde

  @override
  State<GetMailList> createState() => _GetMailListState();
}

class _GetMailListState extends State<GetMailList> {
  bool mailListChosen = false;
  int chosen = 0;
  String mailListe = '';

  Future<String> _setChosen(int i) async {
    switch (i) {
      case 1: // importer mail-liste fra filsystem
        final result = await Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ImportMailList()));
        mailListe = result.toString();
        print('Mailliste retur: ${result.toString()}');
        return result;
      case 2: // hent tidligere oprettet csv-fil i Document-directory
        return 'txt';
      case 3: // opret ny csv-fil der gemmes til Document-directory
        return 'txt';
      case 4: // Skriv emailadresse, og send til en ad gangen
        return 'txt';
      default:
        return 'ERROR';
    }
  }

  void _setChosenNumber(int i) {
    chosen = i;
  }

  void _updateMaillist(String txt) {
    setState(() {
      mailListe = txt;
    });
  }

  void _setMailListChosen() {
    setState(() {
      mailListChosen = true;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                          final result = await Navigator.push(context,
                              MaterialPageRoute(builder: (context) => const ImportMailList()));
                          _updateMaillist(result.toString());
                          print('Mailliste returneret: $mailListe');
                        },
                        child: const Text('Importer mail-liste'),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () async {
                          final result = await Navigator.push(context,
                              MaterialPageRoute(builder: (context) => const GetSavedMailList()));
                          _updateMaillist(result.toString());
                          print('Gemt Mailliste returneret: $mailListe');
                        },
                        child: const Text('Hent oprettet/importeret mail-liste'),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          _setMailListChosen();
                          _setChosenNumber(3);
                        },
                        child: const Text('Opret ny mail-liste'),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          _setMailListChosen();
                          _setChosenNumber(4);
                        },
                        child: const Text('Send til en person ad gangen'),
                      ),
                    ],
                  ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
