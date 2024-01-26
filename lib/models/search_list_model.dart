import 'package:skinxtest/models/pokemon_tag.dart';

class PokemonTagListModel {
  PokemonTagListModel({
    required this.pokemonTags,
    required this.reachMax,
    required this.currentPage,
  });
  List<PokemonTag> pokemonTags;
  bool reachMax;
  int currentPage;
}
