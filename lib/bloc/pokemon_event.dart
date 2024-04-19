import 'package:equatable/equatable.dart';

abstract class PokemonEvent extends Equatable {
  const PokemonEvent();

  @override
  List<Object> get props => [];
}

class FetchPokemons extends PokemonEvent {
  final int offset;

  const FetchPokemons({this.offset = 0});

  @override
  List<Object> get props => [offset];
}
