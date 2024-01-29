import 'package:flutter/material.dart';
import 'package:skinxtest/constants/api.dart';
import 'package:skinxtest/models/pokemon_tag.dart';
import 'package:skinxtest/pages/pokemon_detail_page.dart';

class PokemonCard extends StatelessWidget {
  PokemonCard({
    super.key,
    required this.pokemonTag,
    required this.onSelectPokemon,
    required this.isSelected,
  });
  PokemonTag pokemonTag;
  Function onSelectPokemon;
  bool isSelected;
  @override
  Widget build(BuildContext context) {
    String name = pokemonTag.getName();
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text(name),
            ),
            Expanded(
              child: InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PokemonDetailPage(
                      pokemon: pokemonTag,
                    ),
                  ),
                ),
                child: Container(
                  child: Image.network(
                    ApiConstants.imageUrl + pokemonTag.id.toString() + ".png",
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  child: TextButton(
                    child: isSelected
                        ? const Text('Remove')
                        : const Text('Select'),
                    onPressed: () => onSelectPokemon(pokemonTag),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
