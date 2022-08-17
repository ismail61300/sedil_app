import 'package:flutter/material.dart';
import 'package:sedil/widgets/lortappbar.dart';

class Dictionary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text("Sözlük", style: TextStyle(color: Colors.black)),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          LORTAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              
            ]),
          ),
        ],
      ),
    );
  }
}
