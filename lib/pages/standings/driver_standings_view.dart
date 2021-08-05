import 'package:flutter/material.dart';
import 'package:rawe_ceek/models/constructor_colors.dart';
import 'package:rawe_ceek/models/driver_standing.dart';

class DriverStandingsView extends StatelessWidget {
  final List<DriverStanding> standings;

  DriverStandingsView({required this.standings});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: standings.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
                leading: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      standings[index].position,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 16),
                        width: 5,
                        height: 40,
                        color: constructorColors[
                            standings[index].constructor.constructorId])
                  ],
                ),
                title: Text(standings[index].driver.getFullName()),
                subtitle: Text(standings[index].constructor.name),
                trailing: (Chip(
                    label: Row(mainAxisSize: MainAxisSize.min, children: [
                  Text(standings[index].wins,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                  Text(" W, "),
                  Text(standings[index].points,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                  Text(" PTS"),
                ])))),
          );
        });
  }
}
