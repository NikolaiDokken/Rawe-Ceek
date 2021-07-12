import 'package:flutter/material.dart';
import 'home.dart';

void main() => runApp(MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.teal[900],
        accentColor: Colors.teal,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Colors.teal,
        ),
      ),
      home: Home(),
    ));
