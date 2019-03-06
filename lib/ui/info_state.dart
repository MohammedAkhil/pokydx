import 'package:flutter/material.dart';

import '../data/pokemon.dart';

class Info extends StatefulWidget {
  final Future<Pokemon> future;
  final int id;

  const Info({Key key, this.future, this.id}) : super(key: key);

  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
