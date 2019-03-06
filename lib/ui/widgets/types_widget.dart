import 'package:flutter/material.dart';
import '../../data/types.dart';

class TypesWidget extends StatelessWidget {

  final List<String> types;

  const TypesWidget({Key key, this.types}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: pokeTypes(),
    );
  }

  Widget pokeTypes() {
    var widgets = List<Widget>();

    for (int i=0; i< types.length; i++) {
      Widget typeWidget;

      if (i % 2 != 0) {
        widgets.add(SizedBox(width: 16,));
      }
      typeWidget = getTypeWidget(types[i]);
      widgets.add(typeWidget);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widgets,
    );
  }

  Widget getTypeWidget(String type) {
    return Chip(
      labelPadding: EdgeInsets.only(left: 16, right: 16, top: 2, bottom: 2),
      label: Text(
        type,
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
      backgroundColor: getColorType(type),
    );
  }

  Color getColorType(String type) {
    String hexColor = '0XFF' + typeColorCodes[type];
    return Color(int.parse(hexColor));
  }

}
