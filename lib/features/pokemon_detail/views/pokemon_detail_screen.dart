import 'package:flutter/material.dart';

import '../../../apis/pokemon_api.dart';
import '../../../models/pokemon_detail.dart';
import 'widgets/pokemon_view.dart';

class PokemonDetailScreen extends StatefulWidget {
  static const routeName = '/pokemon';

  const PokemonDetailScreen({super.key, required this.pokemonId});

  final String? pokemonId;

  @override
  State<PokemonDetailScreen> createState() => _PokemonDetailScreenState();
}

class _PokemonDetailScreenState extends State<PokemonDetailScreen> {
  late Future<PokemonDetail> _pokemon;

  final PokemonAPI _api = PokemonAPI();

  @override
  void initState() {
    super.initState();
    _pokemon = _api.getAPI(widget.pokemonId!);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PokemonDetail>(
      future: _pokemon,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Scaffold(
            body: Center(
              child: Text('An error has occurred!'),
            ),
          );
        } else if (snapshot.hasData) {
          return PokemonView(pokemon: snapshot.data!);
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
