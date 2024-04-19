import 'package:equatable/equatable.dart';
import 'package:pokedex_v1_0_0/models/pokemon_model.dart';

abstract class PokemonState extends Equatable {
  const PokemonState();

  @override
  List<Object> get props => [];
}

class PokemonInitial extends PokemonState {}

class PokemonLoading extends PokemonState {
  final List<Pokemon> pokemons;
  const PokemonLoading(this.pokemons);

  @override
  List<Object> get props => [pokemons];
}

class PokemonLoaded extends PokemonState {
  final List<Pokemon> pokemons;
  final bool hasMore;

  const PokemonLoaded(this.pokemons, {required this.hasMore});

  @override
  List<Object> get props => [pokemons, hasMore];
}

class PokemonError extends PokemonState {
  final String message;

  const PokemonError(this.message);

  @override
  List<Object> get props => [message];
}
