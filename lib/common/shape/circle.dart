import 'package:flutter/material.dart';
import 'package:oceanview/common/sizeConfig.dart';

Widget renderCirleWithShadow(double size) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: SizeConfig.sizeByWidth(10)),
    width: SizeConfig.sizeByHeight(size),
    height: SizeConfig.sizeByHeight(size),
    decoration: BoxDecoration(
        borderRadius:
            BorderRadius.all(Radius.circular(SizeConfig.sizeByHeight(11))),
        gradient: LinearGradient(
            colors: <Color>[
              Color(0xFF3199FF),
              Color(0xFF0081FF),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
        boxShadow: [
          BoxShadow(
              color: Color(0xffB4D5F1).withOpacity(0.7),
              offset: Offset(0, 3),
              blurRadius: 5,
              spreadRadius: 1)
        ]),
  );
}

Widget renderCircle(double size) {
  return Container(
      margin: EdgeInsets.only(right: SizeConfig.sizeByWidth(7)),
      width: SizeConfig.sizeByHeight(size),
      height: SizeConfig.sizeByHeight(size),
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.all(Radius.circular(SizeConfig.sizeByHeight(size))),
        gradient: LinearGradient(
            colors: <Color>[
              Color(0xFF3199FF),
              Color(0xFF0081FF),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ));
}
