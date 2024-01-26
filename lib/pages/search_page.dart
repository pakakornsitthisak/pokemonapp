import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skinxtest/bloc/search_bloc.dart';
import 'package:skinxtest/bloc/search_event.dart';
import 'package:skinxtest/bloc/search_state.dart';
import 'package:skinxtest/models/pokemon_tag.dart';
import 'package:skinxtest/widgets/pokemon_icon.dart';
import 'package:skinxtest/widgets/pokemon_card.dart';

class SearchPage extends StatefulWidget {
  SearchPage({
    super.key,
    required this.onAddTeam,
    required this.onRemoveTeam,
  });
  Function onAddTeam;
  Function onRemoveTeam;
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class SearchResultText extends StatelessWidget {
  SearchResultText({
    required this.totalPokemonFound,
  });
  int totalPokemonFound;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Center(
            child: Text("Found " + totalPokemonFound.toString() + " pokemons."),
          ),
        ),
      ),
    );
  }
}

class SearchResultList extends StatelessWidget {
  SearchResultList({
    required this.pageSize,
    required this.pageIndex,
    required this.pokemons,
    required this.onSelectPokemon,
    required this.selectedPokemon,
  });
  List<PokemonTag> pokemons;
  List<PokemonTag> selectedPokemon;
  Function onSelectPokemon;
  int pageIndex;
  int pageSize;
  Future<void> onPullUp(BuildContext context) async {
    final bloc = BlocProvider.of<PaginationBloc>(context);
    bloc.add(CheckIfNeedMoreDataEvent(index: pageIndex + 1));
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<PaginationBloc>(context);
    List<Widget> widgets = bloc.pokemonTags.map((p) {
      return PokemonCard(
        pokemonTag: p,
        onSelectPokemon: onSelectPokemon,
        isSelected: selectedPokemon.contains(p),
      );
    }).toList();
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Container(
          child: GridView.count(
            crossAxisCount: 2,
            children: widgets,
          ),
        ),
      ),
    );
  }
}

class SelectedPolemonsBar extends StatelessWidget {
  SelectedPolemonsBar({
    required this.pokemons,
    required this.onAddTeam,
  });
  Function onAddTeam;
  List<PokemonTag> pokemons = [];
  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = pokemons
        .map((p) => PokemonIcon(
              pokemonTag: p,
            ))
        .toList();
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widgets,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: TextButton(
              child: const Text('Create Team'),
              onPressed: () => onAddTeam(pokemons),
            ),
          ),
        ),
      ],
    );
  }
}

class FormTeamButton extends StatelessWidget {
  FormTeamButton({
    required this.onAddTeam,
  });
  Function onAddTeam;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: TextButton(
          child: const Text('Create Team'),
          onPressed: () => onAddTeam(),
        ),
      ),
    );
  }
}

class _SearchPageState extends State<SearchPage> {
  List<PokemonTag> _teamPokemons = [];

  @override
  void initState() {
    super.initState();
  }

  List<PokemonTag> _pokemons = [];
  void _selectPokemon(PokemonTag pokemonTag) {
    setState(() {
      if (_teamPokemons.length >= 6) {
      } else if (_teamPokemons.contains(pokemonTag)) {
        _teamPokemons.remove(pokemonTag);
      } else {
        _teamPokemons.add(pokemonTag);
      }
    });
  }

  Widget _buildPokemonResult(BuildContext context) {
    final bloc = BlocProvider.of<PaginationBloc>(context);
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(children: [
          SearchResultText(totalPokemonFound: bloc.pokemonTags.length),
          SearchResultList(
            pageSize: bloc.pageSize,
            pageIndex: bloc.pageNumber,
            pokemons: _pokemons,
            onSelectPokemon: _selectPokemon,
            selectedPokemon: _teamPokemons,
          ),
          SelectedPolemonsBar(
            pokemons: _teamPokemons,
            onAddTeam: widget.onAddTeam,
          ),
        ]),
      ),
    );
  }

  Widget errorDialog({
    required double size,
    Function()? onPressed,
  }) {
    return SizedBox(
      height: 180,
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'An error occurred when fetching the posts.',
            style: TextStyle(
              fontSize: size,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: onPressed,
            child: const Text(
              "Retry",
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFC4ECFA),
      child: BlocProvider(
        create: (context) => PaginationBloc()..add(const LoadPageEvent()),
        child: BlocBuilder<PaginationBloc, PaginationState>(
          builder: (context, state) {
            if (state is PaginationLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PaginationLoadedState) {
              return _buildPokemonResult(context);
            } else if (state is PaginationErrorState) {
              return errorDialog(
                size: 20,
                onPressed: () {
                  BlocProvider.of<PaginationBloc>(context)
                    ..pageNumber = 0
                    ..add(const LoadPageEvent());
                },
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
