import "./driver.dart";
import 'car_constructor.dart';

class RaceResult {
  String position;
  Driver driver;
  CarConstructor constructor;
  String started;
  String? time;
  String status;
  String points;

  RaceResult({
    required this.position,
    required this.driver,
    required this.constructor,
    required this.started,
    required this.time,
    required this.status,
    required this.points,
  });

  factory RaceResult.fromJson(
      {required Map<String, dynamic> json,
      Driver? driver,
      CarConstructor? constructor}) {
    return RaceResult(
      position: json["position"],
      driver: driver != null ? driver : Driver.fromJson(json["Driver"]),
      constructor: constructor != null
          ? constructor
          : CarConstructor.fromJson(json["Constructor"]),
      started: json["grid"],
      time: json["Time"]?["time"],
      status: json["status"],
      points: json["points"],
    );
  }
}
