import 'dart:async';
import 'dart:convert';

import 'package:Pokydx/data/pokemon.dart';
import 'package:Pokydx/language.dart';
import 'package:Pokydx/ui/info_state.dart';
import 'package:Pokydx/ui/search.dart';
import 'package:Pokydx/ui/widgets/grid_pokemon.dart';
import 'package:Pokydx/ui/widgets/list_pokemon.dart';
import 'package:Pokydx/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  final Function modifyTheme;

  const Home({Key key, this.modifyTheme}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int offset = 30;
  bool isLoading = false;
  String url = "api.data.world";
  String endPoint = 'v0/sql/akhil05/pokydx/';
  ScrollController controller;
  var pokeList = List<Pokemon>();
  double elevation = 5.0;
  bool isGrid = false;
  bool isSearch = false;

  @override
  void initState() {
    super.initState();
    fetchAllPokemon();

    controller = new ScrollController()..addListener(_scrollListener);
  }

  @override
  Home get widget => super.widget;
  String lan = 'en';
  @override
  Widget build(BuildContext context) {
    var appLanguage = Provider.of<AppLanguage>(context);
    return Scaffold(
      appBar: mainAppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          lan == 'en'
              ? appLanguage.changeLanguage(Locale("sp"))
              : appLanguage.changeLanguage(Locale("an"))
        },
        child: Text('Spanish'),
      ),
      body: Stack(
        children: <Widget>[
          list(),
          isLoading
              ? Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Center(child: CircularProgressIndicator()),
                )
              : Container()
        ],
      ),
    );
  }

  Widget headerText() {
    return Text(AppLocalizations.of(context).translate('Pokedex'),
        style: TextStyle(fontSize: 24));
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
        offset < 960 &&
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
                  speciesId: pokemon.speciesId,
                  name: pokemon.name,
                )));
  }

  Future<void> fetchAllPokemon() async {
    var newList = List<Pokemon>();
    isLoading = true;

    // TODO optimize query

    String query = '''
    SELECT id, name, species_id, type, generation_id
    FROM pokedex
    ORDER BY id
    LIMIT ${offset.toString()}
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
          offset += 30;
          isLoading = false;
        });
      }
    } else {
      throw Exception("Failed response.");
    }
  }

  Widget mainAppBar() {
    return AppBar(
      elevation: elevation,
      centerTitle: true,
      title: headerText(),
      leading: IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Search()));
          }),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.brightness_low),
            onPressed: () {
              widget.modifyTheme();
            }),
        IconButton(
            icon: isGrid ? Icon(Icons.list) : Icon(Icons.grid_on),
            onPressed: _switchListType),
      ],
    );
  }
}
