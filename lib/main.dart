import 'package:flutter/material.dart';
import 'package:b7/create/create_task_prepare.dart';
import 'package:b7/send/send_task.dart';
import 'package:b7/perform/perform_task.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home: MyHome()
    );
  }
}

class MyHome extends StatelessWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('b7'),
          ),
          body: Center(
            child: Column(
              children: [
                const Spacer(),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      minimumSize: const Size(300, 32),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const CreateTaskPrepare()),
                      );
                    },
                    child: const Text(
                        'Opret opgave',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    )
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      minimumSize: const Size(300, 32),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Send opgave',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    )
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      minimumSize: const Size(300, 32),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Udfør opgave',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    )
                ),
                const Spacer(),
                const Image(
                  image: AssetImage(
                  'assets/b7bundlogo.png'),
                  fit: BoxFit.fitWidth,
                ),
              ],
            ),
          ),
        ),
    );
  }
}
