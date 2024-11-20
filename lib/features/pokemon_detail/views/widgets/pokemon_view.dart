import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/pokemon_detail_provider.dart';
import '../../../../models/pokemon_detail.dart';
import '../../../../widgets/custom_image_network.dart';
import '../../../../widgets/snackbar.dart';

class PokemonView extends ConsumerStatefulWidget {
  const PokemonView({super.key, required this.pokemon});

  final PokemonDetail pokemon;

  @override
  ConsumerState<PokemonView> createState() => _PokemonViewState();
}

class _PokemonViewState extends ConsumerState<PokemonView> {
  final _headingTextStyle = const TextStyle(
    fontSize: 20.0,
    decoration: TextDecoration.underline,
    fontWeight: FontWeight.bold,
  );
  final _afterHeadingHeight = 4.0;
  final _beforeHeadingHeight = 20.0;

  bool _buttonClickable = true;
  Timer? _timer;

  @override
  void dispose() {
    // Cancel existing timer when disposing the widget
    _timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pokemon.name),
        actions: [
          IconButton(
            onPressed: _buttonClickable
                ? () async {
                    // Insert to database
                    final success = await ref.read(
                      insertCollectionProvider(widget.pokemon).future,
                    );

                    if (success) {
                      showSnackBar('Added to collection!', context: context);

                      // Change the button icon
                      setState(() {
                        _buttonClickable = false;
                      });

                      // Cancel previous timer
                      _timer?.cancel();

                      // Change back the icon
                      _timer = Timer(const Duration(seconds: 3), () {
                        // Check if widget is still in the tree before changing
                        // state
                        if (mounted) {
                          setState(() {
                            _buttonClickable = true;
                          });
                        }
                      });
                    }
                  }
                : null,
            icon: _buttonClickable
                ? const Icon(Icons.add)
                : const Icon(Icons.check, color: Colors.green),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: Column(
              children: [
                CustomImageNetwork(imageUrl: widget.pokemon.imageLowRes),
                SizedBox(height: _beforeHeadingHeight),
                Text('Illustrator', style: _headingTextStyle),
                SizedBox(height: _afterHeadingHeight),
                Text(widget.pokemon.illustrator),
                SizedBox(height: _beforeHeadingHeight),
                Text('Sets', style: _headingTextStyle),
                SizedBox(height: _afterHeadingHeight),
                Text(widget.pokemon.setName),
                SizedBox(height: _beforeHeadingHeight),
                Text('Description', style: _headingTextStyle),
                SizedBox(height: _afterHeadingHeight),
                Text(widget.pokemon.description, textAlign: TextAlign.justify),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
