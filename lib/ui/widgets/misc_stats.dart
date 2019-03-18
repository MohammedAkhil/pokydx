import 'package:Pokydx/data/pokemon.dart';
import 'package:flutter/material.dart';

class MiscStats extends StatelessWidget {
  final Pokemon pokemon;

  const MiscStats({Key key, this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return table();
  }

  Widget table() {
    return Container(
      child: Container(
        margin: EdgeInsets.only(bottom: 0, top: 32, left: 24, right: 0),
        child: Table(
          children: tableRow(),
        ),
      ),
    );
  }

  List<TableRow> tableRow() {
    Map<String, String> data = {
      "base experience": pokemon.baseExperience.toString(),
      "hatch counter": pokemon.hatchCounter.toString(),
      "gender rate": pokemon.genderRate.toString(),
      "baby": pokemon.isBaby ? "yes" : "no",
      "gender difference": pokemon.hasGenderDifferences ? "yes" : "no",
    };

    var cells = List<TableRow>();

    data.forEach((title, value) {
      cells.add(TableRow(children: [
        TableCell(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 24, top: 8, bottom: 8),
              child: Text(
                title,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8, left: 64),
            child: Center(child: Text(value, style: TextStyle(fontSize: 16))),
          ),
        )
      ]));
    });

    return cells;
  }
}
