import 'dart:async';
import 'dart:convert';

import 'package:Pokydx/data/pokemon.dart';
import 'package:Pokydx/ui/info_state.dart';
import 'package:Pokydx/ui/widgets/list_pokemon.dart';
import 'package:Pokydx/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool isFirstLoad = true;
  bool isLoading = false;
  String url = "api.data.world";
  String endPoint = 'v0/sql/akhil05/pokydx/';
  var pokeList = List<Pokemon>();

  String search = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Stack(
        children: <Widget>[
          list(),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Center(
                child: isLoading ? CircularProgressIndicator() : Container()),
          )
        ],
      ),
    );
  }

  Widget appBar() {
    return AppBar(
      elevation: 0,
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          }),
      title: TextField(
        autofocus: true,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration.collapsed(
            hintText: 'search', hintStyle: TextStyle(fontSize: 20)),
        onSubmitted: (String query) async {
          search = query.toLowerCase();
          await fetchAllPokemon();
          search = '';
        },
      ),
    );
  }

  Widget list() {
    return pokeList.length > 0
        ? PokeList(
            list: pokeList,
            onTapPokemon: onTapPokemon,
          )
        : emptyPlaceholder();
  }

  Widget emptyPlaceholder() {
    String placeholder =
        isFirstLoad ? 'Search for any Pokemon' : 'No results found. try again';
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 64, 32, 8),
      child: Text(
        placeholder,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 40, fontWeight: FontWeight.w600, color: Colors.black38),
      ),
    );
  }

  void onTapPokemon(Pokemon pokemon) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Info(
                  id: pokemon.id,
                  speciesId: pokemon.speciesId,
                  name: pokemon.name,
                )));
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    // ignore: deprecated_member_use
    return double.parse(s, (e) => null) != null;
  }

  Future<void> fetchAllPokemon() async {
    var newList = List<Pokemon>();
    isLoading = true;
    String column;
    column = isNumeric(search) ? 'id' : 'name';
    String likeQuery = isNumeric(search) ? "$search" : "%$search%";

    // TODO optimize query

    String query = '''
    SELECT id, name, species_id, type, generation_id
    FROM pokedex
    WHERE  $column LIKE '$likeQuery'
    ORDER BY id
    ''';
    var queryParams = {'query': query};
    var uri = Uri.https(url, endPoint, queryParams);
    Map<String, String> headers = {
      "Authorization": "Bearer $authToken",
      "Content-type": "application/json"
    };
    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      body.forEach((item) {
        Pokemon pokemon = Pokemon.fromUrlJson(item);
        newList.add(pokemon);
      });

      if (this.mounted) {
        setState(() {
          this.pokeList.clear();
          this.pokeList.addAll(newList);
          isLoading = false;
          isFirstLoad = false;
        });
      }
    } else {
      throw Exception("Failed response.");
    }
  }
}
