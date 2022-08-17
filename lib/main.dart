import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sedil/screens/main_screen.dart';
import 'package:sedil/utilities/controller/file_controller.dart';

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => FileController())],
      child: SedilApp()));
}

class SedilApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<FileController>().readLort();
    return MaterialApp(
      title: "Sedil",
      home: MainScreen(),
    );
  }
}