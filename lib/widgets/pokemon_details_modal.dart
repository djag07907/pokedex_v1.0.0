import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:pokedex_v1_0_0/commons/pikachu_loading.dart';
import 'package:pokedex_v1_0_0/widgets/pokemon_sound_button.dart';
import 'package:pokedex_v1_0_0/models/pokemon_model.dart';
import 'package:pokedex_v1_0_0/repositories/pokemon_repository.dart';
import 'package:pokedex_v1_0_0/resources/themes.dart';
import 'package:pokedex_v1_0_0/views/pokemon_details_view.dart';

class PokemonDetailsModal extends StatefulWidget {
  final Pokemon pokemon;
  final PokemonRepository pokemonRepository = PokemonRepository();

  PokemonDetailsModal(
      {super.key, required this.pokemon, required String description});

  @override
  _PokemonDetailsModalState createState() => _PokemonDetailsModalState();
}

class _PokemonDetailsModalState extends State<PokemonDetailsModal> {
  late AudioPlayer _audioPlayer;

  String _capitalizeFirstLetter(String text) {
    return text.substring(0, 1).toUpperCase() + text.substring(1);
  }

  void playPokemonSound() async {
    try {
      final cryUrl =
          await widget.pokemonRepository.fetchPokemonCryUrl(widget.pokemon.id);
      await _audioPlayer.setUrl(cryUrl);
      await _audioPlayer.play();
    } catch (e) {
      if (kDebugMode) {
        print('Error playing pokemon sound: $e');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBar(
              title: Text(
                _capitalizeFirstLetter(
                    '${widget.pokemon.name} #${widget.pokemon.id.toString().padLeft(3, '0')}'),
                style: const TextStyle(
                    color: whiteColor, fontWeight: FontWeight.bold),
              ),
              backgroundColor: mainBackground,
            ),
            FutureBuilder<String>(
              future: widget.pokemonRepository
                  .fetchPokemonDescription(widget.pokemon.id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return PokemonDetailsView(
                    pokemon: widget.pokemon,
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
            PokemonSoundButton(
                pokemon: widget.pokemon, onPressed: playPokemonSound)
          ],
        ),
      ),
    );
  }
}
