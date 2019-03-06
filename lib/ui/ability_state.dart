import 'package:Pokydx/data/abilitiy.dart';
import 'package:flutter/material.dart';

class AbilityWidget extends StatefulWidget {
  final String url;

  const AbilityWidget({Key key, this.url}) : super(key: key);
  
  @override
  _AbilityWidgetState createState() => _AbilityWidgetState();
}

class _AbilityWidgetState extends State<AbilityWidget> {

  Ability _ability;

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void initState() {
    super.initState();
    if (_ability == null) {
      getDetailedAbility(widget.url);
    }
  }

  @override
  AbilityWidget get widget => super.widget;
  
  Future<void> getDetailedAbility(String url) {
    
  }
}
