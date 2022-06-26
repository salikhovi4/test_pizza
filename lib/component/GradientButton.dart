
import 'package:flutter/material.dart';

import 'Gradient.dart';
import '../Config.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.borderRadius,
    this.isActive = true,
  }) : super(key: key);

  final bool isActive;
  final Widget child;
  final double? borderRadius;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: Duration(milliseconds: Config.animDuration),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? Config.smallBorderRadius),
          gradient: isActive ? CustomGradient() : null,
          color: isActive ? null : Config.primaryLightColor.withOpacity(.3),
        ),
        child: child,
      ),
    );
  }
}
