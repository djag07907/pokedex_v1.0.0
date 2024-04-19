import 'package:pokedex_v1_0_0/models/pokemon_model.dart';
import 'package:pokedex_v1_0_0/repositories/pokemon_repository.dart';

class PokemonService {
  Future<List<Pokemon>> fetchPokemons({int offset = 0}) async {
    final repository = PokemonRepository();
    return repository.fetchPokemons(offset: offset);
  }
}
