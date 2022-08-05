import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sedil/screens/main_screen.dart';
import 'package:sedil/utilities/controller/file_controller.dart';

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => FileController())],
      child: MyApp()));
}

class SedilApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<FileController>().readLort();
    return MaterialApp(
      title: "Sedil",
      home: MainScreen(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<FileController>().readLort();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(context.select(
                  (FileController controller) => controller.lort.lrTime) +
              " Kere " +
              context.select(
                  (FileController controller) => controller.lort.lorType))),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
                child: TextButton(
                    onPressed: () => context.read<FileController>().writeLort(),
                    child: Text("Save to .json"))),
          ],
        ),
      ),
    );
  }
}
