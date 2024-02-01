import 'package:flutter/material.dart';
import 'package:skinxtest/models/pokemon_tag.dart';
import 'package:skinxtest/widgets/pokemon_icon.dart';

class TeamRow extends StatelessWidget {
  const TeamRow({
    super.key,
    required this.pokemonTeam,
    required this.onRemoveTeam,
  });

  final List<PokemonTag> pokemonTeam;
  final Function onRemoveTeam;

  @override
  Widget build(BuildContext context) {
    var widgets = pokemonTeam
        .map((pokemonTag) => PokemonIcon(
              pokemonTag: pokemonTag,
            ))
        .toList();

    var removeButton = TextButton(
      onPressed: () => onRemoveTeam(pokemonTeam),
      child: const Icon(
        Icons.remove,
        color: Colors.red,
        size: 30,
      ),
    );
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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: widgets,
                ),
                removeButton,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HistoryPage extends StatelessWidget {
  const HistoryPage({
    super.key,
    required this.pokemonTeams,
    required this.onRemoveTeam,
  });
  final List<List<PokemonTag>> pokemonTeams;
  final Function onRemoveTeam;
  @override
  Widget build(BuildContext context) {
    var resultWidget = pokemonTeams.isEmpty
        ? const Center(
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
                  .map((list) =>
                      TeamRow(pokemonTeam: list, onRemoveTeam: onRemoveTeam))
                  .toList(),
            ),
          );

    return Scaffold(
      backgroundColor: const Color(0xFFC4ECFA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: resultWidget,
        ),
      ),
    );
  }
}
