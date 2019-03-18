import 'package:Pokydx/data/ability_data.dart';
import 'package:flutter/material.dart';

class AbilityWidget extends StatelessWidget {
  final Ability ability;

  const AbilityWidget({Key key, this.ability}) : super(key: key);
  static const String BASE_IMG_URL =
      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/";

  @override
  Widget build(BuildContext context) {
    return main(context);
  }

  Widget main(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[list(context), buildGrid()],
    );
  }

  SliverList list(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        Row(
          children: <Widget>[
            buildId(ability.id, context),
            header(ability.name, context),
          ],
        ),
        description(ability.effectEntry, context),
        subtitle(ability.name, context),
      ]),
    );
  }

  SliverGrid buildGrid() => SliverGrid(
      delegate: SliverChildBuilderDelegate((context, index) => gridItem(index),
          childCount: ability.pokemon.length),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, childAspectRatio: 12 / 10));

  Widget gridItem(int index) => Container(
      margin: EdgeInsets.only(left: 4, right: 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.network(
            BASE_IMG_URL + getId(ability.pokemon[index].url) + '.png',
            width: 70,
          ),
          Text(
            ability.pokemon[index].name,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          )
        ],
      ));

  Widget header(String name, BuildContext context) => Container(
      margin: EdgeInsets.only(left: 8, bottom: 8),
      child: Text(
        name,
        style: Theme.of(context).textTheme.headline,
      ));

  Widget buildId(int id, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 24, bottom: 8),
      child: Text(
        id.toString() + ' -',
        style: Theme.of(context).textTheme.headline,
      ),
    );
  }

  Widget description(String text, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 24, bottom: 32, right: 16),
      child: Text(text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          )),
    );
  }

  Widget subtitle(String name, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 0, left: 24),
      child: Text(
        'pokemon with ability',
        style: Theme.of(context).textTheme.headline,
      ),
    );
  }

  String getId(String url) {
    return RegExp(r'\/\d+\/').stringMatch(url).replaceAll('/', '');
  }
}
