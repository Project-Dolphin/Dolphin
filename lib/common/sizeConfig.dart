import 'package:flutter/widgets.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;
  static double _safeAreaHorizontal;
  static double _safeAreaVertical;
  static double safeBlockHorizontal;
  static double safeBlockVertical;

  static double sizeByWidth(double size) {
    return (size / 3.75) * blockSizeHorizontal;
  }

  static double sizeByHeight(double size) {
    return (size / 8.12) * blockSizeVertical;
  }

  Future<void> init(BuildContext context) async {
    _mediaQueryData = MediaQuery.of(context);
    if (_mediaQueryData.size.width > 0) {
      screenWidth = _mediaQueryData.size.width;
      screenHeight = _mediaQueryData.size.height;
      blockSizeHorizontal = screenWidth / 100;
      blockSizeVertical = screenHeight / 100;
      _safeAreaHorizontal =
          _mediaQueryData.padding.left + _mediaQueryData.padding.right;
      _safeAreaVertical =
          _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
      safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
      safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
    } else {
      await Future.delayed(Duration(milliseconds: 100));
      return await init(context);
    }
  }
}
