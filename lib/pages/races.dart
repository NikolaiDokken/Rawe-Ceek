import 'package:flutter/material.dart';
import '../models/race.dart';
import '../components/race_list.dart';
import "dart:convert";
import 'package:http/http.dart' as http;

class Races extends StatefulWidget {
  @override
  _RacesState createState() => _RacesState();
}

class _RacesState extends State<Races> {
  late Future<List<Race>> races;

  Future<List<Race>> getRaces() async {
    final res =
        await http.get(Uri.parse('https://ergast.com/api/f1/current.json'));

    if (res.statusCode == 200) {
      final races =
          json.decode(res.body)["MRData"]["RaceTable"]["Races"] as List;

      return races.map((race) => Race.fromJson(race)).toList();
    }

    return <Race>[];
  }

  @override
  void initState() {
    super.initState();
    races = getRaces();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Races"),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(text: "Upcoming"),
              Tab(text: "Finished"),
            ],
          ),
        ),
        body: FutureBuilder<List<Race>>(
          future: races,
          builder: (context, data) {
            if (data.hasData) {
              return TabBarView(children: [
                RaceList(races: (data.data as List<Race>).where((race) => DateTime.now().isBefore(race.date)).toList()),
                RaceList(races: (data.data as List<Race>).reversed.where((race) => race.date.isBefore(DateTime.now())).toList()),
              ]);
            }
            if (data.hasError) {
              return Text(data.error.toString());
            }
            return Center(child: CircularProgressIndicator(color: Colors.teal));
          },
        ),
      ),
    );
  }
}
