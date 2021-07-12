class Constructor {
  String constructorId;
  String name;
  String nationality;

  Constructor({
    required this.constructorId,
    required this.name, 
    required this.nationality});


    factory Constructor.fromJson(Map<String, dynamic> json) {
    return Constructor(
        constructorId: json["constructorId"],
        name: json["name"],
        nationality: json["nationality"]);
  }
}
