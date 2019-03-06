import 'dart:core';

import '../data/abilitiy.dart';
import '../data/stat.dart';

class Pokemon {
  Pokemon({
    this.name,
    this.id,
    this.image,
    this.type,
    this.url,
    this.height,
    this.weight,
    this.abilities,
    this.description,
    this.stats,
    this.color,
    this.generation,
    this.baseHappiness,
    this.captureRate,
    this.habitat,
  });

  final String name;
  final int id;
  final String image;
  final List<String> type;
  final List<Ability> abilities;
  final String url;
  final int height;
  final int weight;
  final String description;
  final List<Stat> stats;
  final String color;
  final String generation;
  final int baseHappiness;
  final int captureRate;
  final String habitat;

  factory Pokemon.fromJson(
      Map<String, dynamic> json, Map<String, dynamic> pokemonSpeciesData) {
    return Pokemon(
      name: json['name'],
      id: json['id'],
      image: json['sprites']['front_default'],
      height: json['height'],
      weight: json['weight'],
      type: Pokemon.getTypes(json['types']),
      abilities: Pokemon.getAbilities(json['abilities']),
      description: pokemonSpeciesData['textDescription'],
      stats: getStats(json['stats']),
      color: pokemonSpeciesData['color'],
      generation: pokemonSpeciesData['generation'],
      habitat: pokemonSpeciesData['habitat'],
      captureRate: pokemonSpeciesData['captureRate'],
      baseHappiness: pokemonSpeciesData['baseHappiness'],
    );
  }

  factory Pokemon.fromUrlJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'],
      url: json['url'],
      id: json['id'],
    );
  }

  static List<String> getTypes(List<dynamic> types) {
    return List<String>.from(
        types.map((type) => type['type']['name']).toList());
  }

  static List<Ability> getAbilities(List<dynamic> abilities) {
    return List<Ability>.from(
        abilities.map((ability) => Ability.fromJson(ability)).toList());
  }

  static List<Stat> getStats(List<dynamic> stats) {
    return List<Stat>.from(stats.map((stat) => Stat.fromJson(stat))).toList();
  }
}
