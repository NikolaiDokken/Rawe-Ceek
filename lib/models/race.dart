class Race {
  String round;
  String raceName;
  String circuitName;
  String circuitId;
  String country;
  String locality;
  String? wiki;
  DateTime date;

  Race(
      {required this.round,
      required this.raceName,
      required this.country,
      required this.locality,
      required this.circuitName,
      required this.circuitId,
      required this.date});

  factory Race.fromJson(Map<String, dynamic> json) {
    return Race(
        round: json["round"],
        raceName: json["raceName"],
        circuitName: json["Circuit"]["circuitName"],
        circuitId: json["Circuit"]["circuitId"],
        country: json["Circuit"]["Location"]["country"],
        locality: json["Circuit"]["Location"]["locality"],
        date: DateTime.parse(json["date"] + " " + json["time"]));
  }
}
