import 'package:flutter/material.dart';
import 'package:rawe_ceek/models/standing.dart';
import 'package:rawe_ceek/pages/standings/standings_list.dart';
import 'package:rawe_ceek/services/standings_service.dart';

class StandingsView extends StatefulWidget {
  @override
  _StandingsViewState createState() => _StandingsViewState();
}

class _StandingsViewState extends State<StandingsView> {
  late Future<List<Standing>> driverStandings;
  late Future<List<Standing>> constructorStandings;

  @override
  void initState() {
    super.initState();
    driverStandings = getDriverStandings(context);
    constructorStandings = getConstructorStandings(context);
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
          future: Future.wait([driverStandings, constructorStandings]),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.hasData) {
              return TabBarView(children: [
                StandingsList(standings: snapshot.data?[0]),
                StandingsList(standings: snapshot.data?[1], isConstructorStandings: true,),
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
