import 'package:flutter/material.dart';

import '../../data/abilitiy.dart';

class AbilitiesWidget extends StatelessWidget {
  final List<Ability> abilities;

  AbilitiesWidget({this.abilities});

  @override
  Widget build(BuildContext context) {
    return list();
  }

  Widget list() {
    return SliverToBoxAdapter(
      child: Container(
        height: 110,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return cardView(abilities[index]);
          },
          itemCount: abilities.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }

  Widget cardView(Ability ability) {
    return Container(
      width: 240,
      child: Card(
        color: Colors.black,
        child: cardItem(ability),
        elevation: 5,
      ),
      margin: EdgeInsets.only(left: 8, right: 0),
    );
  }

  Widget cardItem(Ability ability) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 8, top: 24, bottom: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            ability.name,
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.w500, color: Colors.white),
          ),
          miscInfo(ability)
        ],
      ),
    );
  }

  Widget miscInfo(Ability ability) {
    String isHidden = ability.isHidden ? 'Hidden' : 'Not Hidden';
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          'slot - ' + ability.slot.toString(),
          style: TextStyle(
              fontSize: 16, color: Colors.white70, fontWeight: FontWeight.w500),
        ),
        Spacer(),
        Text(
          isHidden,
          style: TextStyle(
              fontSize: 16, color: Colors.white70, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          width: 8,
        )
      ],
    );
  }
}
