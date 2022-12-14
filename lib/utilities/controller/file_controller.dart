import 'package:sedil/models/lort.dart';
import 'package:sedil/utilities/file_manager.dart';
import 'package:flutter/material.dart';

class FileController extends ChangeNotifier {
  Lort _lort = Lort("0", "0", "0", "Dinlendi");

  Lort get lort => _lort;

  readLort() async {
    final result = await FileManager().readJsonFile();

    if (result != null) {
      _lort = Lort.fromJson(result);
    }

    notifyListeners();
  }

  writeLort(lTime, rTime, lrTime, lorType) async {
    _lort = await FileManager().writeJsonFile(lTime, rTime, lrTime, lorType);
    notifyListeners();
  }

  zeroLort() async {
    _lort = await FileManager().zeroJsonFile();
    notifyListeners();
  }
}
