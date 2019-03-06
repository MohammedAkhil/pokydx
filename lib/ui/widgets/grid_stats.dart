import 'package:Pokydx/data/stat.dart';
import 'package:Pokydx/utils/color.dart';
import 'package:flutter/material.dart';

class GridAbilities extends StatelessWidget {
  final List<Stat> stats;
  final String color;

  const GridAbilities({Key key, this.stats, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body(context);
  }

  Widget body(BuildContext context) {
    Color gridColor = getColorFromHex(colourNameToHex(color));

    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, childAspectRatio: 3 / 2),
      delegate: SliverChildListDelegate(
        List<Widget>.generate(6, (index) {
          return Container(color: gridColor, child: gridItem(stats[index]));
        }),
      ),
    );
  }

  Widget gridItem(Stat stat) {
    Color bgColor = getColorFromHex(colourNameToHex(color));
    Color statTextColor = getTextColor(bgColor);

    return Padding(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(stat.baseStat.toString(),
                style: TextStyle(
                    fontSize: 16,
                    color: statTextColor,
                    fontWeight: FontWeight.w500)),
          ),
          Center(
            child: Text(stat.name.toUpperCase(),
                style: TextStyle(
                    fontSize: 10,
                    color: statTextColor,
                    fontWeight: FontWeight.w600)),
          ),
        ],
      ),
      padding: EdgeInsets.all(4),
    );
  }

  Color getColorFromHex(String hex) {
    hex = hex.replaceAll('#', '');
    String hexColor = '0XFF' + hex;
    return Color(int.parse(hexColor));
  }
}
