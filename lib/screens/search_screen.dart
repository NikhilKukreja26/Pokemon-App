import 'package:flutter/material.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

import '../models/pokemon_model.dart';
import '../screens/pokemon_detail_screen.dart';
import '../widgets/build_pokemon_item.dart';

class SearchScreen extends SearchDelegate {
  final List<Pokemon> pokemon;

  SearchScreen(this.pokemon);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      primarySwatch: Colors.red,
      brightness: DynamicTheme.of(context).brightness,
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final searchedPokemon = query.isEmpty
        ? pokemon
        : pokemon
            .where((pokemonItem) =>
                pokemonItem.name.toString().toLowerCase().startsWith(query))
            .toList();
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // number of grid items horizotally.
        childAspectRatio: 3 / 3, // here 3 means 300 which is the height.
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemCount: searchedPokemon.length,
      itemBuilder: (BuildContext context, int index) => InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PokemonDetailScreen(
                pokemon: searchedPokemon[index],
              ),
            ),
          );
        },
        child: Hero(
          tag: searchedPokemon[index].img,
          child: BuildPokemonItem(
            pokemonId: searchedPokemon[index].id.toString(),
            pokemonImage: searchedPokemon[index].img,
            pokemonName: searchedPokemon[index].name,
          ),
        ),
      ),
    );
  }
}
