import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:provider/provider.dart';
import 'package:sedil/widgets/lortappbar.dart';
import 'package:wakelock/wakelock.dart';
import '../utilities/controller/file_controller.dart';

class Reading extends StatefulWidget {
  @override
  _ReadingState createState() => _ReadingState();
}

class _ReadingState extends State<Reading> {
  String data = "";
  final sccontroller = ScrollController();
  bool isBot = true;

  fetchFileData() async {
    String responseText;
    responseText = await rootBundle.loadString("contents/dilProjesi.txt");

    setState(() {
      data = responseText;
    });
  }

  @override
  void initState() {
    fetchFileData();
    super.initState();
    sccontroller.addListener(listenScrolling);
  }

  void listenScrolling() {
    if (sccontroller.position.atEdge) {
      final isTop = sccontroller.position.pixels == 0;
      if (isTop) {
        isBot = false;
      } else {
        isBot = true;
      }
    }
  }

  void scrollUp() {
    final double start = 0.0;

    sccontroller.animateTo(start,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
    setState(() {
      isBot = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    int lTime = int.parse(
        context.select((FileController controller) => controller.lort.lTime));
    int rTime = int.parse(
        context.select((FileController controller) => controller.lort.rTime));
    int lrTime = int.parse(
        context.select((FileController controller) => controller.lort.lrTime));
    String lorType = "Dinlendi";

    if (lTime >= 300) {
      lorType = "Okundu";
      rTime++;
      lrTime = rTime;
    } else {
      lTime++;
      lrTime = lTime;
    }

    Wakelock.enable();
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Text("300 Kere Okuma", style: TextStyle(color: Colors.black)),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.grey,
            child: Icon(Icons.arrow_upward_rounded, color: Colors.white),
            onPressed: scrollUp),
        body: CustomScrollView(
          controller: sccontroller,
          slivers: <Widget>[
            LORTAppBar(),
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  margin: EdgeInsets.fromLTRB(5, 5, 5, 2.5),
                  child: Image(
                    image: AssetImage("images/300_kere_okuma_light.png"),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(15, 15, 15, 5),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          data,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                    margin: EdgeInsets.fromLTRB(15, 2.5, 15, 5),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    color: Colors.black,
                    child: TextButton(
                        style: TextButton.styleFrom(primary: Colors.white),
                        onPressed: isBot
                            ? () {
                                context
                                    .read<FileController>()
                                    .writeLort(lTime, rTime, lrTime, lorType);
                                setState(() {
                                  isBot = false;
                                });
                              }
                            : () {
                                scrollUp();
                              },
                        child: Text(isBot ? "Okumamı Kaydet" : "Tekrar Oku",
                            style: TextStyle(fontSize: 17.5)))),
              ]),
            ),
          ],
        ));
  }
}
