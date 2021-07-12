class Driver {
  String driverId;
  String permanentNumber;
  String givenName;
  String familyName;
  String code;
  String nationality;

  Driver(
      {required this.driverId,
      required this.permanentNumber,
      required this.givenName,
      required this.familyName,
      required this.code,
      required this.nationality});

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
        driverId: json["driverId"],
        permanentNumber: json["permanentNumber"],
        givenName: json["givenName"],
        familyName: json["familyName"],
        code: json["code"],
        nationality: json["nationality"]);
    }
}
