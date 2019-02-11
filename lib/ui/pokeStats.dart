import '../data/Pokemon.dart';
import 'package:flutter/material.dart';


class PokeStats extends StatelessWidget{
  PokeStats({this.futurePokemon});

  final Future<Pokemon> futurePokemon;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futurePokemon,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          Pokemon pokemon = snapshot.data;
          return name(pokemon.name);
        } else {
          return circularLoader();
        }
      }
    );
  }

  Widget circularLoader() {
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: 8
      ),
    );
  }

  Widget photo() {

  }

  Widget name(String name) {
    return Text(name);
  }

  Widget type() {

  }
}