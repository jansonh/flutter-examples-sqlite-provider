import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../apis/pokemon_api.dart';
import '../../../models/pokemon_detail.dart';

// Get the list of cards from your collections
final getCollectionsProvider =
    StreamProvider<List<PokemonDetail>>((ref) async* {
  final db = await ref.read(pokemonDBProvider.future);

  yield* db.getCollections().map((resultSet) {
    if (resultSet.isEmpty) {
      return <PokemonDetail>[];
    }

    final collections =
        resultSet.map<PokemonDetail>((c) => PokemonDetail.fromMap(c)).toList();

    return collections;
  });
});
