import 'dart:ui';

import 'package:flutter/material.dart';

class GlassMorphism extends StatelessWidget {
  GlassMorphism({this.widget, this.width, this.height, Key? key})
      : super(key: key);

  final Widget? widget;
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 16.0,
            sigmaY: 16.0,
          ),
          child: Container(
            decoration: BoxDecoration(
                gradient: new LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.5),
                      Colors.white.withOpacity(0.3),
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 1.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
                borderRadius: BorderRadius.circular(10.0),
                border:
                    Border.all(width: 1, color: Colors.white.withOpacity(0.8))),
            child: widget,
          ),
        ),
      ),
    );
  }
}
