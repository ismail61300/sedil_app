import 'package:flutter/material.dart';
import 'package:sedil/utilities/player.dart';
import 'first_dialog.dart';
import 'second_dialog.dart';

class ThirdDialog extends StatefulWidget {
  @override
  _ThirdDialogState createState() => _ThirdDialogState();
}

class _ThirdDialogState extends State<ThirdDialog> {
  @override
  Widget build(BuildContext context) => Player(number:"3", music: "eylesa.mp3", back: SecondDialog(), next: FirstDialog());
}

