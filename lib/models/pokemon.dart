class Pokemon {
  Pokemon({
    required this.name,
    required this.weight,
    required this.height,
    required this.type,
    required this.order,
    required this.sprites,
  });

  String name;
  int weight;
  int height;
  String type;
  int order;
  List<String> sprites;

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    var sprites = [
      json["sprites"]["back_default"].toString(),
      json["sprites"]["back_shiny"].toString(),
      json["sprites"]["front_default"].toString(),
      json["sprites"]["front_shiny"].toString(),
    ];
    return Pokemon(
      name: json["name"],
      weight: json["weight"],
      height: json["height"],
      type: json["types"][0]["type"]["name"],
      order: json["order"],
      sprites: sprites,
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "weight": weight,
        "height": height,
        "type": type,
        "order": order,
      };
}
