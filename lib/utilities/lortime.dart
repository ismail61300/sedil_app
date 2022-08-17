import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sedil/utilities/controller/file_controller.dart';

class ListenOrReadTimeWidget extends StatefulWidget {
  @override
  State<ListenOrReadTimeWidget> createState() => _ListenOrReadTimeWidgetState();
}

class _ListenOrReadTimeWidgetState extends State<ListenOrReadTimeWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(
      context.select((FileController controller) => controller.lort.lrTime) +
          " Kere " +
          context
              .select((FileController controller) => controller.lort.lorType),
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }
}
