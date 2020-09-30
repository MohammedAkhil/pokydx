import 'package:Pokydx/ui/widgets/types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../data/pokemon.dart';

class ListItemPokemon extends StatelessWidget {
  final Pokemon pokemon;
  final Function onTapPokemon;
  final int id;
  final String name;
  final int speciesId;
  final Function addToFavourites;
  final SlidableController slidableController = SlidableController();

  static const String BASE_IMG_URL =
      "https://assets.pokemon.com/assets/cms2/img/pokedex/detail/";

  ListItemPokemon(
      {Key key,
      this.onTapPokemon,
      this.pokemon,
      this.id,
      this.name,
      this.speciesId,
      this.addToFavourites})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: Key(pokemon.id.toString()),
      delegate: SlidableBehindDelegate(),
      controller: slidableController,
      actionExtentRatio: 0.25,
      child: InkWell(
        onTap: () {
          onTapPokemon(pokemon);
        },
        child: buildCard(context),
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'save',
          color: Colors.deepOrange,
          icon: Icons.favorite,
          onTap: () {},
        ),
      ],
    );
  }

  Card buildCard(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(12, 4, 12, 4),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      elevation: 0,
      child: Stack(
        children: <Widget>[
          legendaryLogo(),
          Container(
            margin: EdgeInsets.all(8),
            child: Row(
              children: <Widget>[
                image(),
                SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      pokemon.name,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    pokedexNumber(context),
                  ],
                ),
                Spacer(),
                types(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget pokedexNumber(BuildContext context) =>
      Text(formatPokedexNumber(), style: Theme.of(context).textTheme.body1);

  Widget image() => Container(
        width: 55,
        height: 55,
        child: FadeInImage.assetNetwork(
          image: getImageUrl(id),
          placeholder: 'assets/images/pokeLogo.png',
        ),
      );

  String formatPokedexNumber() {
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
    return "$preZeroes$id";
  }

  Widget types() {
    return Types(
      types: pokemon.type,
      isSmall: true,
    );
  }

  Widget legendaryLogo() {
    return pokemon.isLegendary
        ? Positioned(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: 16,
                  child: Image.asset('assets/icons/ic-legendary.png')),
            ),
            bottom: 0,
            right: 0,
          )
        : Container();
  }

  String getImageUrl(int id) {
    if (id <= 809) {
      return BASE_IMG_URL + formatPokedexNumber() + '.png';
    }
    String baseUrl =
        "https://cdn.jsdelivr.net/gh/MohammedAkhil/sprites/sprites/pokemon/";
    String imageId = id <= 10090
        ? id.toString()
        : speciesId.toString() + getSubSpeciesName(name);
    return baseUrl + imageId + '.png';
  }

  String getSubSpeciesName(String fullName) {
    return fullName.substring(fullName
        .indexOf(RegExp(r'-[\w]{2,}').stringMatch(fullName).toString()));
  }
}
