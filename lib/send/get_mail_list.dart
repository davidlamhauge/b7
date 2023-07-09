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

  Future<Widget> _setChosen(int i) async {
    switch (i) {
      case 1: // importer mail-liste fra filsystem
      final mailListAsString = await Navigator.push(context, MaterialPageRoute(builder: (context) => const ImportMailList()));
      print('Mailliste: ${mailListAsString.toString()}');
      return mailListAsString;
      case 2: // hent tidligere oprettet csv-fil i Document-directory
        return const Column(
          children: [
            Text('Nr 2'),
          ],
        );
      case 3: // opret ny csv-fil der gemmes til Document-directory
        return const Column(
          children: [
            Text('Nr 3'),
          ],
        );
      case 4: // Skriv emailadresse, og send til en ad gangen
        return const Column(
          children: [
            Text('Nr 4'),
          ],
        );
      default:
        return const Text('Hmm. Noget gik galt!');

    }
  }

  void _setChosenNumber(int i) {
    chosen = i;
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
                        onPressed: () {
                          _setMailListChosen();
                          _setChosen(1);
                          const SingleChildScrollView(
                            child: Text('Importer'),
                          );
                        },
                        child: const Text('Importer mail-liste'),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          _setMailListChosen();
                          _setChosenNumber(2);
                        },
                        child: const Text('Hent tidligere oprettet mail-liste'),
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
