import 'package:flutter/material.dart';
import 'package:sedil/utilities/player.dart';
import 'first_dialog.dart';
import 'third_dialog.dart';

class SecondDialog extends StatefulWidget {
  @override
  _SecondDialogState createState() => _SecondDialogState();
}

class _SecondDialogState extends State<SecondDialog> {
  @override
  Widget build(BuildContext context) => Player(number: "2", music: "eylesa.mp3", back: FirstDialog(), next: ThirdDialog());
}

