import 'package:flutter/material.dart';
import 'package:skinxtest/constants/api.dart';
import 'package:skinxtest/models/pokemon_tag.dart';

// ignore: must_be_immutable
class PokemonImageCard extends StatelessWidget {
  PokemonImageCard({
    super.key,
    required this.pokemonTag,
  });
  PokemonTag pokemonTag;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: Card(
          child: Container(
            height: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                    "${ApiConstants.imageUrl}${pokemonTag.id}.png"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
