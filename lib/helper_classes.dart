import 'dart:io';
import 'package:path_provider/path_provider.dart';


/*
Location that picker starts at, when creating posts for the run
Is set on main screen
 */

class PostPosition {

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/startpos.txt');
  }

  write(String text) async {
    final File file = await _localFile;
    await file.writeAsString(text);
  }

  Future<String> read() async {
    try {
      final File file = await _localFile;
      final text = await file.readAsString();
      return text;
    } catch (e) {
      return 'error';
    }
  }

}

/*
PostStorage = for storing id, email and Posts in ApplicationDocumentsDirectory
File contains these lines:
[0] id, email
[1] Post descriptions for Post 1
[2] Post descriptions for Post 2
etc. to end of file...

NB! Can be used for many other text-file types!!!
 */

class PostStorage {
  String fileName = '';

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$fileName');
  }

  void createStorageFile(String name) async {
    fileName = name;
    final path = await _localPath;
    File('$path/$fileName').create();
  }

  void writeToStorageFile(String txt) async {
    final file = await _localFile;
    // Write txt to file
    file.writeAsString(txt);
  }

  Future<String> readFromStorageFile() async {
    try {
      final file = await _localFile;
      // Read the file
      final contents = await file.readAsString();
      return contents;
    } catch (e) {
      // If encountering an error, return 'error'
      return 'error';
    }
  }
}