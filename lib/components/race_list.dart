import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/race.dart';
import '../pages/race_details/race_details.dart';

class RaceList extends StatelessWidget {
  final List<Race> races;

  RaceList({required this.races});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: races.length,
        itemBuilder: (context, index) {
          return Card(
              child: ListTile(
                  leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          races[index].date.day.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          DateFormat('MMM').format(races[index].date),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]),
                  title: Text(races[index].raceName),
                  subtitle: Text(
                      races[index].country + " - " + races[index].circuitName),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RaceDetails(race: races[index]),
                        ));
                  }));
        });
  }
}
