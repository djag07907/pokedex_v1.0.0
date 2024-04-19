const String baseUrl = 'https://pokeapi.co/api/v2';
const String pokemonList = '$baseUrl/pokemon';
const String abilityList = '$baseUrl/ability';

String getPokemonImageUrl(int id) {
  return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png";
}
