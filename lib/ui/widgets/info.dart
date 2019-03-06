import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../data/pokemon.dart';
import '../widgets/grid_stats.dart';
import '../widgets/habitat_widget.dart';
import '../widgets/list_abilities.dart';
import '../widgets/types_widget.dart';

class InfoWidget extends StatelessWidget {
  final Pokemon pokemon;

  InfoWidget({Key key, this.pokemon}) : super(key: key);

  static const String BASE_IMG_URL =
      'https://veekun.com/dex/media/pokemon/global-link/';

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
                  TypesWidget(
                    types: pokemon.type,
                    isSmall: false,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  heightAndWeight(pokemon.height, pokemon.weight, context),
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
        table(),
        Container(margin: EdgeInsets.only(top: 24), child: baseHappiness()),
        captureRate(context),
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

  Widget heightAndWeight(int height, int weight, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24, top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildSizeProperty('height', height.toString(), context),
          SizedBox(
            width: 20,
          ),
          buildSizeProperty('weight', weight.toString(), context),
        ],
      ),
    );
  }

  Widget buildSizeProperty(
      String title, String property, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          property,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.body2,
        ),
      ],
    );
  }

  Widget circularLoader() {
    return Center(
      child: CircularProgressIndicator(strokeWidth: 4),
    );
  }

  String getImageUrl(int id) {
    return BASE_IMG_URL + id.toString() + '.png';
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

  Widget baseHappiness() {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4))),
      elevation: 5.0,
      margin: EdgeInsets.all(12),
      color: Colors.teal,
      child: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          children: <Widget>[
            Text(
              'Base Happiness',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 24),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              getHappinessDescription(),
              textAlign: TextAlign.justify,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 14),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              pokemon.baseHappiness.toString(),
              style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }

  Widget captureRate(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12, top: 12, left: 2, right: 2),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4))),
        elevation: 5.0,
        margin: EdgeInsets.all(12),
        color: Colors.indigo,
        child: Container(
          margin: EdgeInsets.all(24),
          child: Column(
            children: <Widget>[
              Container(
                child: Text(
                  'Capture Rate',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                      color: Colors.white),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                getCatchRateDescription(),
                textAlign: TextAlign.justify,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/icons/ic-pokeball.png',
                    height: 50,
                  ),
                  SizedBox(
                    width: 24,
                  ),
                  Text(
                    pokemon.captureRate.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 32,
                        color: Colors.white),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget table() {
    return Container(
      child: Container(
        margin: EdgeInsets.only(bottom: 0, top: 32, left: 24, right: 0),
        child: Table(
          children: tableRow(),
        ),
      ),
    );
  }

  List<TableRow> tableRow() {
    Map<String, String> data = {
      "base experience": pokemon.baseExperience.toString(),
      "hatch counter": pokemon.hatchCounter.toString(),
      "gender rate": pokemon.genderRate.toString(),
      "baby": pokemon.isBaby ? "yes" : "no",
      "gender difference": pokemon.hasGenderDifferences ? "yes" : "no",
    };

    var cells = List<TableRow>();

    data.forEach((title, value) {
      cells.add(TableRow(children: [
        TableCell(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 24, top: 8, bottom: 8),
              child: Text(
                title,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8, left: 64),
            child: Center(child: Text(value, style: TextStyle(fontSize: 16))),
          ),
        )
      ]));
    });

    return cells;
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

String getHappinessDescription() {
  return "A Pokémon's base friendship is the value to which its friendship is set when the Pokémon is caught, received from an event or NPC, or received from a trade with another player.";
}

String getCatchRateDescription() {
  return "Each species of Pokémon has a catch rate that applies to all its members. When a Poké Ball is thrown at a wild Pokémon, the game uses that Pokémon's catch rate in a formula to determine the chances of catching that Pokémon.";
}
