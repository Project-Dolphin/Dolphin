import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:oceanview/common/sizeConfig.dart';

class Loading extends StatelessWidget {
  const Loading({Color? this.color, Key? key}) : super(key: key);

  final color;
  @override
  Widget build(BuildContext context) {
    return SpinKitThreeBounce(
      color: color != null ? color : Color(0xFF0081FF),
      size: SizeConfig.sizeByHeight(20),
    );
  }
}
