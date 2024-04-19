class Pokemon {
  final int id;
  final String name;
  final String imageUrl;
  final List<String> types;
  final int height;
  final int weight;

  Pokemon({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.types,
    required this.height,
    required this.weight,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    List<dynamic> typesJson = json['types'];
    List<String> types =
        typesJson.map((type) => type['type']['name'].toString()).toList();
    String imageUrl =
        json['sprites']['other']['official-artwork']['front_default'];

    return Pokemon(
      id: json['id'],
      name: json['name'],
      imageUrl: imageUrl,
      height: json['height'],
      weight: json['weight'],
      types: types,
    );
  }
}
