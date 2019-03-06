import 'package:Pokydx/data/abilitiy.dart';
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
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate([
            id(ability.id, context),
            header(ability.name, context),
            description(ability.effectEntry, context),
            subtitle(ability.name, context),
          ]),
        ),
        SliverGrid(
            delegate: SliverChildBuilderDelegate((context, index) {
              String id = getId(ability.pokemon[index].url);

              return Container(
                margin: EdgeInsets.only(left: 12, right: 12),
                child: int.parse(id) < 1000
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.network(
                            BASE_IMG_URL + id + '.png',
                            width: 120,
                          ),
                          Text(
                            ability.pokemon[index].name,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,),
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      )
                    : null,
              );
            }, childCount: ability.pokemon.length),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ))
      ],
    );
  }

  Widget header(String name, BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 24, bottom: 8),
        child: Text(
          name,
          style: Theme.of(context).textTheme.headline,
        ));
  }

  Widget id(int id, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 24, bottom: 4),
      child: Text(
        id.toString(),
        style: Theme.of(context).textTheme.subtitle,
      ),
    );
  }

  Widget description(String text, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 24, bottom: 48, right: 16),
      child: Text(text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          )),
    );
  }

  Widget subtitle(String name, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Center(
        child: Text(
          'pokemon with "$name" ability',
          style: Theme.of(context).textTheme.subtitle,
        ),
      ),
    );
  }

  String getId(String url) {
    return RegExp(r'\/\d+\/').stringMatch(url).replaceAll('/', '');
  }
}
