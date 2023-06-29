import 'package:b7/create/create_post.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({Key? key, required this.email, required this.id})
      : super(key: key);

  final String email;
  final String id;

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {

  String sti = '';

  static Future<String> createFolderInAppDocDir(String folderName) async {

    //Get this App Document Directory
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    //App Document Directory + folder name
    final Directory appDocDirFolder =  Directory('${appDocDir.path}/$folderName/');

    if(await appDocDirFolder.exists()){ //if folder already exists return path
      return appDocDirFolder.path;
    }else{//if folder not exists create folder and then return its path
      final Directory appDocDirNewFolder=await appDocDirFolder.create(recursive: true);
      return appDocDirNewFolder.path;
    }
  }

  void _callFolderCreationMethod(String id) async {
    sti = await createFolderInAppDocDir(id);
  }

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
                  Text(sti),
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
                    _callFolderCreationMethod(widget.id);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreatePost(id: widget.id, email: widget.email, postNr: PostsDefined().getNumberOfPosts() + 1),
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
            const Spacer(),
            const Image(
              image: AssetImage('assets/b7bundlogo.png'),
              fit: BoxFit.fitWidth,
            ),
          ],
        ),
      ),
    );
  }
}
