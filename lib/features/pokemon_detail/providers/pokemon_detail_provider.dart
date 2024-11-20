import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../apis/pokemon_api.dart';
import '../../../widgets/snackbar.dart';
import '../../../models/pokemon_detail.dart';

final insertCollectionProvider = FutureProvider.autoDispose
    .family<bool, PokemonDetail>((ref, pokemon) async {
  final db = await ref.read(pokemonDBProvider.future);

  final result = await db.insert(
    pokemon.pokemonId,
    pokemon.name,
    pokemon.setName,
    pokemon.description,
    pokemon.illustrator,
    pokemon.image,
  );

  return result.fold(
    (failure) {
      showSnackBar(failure.message);
      return false;
    },
    (_) => true,
  );
});
