import 'package:flutter/material.dart';
import 'package:oceanview/common/sizeConfig.dart';

class TextBox extends StatelessWidget {
  const TextBox(this.text, this.fontSize, this.fontWeight, this.color,
      {this.fontFamily = 'Noto Sans KR', Key? key})
      : super(key: key);

  final String text, fontFamily;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          text,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: color,
              fontWeight: fontWeight,
              fontSize: SizeConfig.sizeByHeight(fontSize),
              fontFamily: fontFamily),
        ));
  }
}
