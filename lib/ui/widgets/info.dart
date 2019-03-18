import 'package:Pokydx/ui/widgets/base_happiness.dart';
import 'package:Pokydx/ui/widgets/capture_rate.dart';
import 'package:Pokydx/ui/widgets/height_weight.dart';
import 'package:Pokydx/ui/widgets/misc_stats.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../data/pokemon.dart';
import '../widgets/abilities_list.dart';
import '../widgets/base_stats.dart';
import '../widgets/habitat.dart';
import '../widgets/types.dart';

class InfoWidget extends StatelessWidget {
  final Pokemon pokemon;

  InfoWidget({Key key, this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: body(pokemon, context),
    );
  }

  Widget body(Pokemon pokemon, BuildContext context) {
    return Container(
        child: CustomScrollView(slivers: <Widget>[
      appBar(context),
      SliverList(
        delegate: SliverChildListDelegate([
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              image(pokemon.id),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 24,
                  ),
                  Types(
                    types: pokemon.type,
                    isSmall: false,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  HeightWeight(
                    height: pokemon.height,
                    weight: pokemon.weight,
                  ),
                ],
              )
            ],
          ),
          classification(context),
          Padding(
            child: Text(
              pokemon.description,
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.body1,
            ),
            padding: EdgeInsets.only(left: 24, right: 24, bottom: 32),
          ),
        ]),
      ),
      HabitatWidget(
        pokemon: pokemon,
      ),
      AbilitiesWidget(
        abilities: pokemon.abilities,
      ),
      SliverToBoxAdapter(
        child: Container(
          margin: EdgeInsets.only(top: 24, bottom: 4),
          child: Center(
            child: Text(
              'base stats',
              style: Theme.of(context).textTheme.title,
            ),
          ),
        ),
      ),
      GridAbilities(
        stats: pokemon.stats,
        color: pokemon.color,
      ),
      SliverList(
          delegate: SliverChildListDelegate([
        MiscStats(
          pokemon: pokemon,
        ),
        Container(
            margin: EdgeInsets.only(top: 24),
            child: BaseHappiness(
              baseHappiness: pokemon.baseHappiness,
            )),
        CaptureRate(
          captureRate: pokemon.captureRate,
        ),
      ]))
    ]));
  }

  Widget headerText(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 24),
        child: Text(
          pokemon.name,
          style: Theme.of(context).textTheme.headline,
        ));
  }

  Widget image(int id) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Center(
          child: Container(
        height: 130,
        width: 130,
        child: CachedNetworkImage(
          imageUrl: pokemon.image,
          fit: BoxFit.fitHeight,
          placeholder: (context, url) => CircularProgressIndicator(),
        ),
      )),
    );
  }

  Widget circularLoader() {
    return Center(
      child: CircularProgressIndicator(strokeWidth: 4),
    );
  }

  String getPokeNumber(int number) {
    int preZeroCount = 3 - number.toString().length;
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
    return "#$preZeroes$number";
  }

  Widget appBar(BuildContext context) {
    return SliverAppBar(
      elevation: 5.0,
      floating: true,
      snap: true,
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 8, top: 0),
          child: Center(
            child: Text(pokemon.id != null ? getPokeNumber(pokemon.id) : '',
                style: Theme.of(context).textTheme.subtitle),
          ),
        )
      ],
      title: Text(
        pokemon.id != null ? pokemon.name : '',
        style: Theme.of(context).textTheme.headline,
      ),
    );
  }

  Widget classification(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 0),
      child: Center(
        child: Text(pokemon.classification,
            style: Theme.of(context).textTheme.subtitle),
      ),
    );
  }
}
