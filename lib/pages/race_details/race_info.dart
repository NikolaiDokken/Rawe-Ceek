import 'package:flutter/material.dart';
import "../../models/race.dart";
import 'package:intl/intl.dart';

class RaceInfo extends StatelessWidget {
  final Race race;

  RaceInfo({required this.race});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                DateFormat("dd MMM").format(race.date) +
                    " " +
                    DateFormat.Hm().format(race.dateTime.toLocal()),
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              )),
        ),
        Image.asset("assets/tracks/" + race.circuitId + ".png"),
        Text(
          race.circuitName,
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                  child: Text("Country",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ))),
              Expanded(child: Text(race.country))
            ],
          ),
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                  child: Text("Locality",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ))),
              Expanded(child: Text(race.locality))
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}
