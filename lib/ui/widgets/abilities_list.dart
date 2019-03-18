import 'package:Pokydx/ui/ability_state.dart';
import 'package:flutter/material.dart';

import '../../data/ability_data.dart';

class AbilitiesWidget extends StatelessWidget {
  final List<Ability> abilities;

  AbilitiesWidget({this.abilities});

  @override
  Widget build(BuildContext context) {
    return list(context);
  }

  Widget list(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: <Widget>[
          title(context),
          Container(
            height: 100,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return cardView(abilities[index], context);
              },
              itemCount: abilities.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
            ),
          ),
        ],
      ),
    );
  }

  Widget cardView(Ability ability, BuildContext context) {
    return InkWell(
      onTap: () => moveToDetailedScreen(ability, context),
      child: Container(
        width: 230,
        child: Card(
          elevation: 0,
          child: cardItem(ability, context),
        ),
        margin: EdgeInsets.only(left: 8, right: 0),
      ),
    );
  }

  Widget title(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 0),
      child: Center(
        child: Text(
          'abilities',
          style: Theme.of(context).textTheme.title,
        ),
      ),
    );
  }

  void moveToDetailedScreen(Ability ability, BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AbilityUI(
                  url: ability.url,
                )));
  }

  Widget cardItem(Ability ability, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 8, top: 18, bottom: 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            ability.name,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
          ),
          miscInfo(ability, context)
        ],
      ),
    );
  }

  Widget miscInfo(Ability ability, BuildContext context) {
    String isHidden = ability.isHidden ? 'Hidden' : 'Not Hidden';
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          'slot - ' + ability.slot.toString(),
          style: Theme.of(context).textTheme.body2,
        ),
        Spacer(),
        Text(
          isHidden,
          style: Theme.of(context).textTheme.body2,
        ),
        SizedBox(
          width: 8,
        )
      ],
    );
  }
}
