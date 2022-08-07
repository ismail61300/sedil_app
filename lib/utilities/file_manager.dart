import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sedil/models/lort.dart';
import 'controller/file_controller.dart';

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

  Future<File> get _jsonFile async {
    final path = await _directoryPath;
    return File("$path/lortime.json");
  }

  Future<Map<String, dynamic>?> readJsonFile() async {
    String fileContent = "";
    File file = await _jsonFile;
    if (await file.exists()) {
      try {
        fileContent = await file.readAsString();
        return json.decode(fileContent);
      } catch (e) {
        print(e);
      }
    }
    return null;
  }

  Future<Lort> writeJsonFile() async {
    final Lort lort = Lort("0", "0", "0", "Dinlendi");
    File file = await _jsonFile;
    await file.writeAsString(json.encode(lort));
    return lort;
  }
}
