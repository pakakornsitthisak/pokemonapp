import 'package:flutter/material.dart';
import 'package:skinxtest/constants/api.dart';
import 'package:skinxtest/models/pokemon_tag.dart';
import 'package:skinxtest/pages/pokemon_detail_page.dart';

class PokemonImageCard extends StatelessWidget {
  PokemonImageCard({
    required this.pokemonTag,
  });
  PokemonTag pokemonTag;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: Card(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                    ApiConstants.imageUrl + pokemonTag.id.toString() + ".png"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
