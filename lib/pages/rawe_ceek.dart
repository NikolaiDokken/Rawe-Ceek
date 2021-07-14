import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import "dart:convert";

class RaweCeek extends StatefulWidget {
  @override
  _RaweCeekState createState() => _RaweCeekState();
}

class _RaweCeekState extends State<RaweCeek> {
  late Future<bool> isRaweCeek;

  Future<bool> getIsRaweCeek() async {
    final res = await http
        .get(Uri.parse('https://ergast.com/api/f1/current/next.json'));

    if (res.statusCode == 200) {
      final raceDateJson =
          json.decode(res.body)["MRData"]["RaceTable"]["Races"][0]["date"];

      var raceDate = DateTime.parse(raceDateJson);
      DateTime now = DateTime.now();
      return raceDate.difference(DateTime(now.year, now.month, now.day)).inDays < 7;
    }

    return false;
  }

  @override
  void initState() {
    super.initState();
    isRaweCeek = getIsRaweCeek();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Is it rawe ceek yet?"),
        ),
        body: FutureBuilder(
          future: isRaweCeek,
          builder: (context, data) {
            if (data.hasData && data.data == true) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("it's RAWE CEEK", style: TextStyle(fontSize: 30.0)),
                  SizedBox(height: 130),
                  Image.asset("assets/rawe_ceek.png"),
                ],
              );
            }
            if (data.hasData && data.data == false) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("it's sad ceek...", style: TextStyle(fontSize: 30.0)),
                  SizedBox(height: 130),
                  Image.asset("assets/sad_ceek.jpg"),
                ],
              );
            }
            if (data.hasError) {
              return Text(data.error.toString());
            }
            return Center(child: CircularProgressIndicator(color: Colors.teal));
          },
        ));
  }
}
