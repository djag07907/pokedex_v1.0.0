import 'package:flutter/material.dart';
import 'package:pokedex_v1_0_0/models/pokemon_model.dart';
import 'package:pokedex_v1_0_0/resources/constants.dart';
import 'package:pokedex_v1_0_0/resources/themes.dart';

class PokemonDetailsView extends StatefulWidget {
  final Pokemon pokemon;
  final String description;

  const PokemonDetailsView(
      {super.key, required this.pokemon, required this.description});

  @override
  State<PokemonDetailsView> createState() => _PokemonDetailsViewState();
}

String _capitalizeFirstLetter(String text) {
  return text.substring(0, 1).toUpperCase() + text.substring(1);
}

Color getColorForType(String type) {
  switch (type) {
    case 'grass':
      return grassBackground;
    case 'fire':
      return fireBackground;
    case 'water':
      return waterBackground;
    case 'electric':
      return electricBackground;
    case 'poison':
      return poisonBackground;
    case 'bug':
      return bugBackground;
    case 'normal':
      return normalBackground;
    case 'fighting':
      return fightingBackground;
    case 'ground':
      return groundBackground;
    case 'fairy':
      return fairyBackground;
    case 'psychic':
      return psychicBackground;
    case 'rock':
      return rockBackground;
    case 'ghost':
      return ghostBackground;
    case 'ice':
      return iceBackground;
    case 'dragon':
      return dragonBackground;
    case 'dark':
      return rockBackground;
    case 'steel':
      return steelBackground;
    case 'flying':
      return flyingBackground;
    default:
      return blackColor;
  }
}

class _PokemonDetailsViewState extends State<PokemonDetailsView> {
  late List<TextSpan> _descriptionTextSpans;

  @override
  void initState() {
    super.initState();
    _descriptionTextSpans = _getDescriptionTextSpans(widget.description);
  }

  List<TextSpan> _getDescriptionTextSpans(String description) {
    final lines = description.split('\n');
    final textSpans = <TextSpan>[];

    for (final line in lines) {
      textSpans.add(TextSpan(
        text: line,
        style: const TextStyle(
          color: blackColor,
          fontWeight: FontWeight.bold,
        ),
      ));
      textSpans.add(const TextSpan(text: ' '));
    }

    return textSpans;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: widget.pokemon.imageUrl.isNotEmpty
                    ? Image.network(
                        widget.pokemon.imageUrl,
                        width: 200,
                        height: 200,
                      )
                    : Image.asset(
                        missigno,
                        width: 200,
                        height: 200,
                      ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      pokemonTypesText,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ...widget.pokemon.types.map(
                      (type) => ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: getColorForType(type),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          _capitalizeFirstLetter(type),
                          style: const TextStyle(
                            color: whiteColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Height: ${(widget.pokemon.height / 10).toStringAsFixed(1)} m',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Weight: ${(widget.pokemon.weight / 10).toStringAsFixed(1)} kg',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text(
                descriptionText,
                style: TextStyle(
                  color: blackColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    children: _descriptionTextSpans,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
