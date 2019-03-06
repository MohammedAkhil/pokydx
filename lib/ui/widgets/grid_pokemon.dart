import 'package:Pokydx/data/pokemon.dart';
import 'package:Pokydx/ui/widgets/types_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class GridPokemon extends StatelessWidget {
  final List<Pokemon> pokemon;
  final ScrollController controller;
  final Function onTapPokemon;

  static const String BASE_IMG_URL =
      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/";

  const GridPokemon({Key key, this.pokemon, this.onTapPokemon, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: GridView.builder(
          controller: controller,
          itemCount: pokemon.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 11 / 10),
          itemBuilder: (context, index) {
            return InkWell(
                onTap: () {
                  onTapPokemon(pokemon[index]);
                },
                child: x(index));
          }),
    );
  }

  Widget pokeImageWidget(int index) {
    return Container(
      height: 60,
      width: 60,
      child: CachedNetworkImage(
        imageUrl: BASE_IMG_URL + (pokemon[index].id).toString() + '.png',
        height: 60,
        fit: BoxFit.fitHeight,
        fadeInDuration: Duration(microseconds: 100),
        placeholder: (context, url) => Text('...'),
      ),
    );
  }

  String getPokeNumber(int id) {
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

  Widget x(int index) {
    return Card(
      margin: EdgeInsets.all(6),
      elevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            pokemon[index].id.toString() + ' ' + pokemon[index].name,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16),
          ),
          pokeImageWidget(index),
          SizedBox(
            height: 6,
          ),
          TypesWidget(
            types: pokemon[index].type,
            isSmall: true,
          ),
        ],
      ),
    );
  }

  String getGeneration(int id) {
    if (id > 151) {
      return '2nd gen';
    } else {
      return '1st gen';
    }
  }
}
