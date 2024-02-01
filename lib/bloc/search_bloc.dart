import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skinxtest/bloc/search_state.dart';
import 'package:skinxtest/bloc/search_event.dart';
import 'package:skinxtest/models/pokemon_tag.dart';
import 'package:skinxtest/service/pokemon_service.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  int pageNumber = 0;
  final int pageSize = 10;
  List<PokemonTag> pokemonTags = [];

  SearchBloc() : super(InitialState()) {
    on<LoadedPageEvent>((event, emit) async {
      emit(LoadingState());
      try {
        List<PokemonTag> result =
            await PokemonService().getPokemons(pageSize, pageNumber * pageSize);
        pokemonTags.addAll(result);
        pageNumber = pageNumber + 1;
        emit(LoadedState());
      } catch (e) {
        emit(ErrorState());
      }
    });

    on<CheckIfNeedMoreDataEvent>((event, emit) async {
      emit(LoadingState());
      if (pokemonTags.length >= pokemonTags.length - 1) {
        add(LoadedPageEvent());
      }
    });
  }
}
