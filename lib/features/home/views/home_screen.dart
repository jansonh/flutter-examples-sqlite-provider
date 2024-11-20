import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'widgets/collection_grid.dart';
import '../../../features/search/views/search_screen.dart';
import '../providers/pokemon_collection_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const routeName = '/';

  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Collections')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(SearchScreen.routeName);
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: ref.watch(getCollectionsProvider).when(
                data: (collections) {
                  if (collections.isNotEmpty) {
                    return CollectionGrid(pokemon: collections);
                  } else {
                    return const Center(child: Text('Empty'));
                  }
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (error, _) {
                  return Center(
                    child: Text(
                      error.toString(),
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              ),
        ),
      ),
    );
  }
}
