import 'package:flutter/material.dart';
import 'package:oceanview/common/sizeConfig.dart';

class TextBox extends StatelessWidget {
  const TextBox(this.text, this.fontSize, this.fontWeight, this.color,
      {Key? key})
      : super(key: key);

  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          text,
          style: TextStyle(
            color: color,
            fontWeight: fontWeight,
            fontSize: SizeConfig.sizeByHeight(fontSize),
          ),
        ));
  }
}
