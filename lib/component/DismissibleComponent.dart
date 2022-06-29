
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pizza/Config.dart';

class DismissibleComponent extends StatelessWidget {
  const DismissibleComponent({
    Key? key,
    required this.child,
    required this.onDismissed,
    required this.borderRadius,
  }) : super(key: key);

  final double borderRadius;
  final Function(DismissDirection) onDismissed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    Widget trashIcon = Padding(
      padding: EdgeInsets.symmetric(horizontal: Config.mediumPadding / 2),
      child: Icon(Icons.delete, size: Config.iconSize, color: Config.textColorOnPrimary,),
    );

    return Dismissible(
      key: ValueKey<int>(Random().nextInt(100)),
      onDismissed: onDismissed,
      child: child,
      background: Padding(
        padding: EdgeInsets.all(Config.mediumPadding / 4),
        child: Container(
          decoration: BoxDecoration(
            color: Config.primaryDarkColor,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              trashIcon,

              trashIcon,
            ],
          ),
        ),
      ),
    );
  }
}
