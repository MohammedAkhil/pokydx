import 'dart:async';
import 'dart:convert';

import 'package:Pokydx/data/pokemon.dart';
import 'package:Pokydx/ui/info_state.dart';
import 'package:Pokydx/ui/widgets/grid_pokemon.dart';
import 'package:Pokydx/ui/widgets/list_pokemon.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class World extends StatefulWidget {
  @override
  _WorldState createState() => _WorldState();
}

class _WorldState extends State<World> {
  int offset = 0;
  bool isLoading = false;
  String url = "api.data.world";
  String endPoint = 'v0/sql/akhil05/pokydx/';
  ScrollController controller;
  var pokeList = List<Pokemon>();
  double elevation = 5.0;
  bool isGrid = true;

  @override
  void initState() {
    super.initState();
    fetchAllPokemon();
    controller = new ScrollController()..addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: elevation,
        centerTitle: true,
        title: headerText(),
        leading: IconButton(
            icon: Icon(Icons.search), color: Colors.black, onPressed: null),
        actions: <Widget>[
          IconButton(
              icon: isGrid ? Icon(Icons.list) : Icon(Icons.grid_on),
              onPressed: _switchListType)
        ],
      ),
      body: list(),
    );
  }

  Widget headerText() {
    return Text('Pokedex', style: TextStyle(fontSize: 24));
  }

  Widget list() {
    return Scrollbar(
      child: NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            if (scrollNotification is ScrollStartNotification) {
              _onStartScroll(scrollNotification.metrics);
            } else if (scrollNotification is ScrollEndNotification) {
              _onEndScroll(scrollNotification.metrics);
            }
          },
          child: isGrid
              ? GridPokemon(
                  controller: controller,
                  onTapPokemon: onTapPokemon,
                  pokemon: pokeList,
                )
              : PokeList(
                  list: pokeList,
                  onTapPokemon: onTapPokemon,
                  controller: controller)),
    );
  }

  _switchListType() {
    setState(() {
      isGrid = !isGrid;
    });
  }

  _onStartScroll(ScrollMetrics metrics) {
    setState(() {
      elevation = 5.0;
    });
  }

  _onEndScroll(ScrollMetrics metrics) {
    setState(() {
      elevation = 0.0;
    });
  }

  void _scrollListener() {
    if (controller.position.extentAfter < 300 &&
        offset < 720 &&
        isLoading == false) {
      fetchAllPokemon();
    }
  }

  void onTapPokemon(Pokemon pokemon) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Info(
                  id: pokemon.id,
                )));
  }

  Future<void> fetchAllPokemon() async {
    var newList = List<Pokemon>();
    isLoading = true;

    String query = '''
    SELECT column_a AS id, column_b AS name, CONCAT(column_c, COALESCE(`column_d`, '')) AS type, column_l AS generation, column_m as is_legendary
    FROM pokemon
    WHERE column_b NOT LIKE '%Mega %' AND column_b NOT LIKE '%Primal %'
    ORDER BY column_a
    LIMIT 400
    ''';
    var queryParams = {'query': query};
    var uri = Uri.https(url, endPoint, queryParams);
    Map<String, String> headers = {
      "Authorization":
          "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJwcm9kLXVzZXItY2xpZW50OmFraGlsMDUiLCJpc3MiOiJhZ2VudDpha2hpbDA1OjowODczYjExZS00MzY0LTQwYzQtYTQ2Mi1kMjQ0NDM4ZmNmZGYiLCJpYXQiOjE1NTAyMjcyNTksInJvbGUiOlsidXNlcl9hcGlfcmVhZCIsInVzZXJfYXBpX3dyaXRlIl0sImdlbmVyYWwtcHVycG9zZSI6dHJ1ZSwic2FtbCI6e319.H6dmkm2wN6HG6jgnAVOwSTx33Lqy1oc46_I1TG8K855hRDGPxWn66jj5Kabq5-Kn2TIOEl_6j7LQGawfvzhHUg",
      "Content-type": "application/json"
    };
    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      body.forEach((item) {
        Pokemon pokemon = Pokemon.fromDataWorld(item);
        newList.add(pokemon);
      });

      if (this.mounted) {
        setState(() {
          this.pokeList.addAll(newList);
          // offset += 20;
          isLoading = false;
        });
      }
    } else {
      throw Exception("Failed response.");
    }
  }
}
