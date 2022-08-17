import 'package:flutter/material.dart';
import 'package:sedil/screens/dialogs/first_dialog.dart';
import 'package:sedil/screens/dialogs/second_dialog.dart';
import 'package:sedil/screens/dialogs/third_dialog.dart';
import 'package:sedil/screens/main_screen.dart';
import 'package:sedil/widgets/lortappbar.dart';

class Listening extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () async {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MainScreen()));
            },
            icon: Icon(Icons.arrow_back, color: Colors.black)),
        title: Text("300 Kere Dinleme", style: TextStyle(color: Colors.black)),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          LORTAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                margin: EdgeInsets.fromLTRB(5, 5, 5, 2.5),
                child: Image(
                  image: AssetImage("images/300_kere_dinleme_light.png"),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                color: Colors.white,
                child: ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => FirstDialog()));
                  },
                  title: Text(
                    "1.Diyalog",
                    style: TextStyle(fontSize: 25, color: Colors.black),
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                color: Colors.white,
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SecondDialog()));
                  },
                  title: Text(
                    "2.Diyalog",
                    style: TextStyle(fontSize: 25, color: Colors.black),
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                color: Colors.white,
                child: ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ThirdDialog()));
                  },
                  title: Text(
                    "3.Diyalog",
                    style: TextStyle(fontSize: 25, color: Colors.black),
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
