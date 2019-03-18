import 'package:Pokydx/data/pokemon.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HabitatWidget extends StatelessWidget {
  final Pokemon pokemon;

  static const String BASE_HABITAT_URL =
      'https://veekun.com/dex/media/habitats/';

  const HabitatWidget({Key key, this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: pokemon.habitat != '' ? main(context) : Container());
  }

  Widget main(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          header(context),
          SizedBox(
            width: 40,
          ),
          image()
        ],
      ),
    );
  }

  Widget header(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
      Text('habitat', style: Theme.of(context).textTheme.display1,),
        Text(pokemon.habitat, style: Theme.of(context).textTheme.caption,)
      ],
    );
  }

  Widget image() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Container(
        width: 80,
        height: 60,
        child: CachedNetworkImage(
          imageUrl: BASE_HABITAT_URL + pokemon.habitat + '.png',
          fit: BoxFit.fitWidth,
          placeholder: (context, url) => CircularProgressIndicator(),
        ),
      ),
    );
  }
}
