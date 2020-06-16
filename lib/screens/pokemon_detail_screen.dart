import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../models/pokemon_model.dart';

class PokemonDetailScreen extends StatelessWidget {
  final Pokemon pokemon;

  PokemonDetailScreen({this.pokemon});

  Widget _bodyWidget(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          height: MediaQuery.of(context).size.height / 1.5,
          width: MediaQuery.of(context).size.width - 20.0,
          left: 10.0,
          top: MediaQuery.of(context).size.height * 0.15,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                const SizedBox(
                  height: 50.0,
                ),
                Text(
                  pokemon.name,
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Height: ${pokemon.height}',
                ),
                Text(
                  'Weight: ${pokemon.weight}',
                ),
                Text(
                  'Types',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: pokemon.type
                      .map(
                        (type) => FilterChip(
                          label: Text(type),
                          onSelected: (_) {},
                          backgroundColor: Colors.amber,
                        ),
                      )
                      .toList(),
                ),
                Text(
                  'Weakness',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: pokemon.weaknesses
                      .map(
                        (weaknesses) => FilterChip(
                          label: Text(
                            weaknesses,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onSelected: (_) {},
                          backgroundColor: Colors.red,
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Hero(
            tag: pokemon.img,
            child: Container(
              width: 200.0,
              height: 200.0,
              child: CachedNetworkImage(
                imageUrl: pokemon.img,
                fit: BoxFit.cover,
                placeholder: (context, url) => Center(
                  heightFactor: 18.0,
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Icon(
                  Icons.error,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(pokemon.name),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: _bodyWidget(context),
    );
  }
}
