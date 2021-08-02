import 'package:flutter/material.dart';
import 'package:rawe_ceek/models/driver.dart';
import '../models/race.dart';
import '../components/race_list.dart';
import "dart:convert";
import 'package:http/http.dart' as http;

class Standings extends StatefulWidget {
  @override
  _StandingsState createState() => _StandingsState();
}

class _StandingsState extends State<Standings> {
  late Future<Map<String, List>> standings;

  Future<Map<String, List>> getStandings() async {
    /*
    final res =
        await http.get(Uri.parse('http://ergast.com/api/f1/current/driverStandings.json'));

    if (res.statusCode == 200) {
      final races =
          json.decode(res.body)["MRData"]["StandingsTable"]["StandingsTable"]["StandingsLists"]["DriverStandings"] as List;

      return races.map((race) => Race.fromJson(race)).toList();
    }

    return <Race>[];
  */
    return {"drivers": [], "constructors": []};
  }

  @override
  void initState() {
    super.initState();
    standings = getStandings();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Standings"),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(text: "Drivers"),
              Tab(text: "Constructors"),
            ],
          ),
        ),
        body: FutureBuilder<Map<String, List>>(
          future: standings,
          builder: (context, data) {
            if (data.hasData) {
              return TabBarView(children: [
                RaceList(
                    races: (data.data as List<Race>)
                        .where((race) => DateTime.now().isBefore(race.date))
                        .toList()),
                RaceList(
                    races: (data.data as List<Race>)
                        .reversed
                        .where((race) => race.date.isBefore(DateTime.now()))
                        .toList()),
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
