import 'package:flutter/material.dart';

import 'pokemon_popup.dart';
import '../../../../widgets/custom_image_network.dart';
import '../../../../models/pokemon_detail.dart';

class CollectionItem extends StatelessWidget {
  const CollectionItem({super.key, required this.pokemon, required this.index});

  final PokemonDetail pokemon;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            barrierColor: const Color.fromARGB(200, 30, 30, 30),
            builder: (context) {
              return PokemonPopupDialog(pokemon: pokemon);
            });
      },
      child: CustomImageNetwork(imageUrl: pokemon.imageLowRes),
    );
  }
}
