import "./driver.dart";
import "./constructor.dart";

class RaceResult {
  String position;
  Driver driver;
  Constructor constructor;
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

  factory RaceResult.fromJson(Map<String, dynamic> json) {
    return RaceResult(
        position: json["position"],
        driver: Driver.fromJson(json["Driver"]),
        constructor: Constructor.fromJson(json["Constructor"]),
        started: json["grid"],
        time: json["Time"]?["time"],
        status: json["status"],
        points: json["points"],
        );
  }
}
