import 'package:flutter/material.dart';
import 'package:oceanview/common/sizeConfig.dart';

class TextBox extends StatelessWidget {
  const TextBox(this.text, this.fontSize, this.fontWeight, this.color,
      {this.textAlign, this.maxLines, Key? key})
      : super(key: key);

  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final TextAlign? textAlign;
  final int? maxLines;

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
            fontSize: fontSize * 0.9,
          ),
          textAlign: textAlign != null ? textAlign : TextAlign.start,
          maxLines: maxLines,
        ));
  }
}
