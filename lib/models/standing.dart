import 'package:rawe_ceek/models/car_constructor.dart';
import 'package:rawe_ceek/models/driver.dart';

class Standing {
  String position;
  String wins;
  Driver? driver;
  CarConstructor constructor;
  String points;

  Standing({
    required this.position,
    required this.wins,
    required this.driver,
    required this.constructor,
    required this.points,
  });

  factory Standing.fromJson(
      {required Map<String, dynamic> json,
      Driver? driver,
      CarConstructor? constructor, bool isConstructorStanding = false}) {
    return Standing(
        position: json["position"],
        wins: json["wins"],
        driver: driver != null || isConstructorStanding ? driver : Driver.fromJson(json["Driver"]),
        constructor: constructor != null
            ? constructor
            : CarConstructor.fromJson(json["Constructor"]),
        points: json["points"]);
  }
}
