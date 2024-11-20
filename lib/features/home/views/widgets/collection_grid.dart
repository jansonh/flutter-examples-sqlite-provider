import 'package:flutter/material.dart';

import '../../../../models/pokemon_detail.dart';
import 'collection_item.dart';

class CollectionGrid extends StatefulWidget {
  const CollectionGrid({super.key, required this.pokemon});

  final List<PokemonDetail> pokemon;

  @override
  State<CollectionGrid> createState() => _CollectionGridState();
}

class _CollectionGridState extends State<CollectionGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: widget.pokemon.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.8,
        mainAxisSpacing: 15,
      ),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        if (widget.pokemon.isNotEmpty) {
          return CollectionItem(
            pokemon: widget.pokemon[index],
            index: index,
          );
        } else {
          return Container();
        }
      },
    );
  }
}
