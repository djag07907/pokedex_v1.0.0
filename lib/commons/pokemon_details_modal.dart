import 'package:flutter/material.dart';
import 'package:pokedex_v1_0_0/commons/pikachu_loading.dart';
import 'package:pokedex_v1_0_0/commons/pokemon_sound_button.dart';
import 'package:pokedex_v1_0_0/models/pokemon_model.dart';
import 'package:pokedex_v1_0_0/repositories/pokemon_repository.dart';
import 'package:pokedex_v1_0_0/resources/themes.dart';
import 'package:pokedex_v1_0_0/views/pokemon_details_view.dart';

class PokemonDetailsModal extends StatelessWidget {
  final Pokemon pokemon;
  final PokemonRepository pokemonRepository = PokemonRepository();

  String _capitalizeFirstLetter(String text) {
    return text.substring(0, 1).toUpperCase() + text.substring(1);
  }

  void playPokemonSound() {}

  PokemonDetailsModal({
    super.key,
    required this.pokemon,
    required String description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBar(
            title: Text(
              _capitalizeFirstLetter(
                  '${pokemon.name} #${pokemon.id.toString().padLeft(3, '0')}'),
              style: const TextStyle(color: white, fontWeight: FontWeight.bold),
            ),
            backgroundColor: mainBackground,
          ),
          FutureBuilder<String>(
            future: pokemonRepository.fetchPokemonDescription(pokemon.id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return PokemonDetailsView(
                  pokemon: pokemon,
                  description: snapshot.data!,
                );
              } else if (snapshot.hasError) {
                return Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                );
              }
              return const PikachuLoading();
            },
          ),
          const SizedBox(
            height: 25,
          ),
          PokemonSoundButton(pokemon: pokemon, onPressed: playPokemonSound)
        ],
      ),
    );
  }
}
