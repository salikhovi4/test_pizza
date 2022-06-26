
import 'package:flutter/material.dart';

import 'Gradient.dart';

class GradientMask extends StatelessWidget {
  const GradientMask({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) => CustomGradient().createShader(bounds),
      child: child,
    );
  }
}
