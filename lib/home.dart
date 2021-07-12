import 'package:flutter/material.dart';
import "pages/races.dart";
import "pages/rawe_ceek.dart";

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;

  final List<Widget> pages = <Widget>[
    Races(),
    RaweCeek(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages.elementAt(currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onItemTapped,
        items: [
          BottomNavigationBarItem(
            label: "Races",
            icon: Text("🏁", style: TextStyle(fontSize: 25),),
          ),
          BottomNavigationBarItem(
            label: "Rawe Ceek?",
            icon: Text("🏎", style: TextStyle(fontSize: 25),),
          ),
        ],
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}
