import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../widgets/custom_image_network.dart';
import '../../../../models/pokemon_detail.dart';

class PokemonPopupDialog extends ConsumerWidget {
  const PokemonPopupDialog({super.key, required this.pokemon});

  final PokemonDetail pokemon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border.all(
                color: Colors.grey,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              pokemon.name,
              style: const TextStyle(
                fontSize: 28,
              ),
            ),
          ),
          const SizedBox(height: 40),
          CustomImageNetwork(
            imageUrl: pokemon.imageHighRes,
            color: Colors.white,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                label: const Icon(Icons.close),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
