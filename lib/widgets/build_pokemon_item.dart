import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BuildPokemonItem extends StatelessWidget {
  final String pokemonId;
  final String pokemonImage;
  final String pokemonName;

  BuildPokemonItem({this.pokemonId, this.pokemonImage, this.pokemonName});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: GridTile(
        child: Container(
          color: Colors.grey[300],
          child: CachedNetworkImage(
            imageUrl: pokemonImage,
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
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Text(
            '$pokemonId)',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
          title: Text(
            pokemonName,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
    // return Card(
    //   elevation: 4.0,
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //     children: <Widget>[
    //       Container(
    //         width: 100.0,
    //         height: 100.0,
    //         decoration: BoxDecoration(
    //           image: DecorationImage(
    //             image: NetworkImage(pokemonImage),
    //           ),
    //         ),
    //       ),
    //       Text(
    //         pokemonName,
    //         style: TextStyle(
    //           fontSize: 22.0,
    //           fontWeight: FontWeight.bold,
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
