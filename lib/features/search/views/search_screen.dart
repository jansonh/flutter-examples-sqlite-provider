import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../apis/pokemon_api.dart';
import '../../../models/pokemon_card.dart';
import '../../../widgets/custom_image_network.dart';
import '../../pokemon_detail/views/pokemon_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search';

  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final PokemonAPI _api = PokemonAPI();

  List<PokemonCard> _searchResults = [];
  bool _isLoading = false;

  void _search(String searchQuery) async {
    setState(() {
      _isLoading = true;
    });

    final results = await _api.searchAPI(searchQuery);

    setState(() {
      _searchResults = results;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 8,
          ),
          child: Column(
            children: [
              TextField(
                onSubmitted: _search,
                controller: _searchController,
                autocorrect: false,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                  hintText: 'Enter a Pokémon card name',
                  suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        _search(_searchController.text);
                      }),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.9,
                          crossAxisCount: 3,
                        ),
                        itemCount: _searchResults.length,
                        itemBuilder: (context, index) {
                          final pokemonCard = _searchResults[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 0,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                context.push(
                                  '${PokemonDetailScreen.routeName}/${pokemonCard.pokemonId}',
                                );
                              },
                              child: GridTile(
                                child: LayoutBuilder(
                                  builder: (context, constraints) {
                                    return Container(
                                      child: pokemonCard.hasImage
                                          ? CustomImageNetwork(
                                              imageUrl: pokemonCard.imageLowRes,
                                              height: 200,
                                            )
                                          : Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.grey,
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: const Icon(
                                                Icons.image_not_supported,
                                              ),
                                            ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
