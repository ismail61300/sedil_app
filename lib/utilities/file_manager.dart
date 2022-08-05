import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileManager {
  static late FileManager instance;

  FileManager._internal() {
    instance = this;
  }

  factory FileManager() => instance = FileManager._internal();

  Future<String> get _directoryPath async {
    Directory directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _file async {
    final path = await _directoryPath;
    return File("$path/lortime.txt");
  }

  Future<String> readTextFile() async {
    String fileContent = "";
    File file = await _file;
    if (await file.exists()) {
      try {
        fileContent = await file.readAsString();
      } catch (e) {
        print(e);
      }
    }
    return fileContent;
  }

  writeTextFile() async {
    String fileContent = "";
    File file = await _file;
    if (await file.exists()) {
      try {
        fileContent = await file.readAsString();
      } catch (e) {
        print(e);
      }
    }
    String text = (int.parse(fileContent) + 1).toString();
    await file.writeAsString(text);
    return text;
  }
}
