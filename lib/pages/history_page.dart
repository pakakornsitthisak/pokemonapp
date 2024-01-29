import 'package:flutter/material.dart';
import 'package:skinxtest/models/pokemon_tag.dart';
import 'package:skinxtest/widgets/pokemon_icon.dart';

class TeamRow extends StatelessWidget {
  TeamRow({
    required this.pokemonTeam,
  });
  List<PokemonTag> pokemonTeam;
  @override
  Widget build(BuildContext context) {
    var widgets = pokemonTeam
        .map((p) => PokemonIcon(
              pokemonTag: p,
            ))
        .toList();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(color: Colors.grey, spreadRadius: 1),
            ],
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Row(
                children: widgets,
              ),
            ),
          )),
    );
  }
}

class HistoryPage extends StatelessWidget {
  const HistoryPage({
    super.key,
    required this.pokemonTeams,
  });
  final List<List<PokemonTag>> pokemonTeams;

  @override
  Widget build(BuildContext context) {
    var resultWidget = pokemonTeams.length == 0
        ? Center(
            child: Text(
              "No team found.",
              style: TextStyle(fontSize: 30),
            ),
          )
        : SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: pokemonTeams
                  .map((list) => TeamRow(pokemonTeam: list))
                  .toList(),
            ),
          );

    return SafeArea(
      child: Container(
        color: const Color(0xFFC4ECFA),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: resultWidget,
        ),
      ),
    );
  }
}
