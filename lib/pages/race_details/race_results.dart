import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../models/quali_result.dart';
import '../../models/race_result.dart';
import '../../models/constructor_colors.dart';
import "dart:convert";

class RaceResults extends StatefulWidget {
  final String round;

  RaceResults({required this.round});

  @override
  _RaceResultsState createState() => _RaceResultsState();
}

class _RaceResultsState extends State<RaceResults> {
  late Future<List<RaceResult>> raceResults;

  Future<List<RaceResult>> getRaceResults() async {
    final res = await http.get(Uri.parse(
        'https://ergast.com/api/f1/current/' + widget.round + '/results.json'));

    if (res.statusCode == 200) {
      final raceResults = json.decode(res.body)["MRData"]["RaceTable"]["Races"]
          [0]["Results"] as List;

      return raceResults
          .map((raceRes) => RaceResult.fromJson(raceRes))
          .toList();
    }

    return <RaceResult>[];
  }

  @override
  void initState() {
    super.initState();
    raceResults = getRaceResults();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<RaceResult>>(
      future: raceResults,
      builder: (context, data) {
        if (data.hasData) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: DataTable(
                columnSpacing: 8.0,
                headingRowHeight: 32.0,
                columns: [
                  DataColumn(label: Text("Pos")),
                  DataColumn(label: Text("")),
                  DataColumn(label: Text("Driver")),
                  DataColumn(label: Text("Time")),
                  DataColumn(label: Text("Points"), numeric: true),
                ],
                rows: data.data!
                    .map((e) => DataRow(cells: [
                          DataCell(Text(
                            e.position,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                          DataCell(Container(
                              width: 5,
                              height: 25,
                              color: constructorColors[
                                  e.constructor.constructorId])),
                          DataCell(Text(
                            e.driver.code,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                          DataCell(Chip(
                            label: Text(e.time != null ? e.time! : e.status),
                            padding: EdgeInsets.all(0.0),
                          )),
                          DataCell(
                            Text(e.points.toString()),
                          ),
                        ]))
                    .toList()),
          );
        }
        if (data.hasError) {
          return Text(data.error.toString());
        }
        return Center(child: CircularProgressIndicator(color: Colors.teal));
      },
    );
  }
}
