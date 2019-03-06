import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {

  final String text;
  final double textSize;
  final Color color;
  final bool isUnderline;
  final bool textAlign;

  const TextWidget({
    Key key,
    this.text,
    this.textSize = 24,
    this.color = Colors.black,
    this.isUnderline = false,
    this.textAlign = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return textWidget();
  }

  Widget textWidget() {
    return Text(
      text,
      textAlign: textAlign ? TextAlign.justify : null,
      style: TextStyle(
        fontSize: textSize,
        decoration: isUnderline ? TextDecoration.underline : null,
        color: color,

      ),
    );
  }
}
