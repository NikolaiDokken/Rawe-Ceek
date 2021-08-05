import 'package:flutter/material.dart';
import 'package:rawe_ceek/driver_constructor_provider.dart';
import 'package:rawe_ceek/models/driver_standing.dart';
import 'package:rawe_ceek/pages/standings/driver_standings_view.dart';
import 'package:provider/provider.dart';
import '../../models/race.dart';
import '../../components/race_list.dart';
import "dart:convert";
import 'package:http/http.dart' as http;

class Standings extends StatefulWidget {
  @override
  _StandingsState createState() => _StandingsState();
}

class _StandingsState extends State<Standings> {
  late Future<List<DriverStanding>> driverStandings;

  Future<List<DriverStanding>> getDriverStandings() async {
    final res = await http.get(
        Uri.parse('http://ergast.com/api/f1/current/driverStandings.json'));

    if (res.statusCode == 200) {
      final standings = json.decode(res.body)["MRData"]["StandingsTable"]
          ["StandingsLists"][0]["DriverStandings"] as List;

      final drivers = context.read<DriverConstructorProvider>().drivers;
      final constructors =
          context.read<DriverConstructorProvider>().constructors;

      return standings
          .map((standing) => DriverStanding.fromJson(
              json: standing,
              driver: drivers.firstWhere(
                  (e) => e.driverId == standing["Driver"]["driverId"]),
              constructor: constructors.firstWhere((e) =>
                  e.constructorId == standing["Constructors"][0]["constructorId"])))
          .toList();
    }

    return <DriverStanding>[];
  }

  @override
  void initState() {
    super.initState();
    driverStandings = getDriverStandings();
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
        body: FutureBuilder(
          future: Future.wait([driverStandings]),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.hasData) {
              return TabBarView(children: [
                DriverStandingsView(standings: snapshot.data?[0]),
                Text("Hello"),
              ]);
            }
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator(color: Colors.teal));
          },
        ),
      ),
    );
  }
}
