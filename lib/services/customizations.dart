import 'package:flutter/material.dart';

// https://gist.github.com/mjohnsullivan/117e7fffd283c34c5078a93330504b9f
class GradientMask extends StatelessWidget {
  GradientMask({this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => RadialGradient(
        center: Alignment.center,
        radius: 0.5,
        colors: [Colors.green, Color(0xFFFF9933)],
        tileMode: TileMode.mirror,
      ).createShader(bounds),
      child: child,
    );
  }
}
