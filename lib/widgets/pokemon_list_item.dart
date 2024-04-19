import 'package:flutter/material.dart';
import 'package:pokedex_v1_0_0/models/pokemon_model.dart';
import 'package:pokedex_v1_0_0/resources/constants.dart';
import 'package:pokedex_v1_0_0/resources/themes.dart';

class PokemonListItem extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonListItem({super.key, required this.pokemon});

  String _capitalizeFirstLetter(String text) {
    return text.substring(0, 1).toUpperCase() + text.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: mainBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 80,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(pinkPokeball),
                  fit: BoxFit.cover,
                ),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 90,
                    height: 90,
                    child: pokemon.imageUrl.isNotEmpty
                        ? Image.network(
                            pokemon.imageUrl,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(missigno),
                  ),
                  Flexible(
                    child: Text(
                      _capitalizeFirstLetter(pokemon.name),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    top: 30,
                    right: 15,
                  ),
                  child: Text(
                    '#${pokemon.id.toString().padLeft(3, '0')}',
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                      color: accentBackground,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
