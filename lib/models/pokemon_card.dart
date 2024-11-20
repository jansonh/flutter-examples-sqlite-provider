class PokemonCard {
  final String pokemonId;
  final String name;
  final String? image;

  PokemonCard({
    required this.pokemonId,
    required this.name,
    required this.image,
  });

  get hasImage => image != null;
  get imageLowRes => '$image/low.png';

  // Convert from API results
  factory PokemonCard.fromJson(Map<String, dynamic> json) {
    return PokemonCard(
      pokemonId: json['id'] as String,
      name: json['name'] as String,
      image: json['image'] as String?,
    );
  }
}
