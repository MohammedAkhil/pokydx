import 'package:flutter/material.dart';
import '../../data/Pokemon.dart';
import 'pokeCell.dart';

class PokeList extends StatelessWidget {

  PokeList({Key key, this.list, this.onTapPokemon, this.controller}) : super(key: key);

  final List<Pokemon> list;
  final Function onTapPokemon;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: listView()
    );
  }

  Widget listView()  {
    return (
      ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          Pokemon pokemon = list.elementAt(index);
          return ListTile(
            title: PokeCell(title: pokemon.name, number: index+1),
            onTap: () { onTapPokemon(pokemon);},
          );
        },
        controller: controller,
      )
    );
  }

  Widget circularLoader() {
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: 8
      ),
    );
  }
}