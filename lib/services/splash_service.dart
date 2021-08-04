import 'package:rawe_ceek/models/car_constructor.dart';
import 'package:rawe_ceek/models/driver.dart';
import 'package:http/http.dart' as http;
import "dart:convert";

Future<List<Driver>> getDrivers() async {
  final res = await http.get(Uri.parse(
        'http://ergast.com/api/f1/current/drivers.json'));

    if (res.statusCode == 200) {
      final drivers = json.decode(res.body)["MRData"]["DriverTable"]["Drivers"] as List;

      return drivers
          .map((driver) => Driver.fromJson(driver))
          .toList();
    }

    return <Driver>[];
}

Future<List<CarConstructor>> getConstructors() async {
final res = await http.get(Uri.parse(
        'http://ergast.com/api/f1/current/constructors.json'));

    if (res.statusCode == 200) {
      final constructors = json.decode(res.body)["MRData"]["ConstructorTable"]["Constructors"] as List;

      return constructors
          .map((constructor) => CarConstructor.fromJson(constructor))
          .toList();
    }

    return <CarConstructor>[];
}