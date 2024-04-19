import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_v1_0_0/bloc/pokemon_event.dart';
import 'package:pokedex_v1_0_0/bloc/pokemon_state.dart';
import 'package:pokedex_v1_0_0/resources/constants.dart';
import 'package:pokedex_v1_0_0/services/pokemon_service.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final PokemonService _pokemonService;

  PokemonBloc(this._pokemonService) : super(PokemonInitial()) {
    on<FetchPokemons>((event, emit) async {
      emit(const PokemonLoading([]));
      try {
        final pokemons =
            await _pokemonService.fetchPokemons(offset: event.offset);
        emit(PokemonLoaded(pokemons, hasMore: pokemons.length > 10));
      } catch (e) {
        emit(const PokemonError(errorText));
      }
    });
  }
}
