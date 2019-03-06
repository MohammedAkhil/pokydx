import 'package:flutter/material.dart';

import '../../data/pokemon.dart';

class ListItemPokemon extends StatelessWidget {
  final Pokemon pokemon;
  final Function onTapPokemon;
  final int id;

  static const String BASE_IMG_URL =
      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/";

  ListItemPokemon({Key key, this.onTapPokemon, this.pokemon, this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      onTap: () {
        onTapPokemon(pokemon);
      },
      leading: pokeImageWidget(),
      title: Text(
        pokemon.name,
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
      ),
      subtitle:
          Text(getPokeNumber(), style: TextStyle(color: Colors.black38, fontSize: 16)),
      trailing: Text(
        getGeneration(),
        style: TextStyle(color: Colors.black54),
      ),
    );
  }

  Widget pokeImageWidget() {
    return Container(
      width: 100,
      height: 100,
      child: FadeInImage.assetNetwork(
        image: BASE_IMG_URL + (id).toString() + '.png',
        placeholder: 'assets/images/pokeLogo.png',
      ),
    );
  }

  String getPokeNumber() {
    int preZeroCount = 3 - (id).toString().length;
    String preZeroes;
    switch (preZeroCount) {
      case 2:
        preZeroes = "00";
        break;
      case 1:
        preZeroes = "0";
        break;
      default:
        preZeroes = "";
    }
    return "#$preZeroes$id";
  }

  String getGeneration() {
    if (id > 151) {
      return '2nd gen';
    } else {
      return '1st gen';
    }
  }
}
