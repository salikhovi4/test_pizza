
import 'package:flutter/material.dart';

import '../Config.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    this.title,
    this.leading,
    this.actions,
  }) : super(key: key);

  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    List<Widget> childWidgets = [];
    if (leading != null) {
      childWidgets.add(leading!);
      childWidgets.add(SizedBox(width: Config.mediumPadding,));
    }
    if (title != null) {
      childWidgets.add(Expanded(
        child: Padding(
          padding: EdgeInsets.only(right: Config.mediumPadding,),
          child: title!,
        ),
      ));
    }
    if (actions != null) {
      childWidgets.addAll(actions!);
    }

    return Material(
      color: Colors.transparent,
      child: SizedBox(
        height: kToolbarHeight,
        child: Row(
          children: childWidgets,
        ),
      ),
    );
  }
}
