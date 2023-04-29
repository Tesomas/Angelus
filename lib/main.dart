import 'package:angelus/widgets/AutoCloseDrawer.dart';
import 'package:angelus/widgets/pages/angelus.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Angelus',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch(selectedIndex){
      case 0:
        page = PrayerPage();
        break;
      case 1:
       page = Placeholder();
        break;
      default:
        throw UnimplementedError("no widget for $selectedIndex");
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Angelus"),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          drawer: AutoCloseDrawer(width:100, onOptionTapped: onTapped,),
          body: Row(
            children: [
              Expanded(
                  child: Container(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    child: page,
                )
              ),
            ]
            ),
          );
      }
    );
  }
  void onTapped(int indexTapped){
    setState(() {
      selectedIndex = indexTapped;
  });}
}
