import 'package:flutter/material.dart';
import 'package:skinxtest/constants/api.dart';
import 'package:skinxtest/models/pokemon_tag.dart';

// ignore: must_be_immutable
class PokemonIcon extends StatelessWidget {
  PokemonIcon({
    super.key,
    required this.pokemonTag,
  });
  PokemonTag pokemonTag;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(255, 143, 143, 143), spreadRadius: 1),
          ],
        ),
        width: 60,
        height: 60,
        child: Image.network(
          "${ApiConstants.imageUrl}${pokemonTag.id}.png",
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
