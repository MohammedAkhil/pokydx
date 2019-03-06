import 'dart:async';
import 'dart:convert';

import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './widgets/info.dart';
import '../data/pokemon.dart';

class Info extends StatefulWidget {
  final String name;
  final int id;
  final int speciesId;

  const Info({Key key, this.id, this.speciesId, this.name}) : super(key: key);

  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  Pokemon _pokemon;
  AudioPlayer audioPlayer;

  static const String BASE_IMG_URL =
      'https://veekun.com/dex/media/pokemon/sugimori/';

  static const String BASE_CRY_URL =
      'https://veekun.com/dex/media/pokemon/cries/';

  @override
  Info get widget => super.widget;

  @override
  void initState() {
    super.initState();
    if (_pokemon == null) {
      audioPlayer = AudioPlayer();
      getData(getPokemonUrl());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pokemon != null
            ? InfoWidget(
                pokemon: _pokemon,
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }

  Future<Map<String, dynamic>> fetchPokemon(url) async {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed response.");
    }
  }

  Future<Map<String, dynamic>> fetchPokemonSpecies() async {
    final response = await http.get(getPokemonSpeciesUrl());
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed response.");
    }
  }

  void getData(String url) {
    Future.wait([fetchPokemon(url), fetchPokemonSpecies()])
        .then((responses) => Pokemon.fromJson(
            responses[0], responses[1], getImageUrl(widget.id)))
        .then((pokemon) => updateState(pokemon))
        .catchError((error) => throw Exception("Failed"));
  }

  Future<void> play(url) async {
    await audioPlayer.play(url);
  }

  String getPokemonUrl() {
    return "https://pokeapi.co/api/v2/pokemon/${widget.id.toString()}";
  }

  String getPokemonSpeciesUrl() {
    return "https://pokeapi.co/api/v2/pokemon-species/${widget.speciesId.toString()}";
  }

  void updateState(Pokemon pokemon) {
    if (this.mounted) {
      play(BASE_CRY_URL + pokemon.id.toString() + '.ogg');
      setState(() {
        _pokemon = pokemon;
      });
    }
  }

  String getImageUrl(int id) {
    if (id <= 809) {
      return BASE_IMG_URL + id.toString() + '.png';
    }

    String baseUrl =
        "https://cdn.jsdelivr.net/gh/MohammedAkhil/sprites/sprites/pokemon/";
    if (id == 10128 || id == 10129 || id == 10153 || id == 10154) {
      return baseUrl + widget.speciesId.toString() + '.png';
    }

    String imageId = id <= 10090
        ? widget.id.toString()
        : widget.speciesId.toString() + getSubSpeciesName(widget.name);
    return baseUrl + imageId + '.png';
  }

  String getSubSpeciesName(String fullName) {
    return fullName.substring(
        fullName.indexOf(RegExp(r'-totem').stringMatch(fullName).toString()));
  }
}
