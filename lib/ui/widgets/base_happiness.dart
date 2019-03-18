import 'package:Pokydx/utils/constants.dart';
import 'package:flutter/material.dart';

class BaseHappiness extends StatelessWidget {
  final int baseHappiness;

  const BaseHappiness({Key key, this.baseHappiness}) : super(key: key);

  @override
  Widget build(BuildContext context) => Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4))),
        elevation: 5.0,
        margin: EdgeInsets.all(12),
        color: Colors.teal,
        child: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            children: <Widget>[
              Text(
                'Base Happiness',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 24),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                baseHappinessDescription,
                textAlign: TextAlign.justify,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                baseHappiness.toString(),
                style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
      );
}
