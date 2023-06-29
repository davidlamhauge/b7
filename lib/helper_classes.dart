import 'dart:io';
import 'package:path_provider/path_provider.dart';

// position that picker starts, when creating posts for the run
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
TaskPath = path to task in ApplicationDocumentsDirectory
File contains these lines:
[0] id, email
[1] Post descriptions for Post 1
[2] Post descriptions for Post 2
etc. to end of file...
 */

class TaskPath {
  String fileName = '';

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  void createTaskFile(String id) async {
    final path = await _localPath;
    fileName = '$path/$id.b7';
    File(fileName).createSync(recursive: true);
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File(fileName);
  }

  write(String text) async {
    final File file = await _localFile;
    await file.writeAsString(text, mode: FileMode.append);
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


