import 'package:flutter/material.dart';

class HeightWeight extends StatelessWidget {
  final int height;
  final int weight;

  const HeightWeight({Key key, this.height, this.weight}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 24, top: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildSizeProperty('height', height.toString(), context),
            SizedBox(
              width: 20,
            ),
            buildSizeProperty('weight', weight.toString(), context),
          ],
        ),
      );

  Widget buildSizeProperty(
      String title, String property, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          property,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.body2,
        ),
      ],
    );
  }
}
