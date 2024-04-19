import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:pokedex_v1_0_0/models/pokemon_model.dart';
import 'package:pokedex_v1_0_0/resources/api_endpoints.dart';

class PokemonRepository {
  int limit = 10;

  Future<List<Pokemon>> fetchPokemons({int offset = 0}) async {
    List<Pokemon> pokemons = [];
    try {
      final response =
          await http.get(Uri.parse('$pokemonList?offset=$offset&limit=$limit'));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        List<dynamic> pokemonsJson = data['results'];

        for (var json in pokemonsJson) {
          String name = json['name'];
          int id = int.parse(json['url'].split('/').reversed.elementAt(1));
          String imageUrl = getPokemonImageUrl(id);
          pokemons.add(Pokemon(
            id: id,
            name: name,
            imageUrl: imageUrl,
            types: [],
            height: 0,
            weight: 0,
          ));
        }

        if (kDebugMode) {
          print('Pokemons loaded successfully: ${pokemons.length} pokemons');
        }
        offset += limit;
        return pokemons;
      } else {
        if (kDebugMode) {
          print('Failed to load pokemons. Status code: ${response.statusCode}');
        }
        throw Exception('Failed to load pokemons: ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Network error: $e');
      }
      throw Exception(
          'Failed to fetch pokemons. Please check your internet connection');
    }
  }

  Future<Pokemon> fetchPokemonDetails(int id) async {
    final response = await http.get(Uri.parse('$pokemonList/$id'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data != null) {
        return Pokemon.fromJson(data);
      } else {
        throw Exception('Failed to parse Pokemon data');
      }
    } else {
      throw Exception('Failed to load pokemon details');
    }
  }

  Future<String> fetchPokemonDescription(int id) async {
    final response = await http.get(Uri.parse('$pokemonList/$id'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final speciesUrl = data['species']['url'];
      final speciesResponse = await http.get(Uri.parse(speciesUrl));
      if (speciesResponse.statusCode == 200) {
        final speciesData = json.decode(speciesResponse.body);
        final flavorTextEntries = speciesData['flavor_text_entries'];
        final englishFlavorText = flavorTextEntries.firstWhere(
            (entry) => entry['language']['name'] == 'en',
            orElse: () => null);
        if (englishFlavorText != null) {
          return englishFlavorText['flavor_text'];
        } else {
          throw Exception('Failed to find English flavor text');
        }
      } else {
        throw Exception('Failed to load pokemon species');
      }
    } else {
      throw Exception('Failed to load pokemon details');
    }
  }

  Future<String> fetchPokemonCryUrl(int id) async {
    final response = await http.get(Uri.parse('$pokemonList/$id'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final cries = data['cries'];
      final latestCryUrl = cries['latest'];
      return latestCryUrl;
    } else {
      throw Exception('Failed to load pokemon cry URL');
    }
  }
}
