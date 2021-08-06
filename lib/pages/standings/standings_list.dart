import 'package:flutter/material.dart';
import 'package:rawe_ceek/models/constructor_colors.dart';
import 'package:rawe_ceek/models/standing.dart';

class StandingsList extends StatelessWidget {
  final List<Standing> standings;
  final bool isConstructorStandings;

  StandingsList({
    required this.standings,
    this.isConstructorStandings = false
  });

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
                title: Text(isConstructorStandings?standings[index].constructor.name : standings[index].driver!.getFullName()),
                subtitle: Text(isConstructorStandings? standings[index].constructor.nationality : standings[index].constructor.name),
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
