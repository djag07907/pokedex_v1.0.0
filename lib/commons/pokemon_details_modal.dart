import 'package:flutter/material.dart';
import 'package:pokedex_v1_0_0/commons/pokemon_sound_button.dart';
import 'package:pokedex_v1_0_0/models/pokemon_model.dart';
import 'package:pokedex_v1_0_0/resources/themes.dart';
import 'package:pokedex_v1_0_0/views/pokemon_details_view.dart';

class PokemonDetailsModal extends StatelessWidget {
  final Pokemon pokemon;
  String _capitalizeFirstLetter(String text) {
    return text.substring(0, 1).toUpperCase() + text.substring(1);
  }

  void playPokemonSound() {}

  const PokemonDetailsModal({super.key, required this.pokemon});

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
          PokemonDetailsView(pokemon: pokemon),
          // Text('Pokemon Types: ${pokemon.types.join(', ')}'),
          // Text('Types: ${pokemon.types.join(', ')}'),
          const Text(
            'Description: ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          // Text('Description: ${pokemon.description}'),
          // const Text("More information here."),
          const SizedBox(
            height: 25,
          ),
          PokemonSoundButton(pokemon: pokemon, onPressed: playPokemonSound)
        ],
      ),
    );
  }
}
