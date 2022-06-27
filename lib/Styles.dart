
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
    ),
    priceLargeStyle = TextStyle(
      fontSize: Config.textLargeSize, color: Config.primaryColor,
      fontWeight: FontWeight.bold,
    );

  ///text
  static TextStyle textCardStyle = TextStyle(
    fontSize: Config.textMediumSize, color: Config.titleColor,
    fontWeight: FontWeight.bold,
  ),
    textLabelStyle = TextStyle(
      fontSize: Config.textMediumSize, color: Config.textColor,
  ),
    priceMediumStyle = TextStyle(
      fontSize: Config.textMediumSize, color: Config.primaryColor,
      fontWeight: FontWeight.bold,
    ),
    textMediumStyle = TextStyle(
      fontSize: Config.textMediumSize, color: Config.textColorOnPrimary,
      fontWeight: FontWeight.bold,
    ),
    textSmallStyle = TextStyle(
      fontSize: Config.textSmallSize, color: Config.textColorOnPrimary,
    );
}
