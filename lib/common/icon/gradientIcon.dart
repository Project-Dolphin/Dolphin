import 'package:flutter/material.dart';

class GradientIcon extends StatelessWidget {
  GradientIcon(
    this.icon,
    this.gradient,
  );

  final Widget icon;

  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      child: SizedBox(
        child: icon,
      ),
      shaderCallback: (Rect bounds) {
        return gradient.createShader(bounds);
      },
      blendMode: BlendMode.srcATop,
    );
  }
}
