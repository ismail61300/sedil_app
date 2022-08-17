import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sedil/widgets/lortappbar.dart';

import '../utilities/controller/file_controller.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text("Profilim", style: TextStyle(color: Colors.black)),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          LORTAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              Card(
                  margin: EdgeInsets.fromLTRB(15, 2.5, 15, 5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  color: Colors.black,
                  child: TextButton(
                    style: TextButton.styleFrom(primary: Colors.white),
                    child: Text("İlerlememi Sıfırla",
                        style: TextStyle(fontSize: 17.5)),
                    onPressed: () {
                      context.read<FileController>().zeroLort();
                    },
                  )),
            ]),
          ),
        ],
      ),
    );
  }
}
