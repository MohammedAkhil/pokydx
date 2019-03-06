import 'package:flutter/material.dart';

import '../../data/types.dart';

class TypesWidget extends StatelessWidget {
  final List<String> types;
  final bool isSmall;

  const TypesWidget({Key key, this.types, this.isSmall: false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: pokeTypes(),
    );
  }

  Widget pokeTypes() {
    var widgets = List<Widget>();

    for (int i = 0; i < types.length; i++) {
      Widget typeWidget;

      if (i % 2 != 0) {
        widgets.add(SizedBox(
          width: isSmall ? 8 : 12,
        ));
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
    var x = isSmall
        ? EdgeInsets.only(left: 6, right: 6, top: 4, bottom: 4)
        : EdgeInsets.only(left: 8, right: 8, top: 6, bottom: 6);

    return Container(
      decoration: BoxDecoration(
          color: getColorType(type),
          borderRadius: BorderRadius.all(Radius.circular(4))),
      child: Padding(
        padding: x,
        child: Text(
          type,
          style: TextStyle(
            fontSize: isSmall ? 10 : 14,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Color getColorType(String type) {
    String hexColor = '0XFF' + typeColorCodes[type.toLowerCase()];
    return Color(int.parse(hexColor));
  }
}
