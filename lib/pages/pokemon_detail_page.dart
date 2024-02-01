import 'package:flutter/material.dart';
import 'package:skinxtest/models/pokemon.dart';
import 'package:skinxtest/models/pokemon_tag.dart';
import 'package:skinxtest/service/pokemon_service.dart';
import 'package:skinxtest/widgets/animated_pokemon_image_card.dart';

// ignore: must_be_immutable
class PokemonName extends StatelessWidget {
  PokemonName({
    super.key,
    required this.name,
  });
  String name;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              name,
              style: const TextStyle(fontSize: 40),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class PokemonDetail extends StatelessWidget {
  PokemonDetail({
    super.key,
    required this.pokemon,
  });
  Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    var mapString = {
      "height": pokemon.height,
      "weight": pokemon.weight,
      "order": pokemon.order,
      "type": pokemon.type,
    };
    var widgets = mapString.entries
        .map(
          (e) => Row(
            children: [
              Text(
                e.key,
                style: TextStyle(fontSize: 25),
              ),
              Spacer(),
              Text(
                e.value.toString(),
                style: TextStyle(fontSize: 25),
              )
            ],
          ),
        )
        .toList();

    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        child: Column(
          children: widgets,
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class PokemonDetailPage extends StatefulWidget {
  PokemonDetailPage({
    super.key,
    required this.pokemon,
  });
  PokemonTag pokemon;

  @override
  State<PokemonDetailPage> createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends State<PokemonDetailPage> {
  @override
  void initState() {
    super.initState();
  }

  _getData() async {
    return (await PokemonService().getPokemon(widget.pokemon.name))!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail page'),
      ),
      body: Center(
        child: SafeArea(
          child: FutureBuilder(
            future: _getData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Container(
                  width: double.infinity,
                  color: Color(0xFFC4ECFA),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Column(
                      children: [
                        AnimatedPokemonImageCard(pokemon: snapshot.data),
                        PokemonName(name: widget.pokemon.getName()),
                        PokemonDetail(
                          pokemon: snapshot.data,
                        )
                      ],
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
