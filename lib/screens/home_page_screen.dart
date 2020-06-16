import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dynamic_theme/dynamic_theme.dart';

import '../models/pokemon_model.dart';
import '../widgets/build_pokemon_item.dart';
import '../screens/pokemon_detail_screen.dart';
import '../screens/search_screen.dart';

class HomePageScreen extends StatefulWidget {
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  var url =
      'https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json';

  PokemonModel pokemonModel;

  @override
  void initState() {
    super.initState();

    fetchData();
  }

  Future<void> fetchData() async {
    var response = await http.get(url);
    var decodedJson = jsonDecode(response.body);

    pokemonModel = PokemonModel.fromJson(decodedJson);

    print(pokemonModel.toJson());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Pokemon App',
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchScreen(pokemonModel.pokemon),
              );
            },
          ),
          IconButton(
              icon: Icon(Theme.of(context).brightness == Brightness.light
                  ? Icons.lightbulb_outline
                  : Icons.highlight),
              onPressed: () {
                DynamicTheme.of(context).setBrightness(
                    Theme.of(context).brightness == Brightness.light
                        ? Brightness.dark
                        : Brightness.light);
              })
        ],
      ),
      body: Center(
        child: pokemonModel != null
            ? RefreshIndicator(
                onRefresh: fetchData,
                child: GridView.builder(
                  padding: const EdgeInsets.all(4.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // number of grid items horizotally.
                    childAspectRatio:
                        3 / 3, // here 3 means 300 which is the height.
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                  ),
                  itemCount: pokemonModel.pokemon.length,
                  itemBuilder: (BuildContext context, int index) => InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PokemonDetailScreen(
                            pokemon: pokemonModel.pokemon[index],
                          ),
                        ),
                      );
                    },
                    child: Hero(
                      tag: pokemonModel.pokemon[index].img,
                      child: BuildPokemonItem(
                        pokemonId: pokemonModel.pokemon[index].id.toString(),
                        pokemonImage: pokemonModel.pokemon[index].img,
                        pokemonName: pokemonModel.pokemon[index].name,
                      ),
                    ),
                  ),
                ),
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}
