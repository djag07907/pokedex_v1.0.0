import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_v1_0_0/bloc/pokemon_bloc.dart';
import 'package:pokedex_v1_0_0/bloc/pokemon_event.dart';
import 'package:pokedex_v1_0_0/resources/constants.dart';
import 'package:pokedex_v1_0_0/resources/themes.dart';

class ErrorView extends StatelessWidget {
  final String errorMessage;

  const ErrorView({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: MediaQuery.of(context).size.height * 0.2,
          left: 20.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                errorMessage,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                tryAgainText,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: grey,
                ),
              ),
            ],
          ),
        ),
        Center(
          child: ElevatedButton(
            onPressed: () =>
                context.read<PokemonBloc>().add(const FetchPokemons()),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              backgroundColor: mainBackground,
              padding: const EdgeInsets.symmetric(horizontal: 80.0),
            ),
            child: const Text(
              tryNowText,
              style: TextStyle(color: white),
            ),
          ),
        ),
        Positioned(
          bottom: 0.0,
          left: 0.0,
          right: 0.0,
          child: Image.asset(
            sadPikachu,
            width: 250.0,
            height: 250.0,
          ),
        ),
      ],
    );
  }
}
