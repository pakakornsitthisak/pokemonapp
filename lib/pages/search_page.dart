import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:refresh_loadmore/refresh_loadmore.dart';
import 'package:skinxtest/bloc/search_bloc.dart';
import 'package:skinxtest/bloc/search_state.dart';
import 'package:skinxtest/bloc/search_event.dart';
import 'package:skinxtest/models/pokemon_tag.dart';
import 'package:skinxtest/widgets/pokemon_icon.dart';
import 'package:skinxtest/widgets/pokemon_card.dart';

// ignore: must_be_immutable
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

// ignore: must_be_immutable
class SearchResultText extends StatelessWidget {
  SearchResultText({
    super.key,
    required this.totalPokemonFound,
  });
  int totalPokemonFound;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Center(
            child: Text("Found $totalPokemonFound pokemons."),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class SearchResultList extends StatelessWidget {
  SearchResultList({
    super.key,
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
  Future<void> _onPullUp(SearchBloc bloc) async {
    bloc.add(CheckIfNeedMoreDataEvent(index: pageIndex + 1));
  }

  Future<void> _onPullDown(SearchBloc bloc) async {
    bloc.pageNumber = 0;
    bloc.pokemonTags = [];
    bloc.add(LoadedPageEvent());
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SearchBloc>(context);
    List<Widget> widgets = bloc.pokemonTags.map((pokemon) {
      return PokemonCard(
        pokemonTag: pokemon,
        onSelectPokemon: onSelectPokemon,
        isSelected: selectedPokemon.contains(pokemon),
      );
    }).toList();

    return Expanded(
      child: RefreshLoadmore(
        onRefresh: () => _onPullDown(bloc),
        onLoadmore: () => _onPullUp(bloc),
        isLastPage: false,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: AlignedGridView.count(
            shrinkWrap: true,
            itemCount: widgets.length,
            physics: const ScrollPhysics(),
            crossAxisCount: 2,
            itemBuilder: (context, index) {
              return widgets.isEmpty ? Container() : widgets[index];
            },
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class SelectedPolemonsBar extends StatelessWidget {
  SelectedPolemonsBar({
    super.key,
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
            padding: const EdgeInsets.symmetric(vertical: 10),
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
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
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

// ignore: must_be_immutable
class FormTeamButton extends StatelessWidget {
  FormTeamButton({
    super.key,
    required this.onAddTeam,
  });
  Function onAddTeam;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
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

  Widget _buildPokemonResult(SearchBloc bloc, bool isLoading) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          children: [
            SearchResultText(totalPokemonFound: bloc.pokemonTags.length),
            SearchResultList(
              pageSize: bloc.pageSize,
              pageIndex: bloc.pageNumber,
              pokemons: _pokemons,
              onSelectPokemon: _selectPokemon,
              selectedPokemon: _teamPokemons,
            ),
            isLoading
                ? const Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: const CircularProgressIndicator(),
                    ),
                  )
                : Container(),
            SelectedPolemonsBar(
              pokemons: _teamPokemons,
              onAddTeam: widget.onAddTeam,
            ),
          ],
        ),
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
      color: const Color(0xFFC4ECFA),
      child: BlocProvider(
        create: (context) => SearchBloc()..add(LoadedPageEvent()),
        child: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            var bloc = BlocProvider.of<SearchBloc>(context);

            if (state is LoadingState) {
              return _buildPokemonResult(bloc, true);
            } else if (state is LoadedState) {
              return _buildPokemonResult(bloc, false);
            } else if (state is ErrorState) {
              return errorDialog(
                size: 20,
                onPressed: () {
                  bloc
                    ..pageNumber = 0
                    ..add(LoadedPageEvent());
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
