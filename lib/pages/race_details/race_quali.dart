import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../models/quali_result.dart';
import '../../models/constructor_colors.dart';
import "dart:convert";

class RaceQuali extends StatefulWidget {
  final String round;

  RaceQuali({required this.round});

  @override
  _RaceQualiState createState() => _RaceQualiState();
}

class _RaceQualiState extends State<RaceQuali> {
  late Future<List<QualiResult>> qualiResults;

  Future<List<QualiResult>> getQualiResults() async {
    final res = await http.get(Uri.parse('https://ergast.com/api/f1/current/' +
        widget.round +
        '/qualifying.json'));

    if (res.statusCode == 200) {
      final qualiResults = json.decode(res.body)["MRData"]["RaceTable"]["Races"]
          [0]["QualifyingResults"] as List;

      return qualiResults
          .map((qualiRes) => QualiResult.fromJson(qualiRes))
          .toList();
    }

    return <QualiResult>[];
  }

  @override
  void initState() {
    super.initState();
    qualiResults = getQualiResults();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<QualiResult>>(
      future: qualiResults,
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
                  DataColumn(label: Text("Q1")),
                  DataColumn(label: Text("Q2")),
                  DataColumn(label: Text("Q3")),
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
                          e.q1 != ""
                              ? DataCell(Chip(
                                  label: Text(e.q1),
                                  padding: EdgeInsets.all(0.0),
                                ))
                              : DataCell(Chip(
                                  label: Text(
                                    "DNF",
                                    style: TextStyle(color: Colors.black38),
                                  ),
                                  backgroundColor: Colors.transparent,
                                  shape: StadiumBorder(
                                      side: BorderSide(color: Colors.black12)),
                                )),
                          e.q2 != null
                              ? DataCell(Chip(
                                  label: Text(e.q2 ?? ""),
                                  padding: EdgeInsets.all(0.0),
                                ))
                              : DataCell(Text("")),
                          e.q3 != null
                              ? DataCell(Chip(
                                  label: Text(e.q3 ?? ""),
                                  padding: EdgeInsets.all(0.0),
                                ))
                              : DataCell(Text("")),
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
