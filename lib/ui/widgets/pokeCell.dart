import 'package:flutter/material.dart';

class PokeCell extends StatelessWidget {
  PokeCell({Key key, this.title, this.number}) : super(key: key);

  final String title;
  final int number;

  @override
  Widget build(BuildContext context) {
    return padder(
        Container(
          child: Row(
            children: <Widget>[ buildText(getPokenumber()), SizedBox(width: 24), buildText(title)],
          ),
        ),
        16);
  }

  Widget buildText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 28,
        color: Colors.black
      ),
    );
  }

  Widget padder(Widget widget, double value) {
    return Padding(
      padding: EdgeInsets.all(value),
      child: widget,
    );
  }

  String getPokenumber() {
    int preZeroCount = 3 - number.toString().length;
    String preZeroes;
    switch (preZeroCount) {
      case 2:
        preZeroes = "00";
        break;
      case 1:
        preZeroes = "0";
        break;
      default:
        preZeroes = "";
    }
    return "#$preZeroes$number";

  }
}
