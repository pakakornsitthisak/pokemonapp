import 'package:flutter/material.dart';
import 'package:skinxtest/models/pokemon_tag.dart';
import 'package:skinxtest/widgets/pokemon_icon.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({
    super.key,
    required this.pokemonTeams,
  });
  List<List<PokemonTag>> pokemonTeams;

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

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
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.grey, spreadRadius: 1),
            ],
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Row(
                children: widgets,
              ),
            ),
          )),
    );
  }
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    var resultWidget = widget.pokemonTeams.length == 0
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
              children: widget.pokemonTeams
                  .map((list) => TeamRow(pokemonTeam: list))
                  .toList(),
            ),
          );

    return SafeArea(
      child: Container(
        color: Color(0xFFC4ECFA),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: resultWidget,
        ),
      ),
    );
  }
}
