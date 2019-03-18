import 'dart:async';
import 'dart:convert';

import 'package:Pokydx/data/ability_data.dart';
import 'package:Pokydx/ui/widgets/ability.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AbilityUI extends StatefulWidget {
  final String url;

  const AbilityUI({Key key, this.url}) : super(key: key);

  @override
  _AbilityUIState createState() => _AbilityUIState();
}

class _AbilityUIState extends State<AbilityUI> {
  Ability _ability;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: _ability != null
          ? AbilityWidget(
              ability: _ability,
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (_ability == null) {
      getDetailedAbility(widget.url);
    }
  }

  @override
  AbilityUI get widget => super.widget;

  Future<void> getDetailedAbility(String url) async {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      Ability ability = Ability.fromDetailedJson(json.decode(response.body));
      if (this.mounted) {
        setState(() {
          _ability = ability;
        });
      }
    }
  }
}
