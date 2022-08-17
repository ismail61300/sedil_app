import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sedil/utilities/lortime.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wakelock/wakelock.dart';
import '../screens/listening_screen.dart';
import '../utilities/controller/file_controller.dart';

class Player extends StatefulWidget {
  const Player(
      {Key? key,
      required this.number,
      required this.music,
      required this.back,
      required this.next})
      : super(key: key);
  final number;
  final music;
  final back;
  final next;

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  String formatTime(Duration duraiton) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final hours = twoDigits(duraiton.inHours);
    final minutes = twoDigits(duraiton.inMinutes.remainder(60));
    final seconds = twoDigits(duraiton.inSeconds.remainder(60));

    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(".");
  }

  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  ReleaseMode release = ReleaseMode.LOOP;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();

    setAudio();

    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.PLAYING;
      });
    });

    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    audioPlayer.onAudioPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });

    audioPlayer.onPlayerCompletion.listen((event) { //TODO: Halledilecek!
      int lTime = int.parse(
          context.select((FileController controller) => controller.lort.lTime));
      int rTime = int.parse(
          context.select((FileController controller) => controller.lort.rTime));
      int lrTime = int.parse(context
          .select((FileController controller) => controller.lort.lrTime));
      String lorType = "Dinlendi";

      if (lTime >= 300) {
        lorType = "Okundu";
        rTime++;
        lrTime = rTime;
      } else {
        lTime++;
        lrTime = lTime;
      }

      void onPlayerComplete() {
        context.read<FileController>().writeLort(lTime, rTime, lrTime, lorType);
      }

      print("Tamamdır!");

      onPlayerComplete();
      setState(() {
        position = duration;
      });
    });
  }

  Future setAudio() async {
    audioPlayer.setReleaseMode(release);

    final player = AudioCache(prefix: "contents/");
    final url = await player.load(widget.music);
    audioPlayer.setUrl(url.path, isLocal: true);
  }

  @override
  void dispose() {
    audioPlayer.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Wakelock.enable();
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () async {
                if (isPlaying) {
                  await audioPlayer.pause();
                }
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Listening()));
              },
              icon: Icon(Icons.arrow_back, color: Colors.black)),
          title: ListenOrReadTimeWidget(),
          backgroundColor: Colors.white,
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 35),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image(
                          image:
                              AssetImage("images/300_kere_dinleme_light.png"),
                          width: double.infinity,
                          height: 275,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.number + ".Diyalog",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            IconButton(
                              icon: Icon(Icons.share_rounded,
                                  color: Colors.black),
                              iconSize: 25,
                              onPressed: () async {
                                final urlPreview = "https://play.google.com/store/games?hl=tr&gl=TR";

                                await Share.share(
                                    "Sedil uygulaması ile dil öğrenmek çok güzel, sen de bir göz atmak istersen link aşağıda ↓\n\n$urlPreview");
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      SliderTheme(
                          data: SliderThemeData(
                              thumbShape:
                                  RoundSliderThumbShape(enabledThumbRadius: 8)),
                          child: Slider(
                            activeColor: Colors.black,
                            inactiveColor: Colors.black54,
                            min: 0,
                            max: duration.inSeconds.toDouble(),
                            value: position.inSeconds.toDouble(),
                            onChanged: (value) async {},
                          )),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(formatTime(position),
                                style: TextStyle(color: Colors.black)),
                            Text(formatTime(duration),
                                style: TextStyle(color: Colors.black)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(Icons.skip_previous_rounded,
                                color: Colors.black),
                            iconSize: 45,
                            onPressed: () async {
                              if (isPlaying) {
                                await audioPlayer.pause();
                              }
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => widget.back));
                            },
                          ),
                          Text("    "),
                          CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.black,
                            child: IconButton(
                              icon: Icon(
                                isPlaying
                                    ? Icons.pause_rounded
                                    : Icons.play_arrow_rounded,
                                color: Colors.white,
                              ),
                              iconSize: 50,
                              onPressed: () async {
                                if (isPlaying) {
                                  await audioPlayer.pause();
                                } else {
                                  await audioPlayer.resume();
                                }
                              },
                            ),
                          ),
                          Text("    "),
                          IconButton(
                            icon: Icon(Icons.skip_next_rounded,
                                color: Colors.black),
                            iconSize: 45,
                            onPressed: () async {
                              if (isPlaying) {
                                await audioPlayer.pause();
                              }
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => widget.next));
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ]),
            ),
          ],
        ));
  }
}