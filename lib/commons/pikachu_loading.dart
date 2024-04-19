import 'package:flutter/material.dart';
import 'package:pokedex_v1_0_0/resources/constants.dart';

class PikachuLoading extends StatelessWidget {
  const PikachuLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          pikachuRunning,
          width: 50,
          height: 50,
        ),
        const SizedBox(height: 10),
        const Text(loadingText),
      ],
    );
  }
}
