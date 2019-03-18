import 'package:Pokydx/data/pokemon.dart';

class Ability {
  final String name;
  final String url;
  final bool isHidden;
  final int slot;
  final String effectEntry;
  final String generation;
  final int id;
  final List<Pokemon> pokemon;
  final bool isMainSeries;

  Ability(
      {this.name,
      this.url,
      this.isHidden,
      this.slot,
      this.effectEntry,
      this.generation,
      this.id,
      this.pokemon,
      this.isMainSeries});

  factory Ability.fromJson(Map<String, dynamic> json) {
    return Ability(
        name: json['ability']['name'],
        url: json['ability']['url'],
        isHidden: json['is_hidden'],
        slot: json['slot']);
  }

  factory Ability.fromDetailedJson(Map<String, dynamic> json) {
    return Ability(
        name: json['name'],
        id: json['id'],
        effectEntry: json['effect_entries'][0]['effect'],
        generation: json['generation']['name'],
        isMainSeries: json['is_main_series'],
        pokemon: getPokemonList(json['pokemon']));
  }

  static getPokemonList(List<dynamic> jsonList) {
    var pokeList = List<Pokemon>();
    jsonList.forEach((json) {
      pokeList.add(Pokemon.fromAbilityJson(json));
    });
    return pokeList;
  }
}
