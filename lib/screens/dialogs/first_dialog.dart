import 'package:flutter/material.dart';
import 'package:sedil/utilities/player.dart';
import 'second_dialog.dart';
import 'third_dialog.dart';

class FirstDialog extends StatefulWidget {
  @override
  _FirstDialogState createState() => _FirstDialogState();
}

class _FirstDialogState extends State<FirstDialog> {
  @override
  Widget build(BuildContext context) => Player(number: "1", music: "eylesa.mp3", back: ThirdDialog(), next: SecondDialog());
}

