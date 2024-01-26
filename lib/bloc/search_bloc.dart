import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skinxtest/bloc/search_event.dart';
import 'package:skinxtest/bloc/search_state.dart';
import 'package:skinxtest/models/pokemon_tag.dart';
import 'package:skinxtest/service/pokemon_service.dart';

class PaginationBloc extends Bloc<PaginationEvent, PaginationState> {
  int pageNumber = 0;
  final int pageSize = 1500;
  List<PokemonTag> pokemonTags = [];
  final int nextPageTrigger = 3;

  PaginationBloc() : super(PaginationInitialState()) {
    on<LoadPageEvent>((event, emit) async {
      emit(PaginationLoadingState());
      try {
        List<PokemonTag> result =
            await PokemonService().getPokemons(pageSize, pageNumber * pageSize);
        pokemonTags.addAll(result);
        pageNumber = pageNumber + 1;
        print(pokemonTags);
        emit(PaginationLoadedState());
      } catch (e) {
        emit(PaginationErrorState());
      }
    });

    on<CheckIfNeedMoreDataEvent>((event, emit) async {
      emit(PaginationLoadingState());
      if (pokemonTags.length >= pokemonTags.length - nextPageTrigger) {
        add(const LoadPageEvent());
      }
    });
  }
}
