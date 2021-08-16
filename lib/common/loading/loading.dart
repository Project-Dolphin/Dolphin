import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:oceanview/common/sizeConfig.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitThreeBounce(
      color: Color(0xFF0081FF),
      size: SizeConfig.sizeByHeight(20),
    );
  }
}
