import 'dart:async';

import 'package:flutter/material.dart';
import 'package:skinxtest/models/pokemon.dart';

// ignore: must_be_immutable
class AnimatedPokemonImageCard extends StatefulWidget {
  AnimatedPokemonImageCard({
    super.key,
    required this.pokemon,
  });
  Pokemon pokemon;

  @override
  State<AnimatedPokemonImageCard> createState() =>
      _AnimatedPokemonImageCardState();
}

class _AnimatedPokemonImageCardState extends State<AnimatedPokemonImageCard> {
  late final Timer timer;
  int _index = 0;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(milliseconds: 200), (timer) {
      setState(() => _index++);
    });
  }

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
                  widget
                      .pokemon.sprites[_index % widget.pokemon.sprites.length],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
