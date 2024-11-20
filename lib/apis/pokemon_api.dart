import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:sqlite_async/sqlite3_common.dart';

import '../core/database.dart';
import '../core/failure.dart';
import '../core/type_defs.dart';
import '../models/pokemon_card.dart';
import '../models/pokemon_detail.dart';

final pokemonDBProvider = FutureProvider<PokemonDB>(
  (ref) async {
    final db = await ref.read(databaseProvider.future);
    return PokemonDB(db: db);
  },
);

class PokemonDB {
  final Database _db;

  PokemonDB({required Database db}) : _db = db;

  Stream<ResultSet> getCollections() {
    return _db.watch('SELECT * FROM pokemon_cards');
  }

  FutureEitherVoid insert(
    String pokemonId,
    String name,
    String setName,
    String description,
    String illustrator,
    String image,
  ) async {
    try {
      await _db.execute(
        """
        INSERT INTO pokemon_cards(
          pokemonId,
          name,
          setName,
          description,
          illustrator,
          image
        ) VALUES (?, ?, ?, ?, ?, ?)
        """,
        [pokemonId, name, setName, description, illustrator, image],
      );
      return right(null);
    } catch (error, stackTrace) {
      return left(Failure(error.toString(), stackTrace));
    }
  }
}

class PokemonAPI {
  final baseUrl = 'https://api.tcgdex.net/v2/en';

  get searchEndpoint => '$baseUrl/cards';

  Future<List<PokemonCard>> searchAPI(String name) async {
    final response = await http.Client().get(
      Uri.parse('$searchEndpoint?name=$name'),
    );

    return compute(
      (responseBody) {
        final parsed = jsonDecode(responseBody) as List<dynamic>;
        final cards = parsed
            .map<PokemonCard>((json) => PokemonCard.fromJson(json))
            .toList();

        // Remove cards with no image
        cards.removeWhere((card) => !card.hasImage);

        return cards;
      },
      response.body,
    );
  }

  Future<PokemonDetail> getAPI(String id) async {
    final response = await http.Client().get(
      Uri.parse('$searchEndpoint/$id'),
    );

    return compute(
      (responseBody) {
        final json = jsonDecode(responseBody) as Map<String, dynamic>;
        return PokemonDetail.fromJson(json);
      },
      response.body,
    );
  }
}
