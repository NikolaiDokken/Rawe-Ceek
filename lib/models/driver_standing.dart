import 'package:rawe_ceek/models/car_constructor.dart';
import 'package:rawe_ceek/models/driver.dart';

class DriverStanding {
  String position;
  String wins;
  Driver driver;
  CarConstructor constructor;
  String points;

  DriverStanding({
    required this.position,
    required this.wins,
    required this.driver,
    required this.constructor,
    required this.points,
  });

  factory DriverStanding.fromJson(
      {required Map<String, dynamic> json,
      Driver? driver,
      CarConstructor? constructor}) {
    return DriverStanding(
        position: json["position"],
        wins: json["wins"],
        driver: driver != null ? driver : Driver.fromJson(json["Driver"]),
        constructor: constructor != null
            ? constructor
            : CarConstructor.fromJson(json["Constructor"]),
        points: json["points"]);
  }
}
