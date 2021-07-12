import "./driver.dart";
import "./constructor.dart";

class QualiResult {
  String position;
  Driver driver;
  Constructor constructor;
  String q1;
  String? q2;
  String? q3;

  QualiResult({
      required this.position,
      required this.driver,
      required this.constructor,
      required this.q1,
      required this.q2,
      required this.q3
  });

  factory QualiResult.fromJson(Map<String, dynamic> json) {
    return QualiResult(
        position: json["position"],
        driver: Driver.fromJson(json["Driver"]),
        constructor: Constructor.fromJson(json["Constructor"]),
        q1: json["Q1"],
        q2: json["Q2"],
        q3: json["Q3"]);
  }
}