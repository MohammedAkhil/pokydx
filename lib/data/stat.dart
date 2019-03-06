import 'dart:core';

class Stat {
  final int baseStat;
  final int effort;
  final String name;

  Stat({this.baseStat, this.effort, this.name});

  factory Stat.fromJson(Map<String, dynamic> json) {
    return Stat(
        baseStat: json['base_stat'],
        effort: json['effort'],
        name: json['stat']['name']);
  }
}
