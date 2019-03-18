import 'package:Pokydx/utils/constants.dart';
import 'package:flutter/material.dart';

class CaptureRate extends StatelessWidget {
  final int captureRate;

  const CaptureRate({Key key, this.captureRate}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.only(bottom: 12, top: 12, left: 2, right: 2),
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4))),
          elevation: 5.0,
          margin: EdgeInsets.all(12),
          color: Colors.indigo,
          child: Container(
            margin: EdgeInsets.all(24),
            child: Column(
              children: <Widget>[
                Container(
                  child: Text(
                    'Capture Rate',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 24,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  captureRateDescription,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/icons/ic-pokeball.png',
                      height: 50,
                    ),
                    SizedBox(
                      width: 24,
                    ),
                    Text(
                      captureRate.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 32,
                          color: Colors.white),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
}
