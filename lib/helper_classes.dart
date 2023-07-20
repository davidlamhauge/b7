import 'dart:io';
import 'package:file_picker/file_picker.dart';
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

class FileHandler {
  String fileName = '';

  // constructor
  FileHandler(this.fileName) {
//    fileName = filNavn;
  print('Filename in FileHandler: $fileName');
  }

  // to remove cached files
  Future<void> _deleteCacheDir() async {
    final cacheDir = await getTemporaryDirectory();

    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
    }
  }

  // get applicationDocumentDirectory
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    print('LOCALPATH i FileHandler: ${directory.path}');
    return directory.path;
  }

  // get file you defined in _setFileName
  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$fileName');
  }

  Future<FilePickerResult?> importFile() async {
    FilePickerResult? resultFile = await FilePicker.platform.pickFiles(
        allowMultiple: false,
    allowedExtensions: ['csv']);
    if (resultFile != null) {
      return resultFile;
    }
    return null;
  }

  Future<FilePickerResult?> importCsvFile() async {
    FilePickerResult? resultFile = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['csv']);
    if (resultFile != null) {
      fileName = resultFile.names.first!;
      print('I importCsvFile: ${resultFile.paths.first}');
      return resultFile;
    }
    return null;
  }


  // save files from cloud etc.
  Future<File> saveImportedCsvFilePermanently() async {
    final importedFile = await importCsvFile();
    File newFile = File('$importedFile');
    final saveFile = File(importedFile!.paths.first!).copy(newFile.path);
    print('This is MAYBE deleted: ${newFile.path}');
    print('This is new file: $saveFile');
    _deleteCacheDir();
    return saveFile;
  }


  // save files from cloud etc.
  Future<File> saveImportedFilePermanently() async {
    final importedFile = await importFile();
    File newFile = File('$importedFile');
    final saveFile = File(importedFile!.paths.first!).copy(newFile.path);
    print('This is MAYBE deleted: ${newFile.path}');
    print('This is new file: $saveFile');
    _deleteCacheDir();
//    deleteFile(newFile);
    return saveFile;
  }

  // create new file
  void createFile(String name) async {
    fileName = name;
    final path = await _localPath;
    File('$path/$fileName').create();
  }

  // write to new file
  void writeToFile(String txt) async {
    final file = await _localFile;
    // Write txt to file
    file.writeAsString(txt);
  }

  // read from defined file
  Future<String> readFromFile() async {
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

  // delete file if not longer necessary
  void deleteFile(File file) async {
    if (file.existsSync()) {
      file.deleteSync();
    }
    if (file.existsSync()) {
      print('File NOT ${file.path} deleted!');
    } else {
      print('File ${file.path} deleted!');
    }
  }
}