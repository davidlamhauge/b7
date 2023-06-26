import 'package:b7/create/create_post.dart';
import 'package:flutter/material.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({Key? key, required this.email, required this.id})
      : super(key: key);

  final String email;
  final String id;

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Godkend email og id'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Center(
              child: Column(
                children: [
                  const Text(
                    'Email:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(widget.email),
                  const Text(
                    'Opgave id:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(widget.id),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Tilbage',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreatePost(id: widget.id, postNr: PostsDefined().getNumberOfPosts() + 1),
                      ),
                    );
                  },
                  child: const Text(
                    'Godkend',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
