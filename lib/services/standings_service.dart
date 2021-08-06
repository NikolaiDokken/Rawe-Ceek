import 'package:flutter/material.dart';
import 'package:rawe_ceek/driver_constructor_provider.dart';
import 'package:rawe_ceek/models/standing.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import "dart:convert";

Future<List<Standing>> getDriverStandings(BuildContext context) async {
    final res = await http.get(
        Uri.parse('http://ergast.com/api/f1/current/driverStandings.json'));

    if (res.statusCode == 200) {
      final standings = json.decode(res.body)["MRData"]["StandingsTable"]
          ["StandingsLists"][0]["DriverStandings"] as List;

      final drivers = context.read<DriverConstructorProvider>().drivers;
      final constructors =
          context.read<DriverConstructorProvider>().constructors;

      return standings
          .map((standing) => Standing.fromJson(
              json: standing,
              driver: drivers.firstWhere(
                  (e) => e.driverId == standing["Driver"]["driverId"]),
              constructor: constructors.firstWhere((e) =>
                  e.constructorId == standing["Constructors"][0]["constructorId"])))
          .toList();
    }

    return <Standing>[];
  }

Future<List<Standing>> getConstructorStandings(BuildContext context) async {
    final res = await http.get(
        Uri.parse('http://ergast.com/api/f1/current/constructorStandings.json'));

    if (res.statusCode == 200) {
      final standings = json.decode(res.body)["MRData"]["StandingsTable"]
          ["StandingsLists"][0]["ConstructorStandings"] as List;

      final constructors =
          context.read<DriverConstructorProvider>().constructors;

      return standings
          .map((standing) => Standing.fromJson(
              json: standing,
              driver: null,
              constructor: constructors.firstWhere((e) =>
                  e.constructorId == standing["Constructor"]["constructorId"]),
                  isConstructorStanding: true))
          .toList();
    }

    return <Standing>[];
  }