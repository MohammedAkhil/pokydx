import 'dart:core';

class Pokemon {
  Pokemon({this.name, this.id, this.image, this.type, this.url, this.height, this.weight});

  final String name;
  final int id;
  final String image;
  final List<int> type;
  final String url;
  final int height;
  final int weight;


  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'],
      id: json['id'],
      image: json['sprites']['front_default'],
      height: json['height'],
      weight: json['weight']
    );
  }

  factory Pokemon.fromUrlJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'],
      url: json['url'],
      id: json['id'],
      image: '',
      type: [],
    );
  }
}