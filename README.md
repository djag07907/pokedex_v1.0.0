# Pokedex App v2

## Overview

This Flutter app allows users to browse a list of Pokemon fetched from the PokeAPI. The app implements Bloc state management, modularization, and MVVM design to handle data and UI interactions efficiently.

## Getting Started

Instructions to run:

1. This project uses flutter version 3.24.4 stable version, Make sure you have that version installed or do `flutter upgrade`
2. First do `flutter pub get` and then `flutter run`

Project Highlights:

1. The project is structured using clean architecture
2. BLOC is used as state management
3. The project is based on MVVM design pattern.
4. Features are handled in modular programming in order to manage code complexity efficiently.
5. Infinite scroll pagination is handled

Packages used:

- http:^1.2.1
- flutter_bloc: ^9.1.0
- equatable: ^2.0.5
- cupertino_icons: ^0.9.40

Project/ Screen flow:

1. All Pokemons Screen

- All pokemons fetched from this API: <https://pokeapi.co>.
  Pagination is used since there are lots of Pokemons to be listed coming from API. (aprox 1302+)
- For Pokemon
  #001 -> id
  Bulbasaur -> name
- For the image of a Pokemon this is used, sprites > other > official-artwork > front_default.
- All Pokemons will be listed on this in a list view.
- There is also a progress indicator while Pokemons are being fetched. (10 per view)

## Project Details

- **Flutter Version**: 3.24.4
- **Dart Version**: 3.5.5 (stable)
- **Dependencies**:
  - http:^1.2.1
  - flutter_bloc: ^9.1.0
  - equatable: ^2.0.5
  - cupertino_icons: ^1.0.6
  - just_audio: ^0.9.40

## Code Structure

### main.dart

- Initializes the app and sets up the Bloc provider for managing Pokemon data.

### pokemon_bloc.dart

- Manages the state of Pokemon data using Bloc pattern.
- Implements events like FetchPokemons and states like PokemonLoading , PokemonLoaded , and PokemonError .

### pokemon_event.dart

- Defines the Pokemon events used in the Bloc.

### pokemon_model.dart

- Represents the Pokemon model with properties like id , name , and imageUrl .

### pokemon_repository.dart

- Handles API calls to fetch Pokemon data from the PokeAPI.
- Implements error handling and response parsing.

### error_view.dart

- Displays an error view with a message and a try-again button.
- Shows a sad Pikachu image in case of errors.

### pokemon_state.dart

- Defines the Pokemon state classes like PokemonInitial , PokemonLoading , PokemonLoaded , and PokemonError .

### pokemon_list_view.dart

- Displays the list of Pokemon with red backgrounds and rounded corners.
- Handles loading indicators and error views.

### pokemon_list_item.dart

- Represents a single Pokemon item in the list with custom styling and Pokemon details.

### pikachu_loading.dart

- Displays a loading indicator with a Pikachu image and loading text.
