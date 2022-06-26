
import 'package:flutter/material.dart';

import 'Config.dart';

class Styles {

  ///title
  static TextStyle titleStyle = TextStyle(
      fontSize: Config.textLargeSize, color: Config.titleColor,
  ),
    saveButtonStyle = TextStyle(
      fontSize: Config.textMediumSize, color: Config.textColorOnPrimary,
      fontWeight: FontWeight.bold,
    ),
    titleBoldStyle = TextStyle(
      fontSize: Config.textLargeSize, color: Config.titleColor,
      fontWeight: FontWeight.bold,
    );

  ///text
  static TextStyle textAddingStyle = TextStyle(
    fontSize: Config.textMediumSize, color: Config.titleColor,
    fontWeight: FontWeight.bold,
  ),
    textLabelStyle = TextStyle(
    fontSize: Config.textMediumSize, color: Config.textColor,
  );
}
