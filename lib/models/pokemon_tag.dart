class PokemonTag {
  PokemonTag({
    required this.name,
    required this.url,
    required this.id,
  });

  String name;
  String url;
  int id;

  factory PokemonTag.fromJson(Map<String, dynamic> json) {
    String url = json["url"];
    var tokens = url.split('/');
    return PokemonTag(
      id: int.parse(tokens[tokens.length - 2]),
      name: json["name"],
      url: url,
    );
  }

  String getName() {
    return name[0].toUpperCase() + name.substring(1);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "url": url,
      };
}
