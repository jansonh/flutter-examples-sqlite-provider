import 'package:go_router/go_router.dart';

import '../features/home/views/home_screen.dart';
import '../features/pokemon_detail/views/pokemon_detail_screen.dart';
import '../features/search/views/search_screen.dart';

class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: HomeScreen.routeName,
    routes: [
      GoRoute(
        path: HomeScreen.routeName,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: SearchScreen.routeName,
        builder: (context, state) => const SearchScreen(),
      ),
      GoRoute(
        name: PokemonDetailScreen.routeName,
        path: '${PokemonDetailScreen.routeName}/:pokemonId',
        builder: (context, state) => PokemonDetailScreen(
          pokemonId: state.pathParameters['pokemonId'],
        ),
      ),
    ],
  );
}
