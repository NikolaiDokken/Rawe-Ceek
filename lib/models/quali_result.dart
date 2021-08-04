import "./driver.dart";
import 'car_constructor.dart';

class QualiResult {
  String position;
  Driver driver;
  CarConstructor constructor;
  String q1;
  String? q2;
  String? q3;

  QualiResult(
      {required this.position,
      required this.driver,
      required this.constructor,
      required this.q1,
      required this.q2,
      required this.q3});

  factory QualiResult.fromJson(
      {required Map<String, dynamic> json,
      Driver? driver,
      CarConstructor? constructor}) {
    return QualiResult(
        position: json["position"],
        driver: driver != null ? driver : Driver.fromJson(json["Driver"]),
        constructor: constructor != null
            ? constructor
            : CarConstructor.fromJson(json["Constructor"]),
        q1: json["Q1"],
        q2: json["Q2"],
        q3: json["Q3"]);
  }
}
