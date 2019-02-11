import 'package:flutter/foundation.dart';
import './widgets/list.dart';
import '../data/Pokemon.dart';
import 'pokeStats.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int offset = 0;
  bool isLoading = false;
  String url = 'https://pokeapi.co/api/v2/pokemon/';
  ScrollController controller;
  var pokeList = List<Pokemon>();

  @override
  void initState() {
    super.initState();
    fetchAllPokemon(url);
    controller = new ScrollController()..addListener(_scrollListener);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Center(
          child: headerText(),
        ),
      ),      
      body: Scrollbar(
        child: PokeList(list: pokeList, onTapPokemon: onTapPokemon, controller: controller),
      ),
    );
  }


  Widget headerText() {
    return Text(
      'Pokedex',
      style: TextStyle(
        color: Colors.redAccent,
        fontSize: 32
      )
    ); 
  }

  void _scrollListener() {
    if (controller.position.extentAfter < 200 && offset < 160 && isLoading == false) {
      print('loading');
      fetchAllPokemon(this.url);
    }
  }

  void onTapPokemon(Pokemon pokemon) {
    Future<Pokemon> futurePokemon = fetchPokemon(pokemon.url);
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => PokeStats(futurePokemon: futurePokemon)
    ));
  }

  void fetchAllPokemon(url) async {
    var newList = List<Pokemon>();
    isLoading = true;
    final response = await http.get(url);

    print(response);
    if (response.statusCode == 200) {
      this.url = json.decode(response.body)['next'];
      json.decode(response.body)['results'].forEach((item)  {
        Pokemon pokemon = Pokemon.fromUrlJson(item);
        newList.add(pokemon);
      });
      setState(() {
        this.pokeList.addAll(newList);
        offset+=20;
        isLoading = false;
      });
    } else {
      throw Exception("Failed response.");
    }
  }

  Future<Pokemon> fetchPokemon(url) async {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return Pokemon.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed response.");
    }
  }
}
