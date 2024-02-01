import 'package:skinxtest/constants/api.dart';
import 'package:skinxtest/service/intercepter.dart';
import 'package:skinxtest/models/pokemon.dart';
import 'package:skinxtest/models/pokemon_tag.dart';

class PokemonService {
  static PokemonService? _instance;

  factory PokemonService() => _instance ??= PokemonService._();

  PokemonService._();

  Future<List<PokemonTag>> getPokemons(int limit, int offset) async {
    var queryParam = {
      "limit": limit,
      "offset": offset,
    };
    var response = await Api().dio.get(
          ApiConstants.pokemonSearchEndpoint,
          queryParameters: queryParam,
        );
    var result = List<PokemonTag>.from(response.data["results"]
        .map((element) => PokemonTag.fromJson(element)));
    return result;
  }

  Future<Pokemon> getPokemon(String name) async {
    var response = await Api().dio.get(
          ApiConstants.pokemonSearchEndpoint + "/" + name,
        );
    var result = Pokemon.fromJson(response.data);
    return result;
  }
}
