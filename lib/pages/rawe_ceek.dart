import 'package:flutter/material.dart';

class RaweCeek extends StatefulWidget {
  @override
  _RaweCeekState createState() => _RaweCeekState();
}

class _RaweCeekState extends State<RaweCeek> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Is it rawe ceek yet?"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text("it's RAWE CEEK",
           style: TextStyle(fontSize: 30.0)
          ),
          SizedBox(height: 130),
          Image.asset("assets/rawe_ceek.png"),
        ],
      )
    );
  }
}