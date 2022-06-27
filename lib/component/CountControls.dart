
import 'package:flutter/material.dart';

import '../Config.dart';
import '../Styles.dart';
import 'GradientButton.dart';

class CountControls extends StatelessWidget {
  const CountControls({
    Key? key,
    required this.count,
    required this.decrement,
    required this.increment,
    this.isDecrementActive = true,
    this.isIncrementActive = true,
  }) : super(key: key);

  final int count;
  final Function() decrement;
  final Function() increment;
  final bool isDecrementActive;
  final bool isIncrementActive;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        GradientButton(
          isActive: isDecrementActive,
          onPressed: () {
            if (isDecrementActive) {
              decrement();
            }
          },
          child: SizedBox(
            width: Config.iconSize, height: Config.iconSize,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Text('—', style: TextStyle(
                  fontSize: Config.textMediumSize,
                  color: isDecrementActive
                      ? Config.textColorOnPrimary
                      : Config.primaryColor,
                ),),
              ),
            ),
          ),
        ),

        SizedBox(
          width: Config.iconSize, height: Config.iconSize,
          child: Center(
            child: Text('$count', style: Styles.textCardStyle,),
          ),
        ),

        GradientButton(
          isActive: isIncrementActive,
          onPressed: () {
            if (isIncrementActive) {
              increment();
            }
          },
          child: SizedBox(
            width: Config.iconSize, height: Config.iconSize,
            child: Center(
              child: Text('+', style: TextStyle(
                fontSize: Config.textMediumSize,
                color: isIncrementActive
                    ? Config.textColorOnPrimary
                    : Config.primaryColor,
              ),),
            ),
          ),
        ),
      ],
    );
  }
}
