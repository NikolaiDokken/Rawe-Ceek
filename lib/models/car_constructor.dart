class CarConstructor {
  String constructorId;
  String name;
  String nationality;

  CarConstructor({
    required this.constructorId,
    required this.name, 
    required this.nationality});

    factory CarConstructor.fromJson(Map<String, dynamic> json) {
    return CarConstructor(
        constructorId: json["constructorId"],
        name: json["name"],
        nationality: json["nationality"]);
  }
}
