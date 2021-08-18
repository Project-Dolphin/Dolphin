import 'dart:ui';
import 'package:oceanview/common/text/textBox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oceanview/common/sizeConfig.dart';

class Header extends StatelessWidget {
  final double maxHeight;
  final double minHeight;

  const Header({Key? key, required this.maxHeight, required this.minHeight})
      : super(key: key);

  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final expandRatio = _calculateExpandRatio(constraints);
        final animation = AlwaysStoppedAnimation(expandRatio);

        return Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              top: 0,
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: Tween(begin: 10.0, end: 0.0).evaluate(animation),
                    sigmaY: Tween(begin: 10.0, end: 0.0).evaluate(animation),
                  ),
                  child: Container(
                    color: Colors.transparent, //test
                    alignment: Alignment.center,
                    width: SizeConfig.screenWidth,
                    height: 50,
                  ),
                ),
              ), // to clip the container
            ),
            _buildTitle(animation),
          ],
        );
      },
    );
  }

  double _calculateExpandRatio(BoxConstraints constraints) {
    var expandRatio =
        (constraints.maxHeight - minHeight) / (maxHeight - minHeight);

    if (expandRatio > 1.0) expandRatio = 1.0;
    if (expandRatio < 0.0) expandRatio = 0.0;

    return expandRatio;
  }

  Align _buildTitle(Animation<double> animation) {
    return Align(
      alignment:
      AlignmentTween(begin: Alignment.center, end: Alignment.bottomLeft)
          .evaluate(animation),
      child: Container(
          margin: EdgeInsets.only(
            bottom: SizeConfig.sizeByHeight(14),
            left: SizeConfig.sizeByHeight(14),
          ),
          child: TextBox(
              '식단',
              Tween<double>(
                  begin: SizeConfig.sizeByHeight(18),
                  end: SizeConfig.sizeByHeight(24))
                  .evaluate(animation),
              FontWeight.w800,
              Color(0xFF353B45))
      ),
    );
  }
}