import 'package:sedil/utilities/file_manager.dart';
import 'package:flutter/material.dart';

class FileController extends ChangeNotifier{
  String _text = "";
  String get text => _text;
  readText() async {
    _text = await FileManager().readTextFile();
    notifyListeners();
  }
  writeText() async {
    _text = await FileManager().writeTextFile();
    notifyListeners();
  }
}