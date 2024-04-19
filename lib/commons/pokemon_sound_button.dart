import 'package:flutter/material.dart';
import 'package:pokedex_v1_0_0/models/pokemon_model.dart';
import 'package:pokedex_v1_0_0/resources/constants.dart';
import 'package:pokedex_v1_0_0/resources/themes.dart';

class PokemonSoundButton extends StatelessWidget {
  const PokemonSoundButton(
      {super.key, required this.pokemon, required this.onPressed});

  final Pokemon pokemon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: mainBackground,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(
                Icons.volume_up,
                color: white,
              ),
              onPressed: onPressed,
              constraints: const BoxConstraints(minWidth: 40),
            ),
            const Text(
              playText,
              style: TextStyle(color: white, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
