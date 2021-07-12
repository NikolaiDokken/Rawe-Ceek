import 'package:flutter/material.dart';
import '../../models/race.dart';
import './race_info.dart';
import './race_quali.dart';
import './race_results.dart';

class RaceDetails extends StatelessWidget {
  final Race race;

  RaceDetails({required this.race});

  @override
  Widget build(BuildContext context) {
    bool raceFinished = DateTime.now().isAfter(race.date);

    return DefaultTabController(
      length: raceFinished ? 3 : 1,
      child: Scaffold(
        appBar: AppBar(
          title: Text(race.raceName),
          bottom: TabBar(
            tabs: [
              Tab(text: "Info"),
              if (raceFinished) Tab(text: "Quali"),
              if (raceFinished) Tab(text: "Results"),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            RaceInfo(race: race),
            if (raceFinished) RaceQuali(round: race.round),
            if (raceFinished) RaceResults(round: race.round),
          ],
        ),
      ),
    );
  }
}
