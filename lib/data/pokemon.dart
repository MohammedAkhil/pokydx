import 'dart:core';

import 'package:Pokydx/utils/string.dart';

import '../data/ability_data.dart';
import '../data/stat.dart';

class Pokemon {
  Pokemon({
    this.name,
    this.id,
    this.speciesId,
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
    this.isLegendary,
    this.classification,
    this.shape,
    this.baseExperience,
    this.growthRate,
    this.hatchCounter,
    this.hasGenderDifferences,
    this.genderRate,
    this.isBaby,
  });

  final String name;
  final int id;
  final int speciesId;
  final String image;
  final List<String> type;
  final List<Ability> abilities;
  final String url;
  final int height;
  final int weight;
  final String description;
  final List<Stat> stats;
  final int baseExperience;
  final String color;
  final String generation;
  final int baseHappiness;
  final int captureRate;
  final String habitat;
  final bool isLegendary;
  final String classification;
  final String shape;
  final String growthRate;
  final int hatchCounter;
  final bool hasGenderDifferences;
  final int genderRate;
  final bool isBaby;

  factory Pokemon.fromJson(
      Map<String, dynamic> json, Map<String, dynamic> speciesJson, String imageUrl) {
    return Pokemon(
        name: json['name'],
        id: json['id'],
        image: imageUrl != null ? imageUrl : json['sprites']['front_default'],
        height: json['height'],
        weight: json['weight'],
        type: Pokemon.getTypes(json['types']),
        abilities: Pokemon.getAbilities(json['abilities']),
        baseExperience: json['base_experience'],
        description: getEnglishDescription(speciesJson),
        stats: getStats(json['stats']),
        color: getColor(speciesJson),
        generation: getGeneration(speciesJson),
        habitat: getHabitat(speciesJson),
        captureRate: getCaptureRate(speciesJson),
        baseHappiness: getBaseHappiness(speciesJson),
        classification: getClassification(speciesJson["genera"]),
        shape: getShape(speciesJson),
        growthRate: speciesJson['growth_rate']['name'],
        hatchCounter: speciesJson['hatch_counter'],
        hasGenderDifferences: speciesJson['has_gender_differences'],
        genderRate: speciesJson['gender_rate'],
        isBaby: speciesJson['is_baby']);
  }

  factory Pokemon.fromAbilityJson(Map<String, dynamic> json) {
    return Pokemon(name: json['pokemon']['name'], url: json['pokemon']['url']);
  }

  factory Pokemon.fromUrlJson(Map<String, dynamic> json) {
    return Pokemon(
        name: json['name'],
        id: json['id'],
        speciesId: json['species_id'],
        generation: json['generation_id'].toString(),
        type: json['type'].split(','),
        isLegendary: false);
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

  static String getEnglishDescription(Map<String, dynamic> body) {
    int position =
        body['flavor_text_entries'][0]['language']["name"] == "ja" ? 1 : 2;
    return StringUtils.removeNewLine(
        body['flavor_text_entries'][position]['flavor_text']);
  }

  static String getColor(Map<String, dynamic> body) {
    return body['color']['name'];
  }

  static String getGeneration(Map<String, dynamic> body) {
    return body['generation']['name'];
  }

  static int getBaseHappiness(Map<String, dynamic> body) {
    return body['base_happiness'];
  }

  static int getCaptureRate(Map<String, dynamic> body) {
    return body['capture_rate'];
  }

  static String getHabitat(Map<String, dynamic> body) {
    return body['habitat'] != null ? body['habitat']['name'] : '';
  }

  static String getClassification(List<dynamic> body) {
    return body[2]['genus'];
  }

  static String getShape(Map<String, dynamic> body) {
    return body["shape"]["name"];
  }
}
