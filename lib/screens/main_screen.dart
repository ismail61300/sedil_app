import 'package:flutter/material.dart';
import 'package:sedil/screens/listening_screen.dart';
import 'package:sedil/screens/reading_screen.dart';
import 'package:sedil/screens/dictionary_screen.dart';
import 'package:sedil/utilities/lortime.dart';
import 'package:sedil/widgets/appbar.dart';
import 'package:sedil/widgets/drawer.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainScreenState();
  }
}

class MainScreenState extends State {
  String dinleme = "images/300_kere_dinleme_light.png";
  String okuma = "images/300_kere_okuma_light.png";
  String sozluk = "images/sözlük_light.png";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: SedilAppBar(),
        drawer: SedilDrawer(),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              pinned: true,
              expandedHeight: 200.0,
              flexibleSpace: FlexibleSpaceBar(
                title: ListenOrReadTimeWidget(),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                const Divider(
                  height: 10,
                  thickness: 1,
                  indent: 10,
                  endIndent: 10,
                  color: Color(0xff2f2f2f),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Row(children: [
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Listening()));
                      },
                      child: Container(
                        child: Image(
                          image: AssetImage(dinleme),
                        ),
                      ),
                    )),
                  ]),
                ),
                const Divider(
                  height: 10,
                  thickness: 1,
                  indent: 10,
                  endIndent: 10,
                  color: Color(0xff2f2f2f),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Row(children: [
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Reading()));
                      },
                      child: Container(
                        child: Image(
                          image: AssetImage(okuma),
                        ),
                      ),
                    )),
                  ]),
                ),
                const Divider(
                  height: 10,
                  thickness: 1,
                  indent: 10,
                  endIndent: 10,
                  color: Color(0xff2f2f2f),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Row(children: [
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Dictionary()));
                      },
                      child: Container(
                        child: Image(
                          image: AssetImage(sozluk),
                        ),
                      ),
                    )),
                  ]),
                )
              ]),
            ),
          ],
        ));
  }
}
