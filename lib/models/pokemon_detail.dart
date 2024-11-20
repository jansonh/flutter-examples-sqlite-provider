class PokemonDetail {
  final int? id;
  final String pokemonId;
  final String name;
  final String setName;
  final String description;
  final String illustrator;
  final String image;

  PokemonDetail({
    this.id,
    required this.pokemonId,
    required this.name,
    required this.setName,
    required this.description,
    required this.illustrator,
    required this.image,
  });

  get imageLowRes => '$image/low.png';
  get imageHighRes => '$image/high.png';

  // Convert from API results
  factory PokemonDetail.fromJson(Map<String, dynamic> json) {
    return PokemonDetail(
      pokemonId: json['id'] as String,
      name: json['name'] as String,
      setName: (json['set']['name'] ?? '-') as String,
      description: (json['description'] ?? '-') as String,
      illustrator: (json['illustrator'] ?? '-') as String,
      image: json['image'] as String,
    );
  }

  // Convert from database results
  factory PokemonDetail.fromMap(Map<String, dynamic> map) {
    return PokemonDetail(
      id: map['id'] as int,
      pokemonId: map['pokemonId'] as String,
      name: map['name'] as String,
      setName: map['setName'] as String,
      description: map['description'] as String,
      illustrator: map['illustrator'] as String,
      image: map['image'] as String,
    );
  }
}
