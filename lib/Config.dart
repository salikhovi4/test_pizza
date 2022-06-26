
import 'package:flutter/material.dart';

class Config {

  ///Main style
  static const primaryColor = Color.fromRGBO(244, 63, 94, 1),
    primaryDarkColor = Color.fromRGBO(122, 32, 47, 1),
    primaryLightColor = Color.fromRGBO(250, 159, 175, 1);

  static Color shadowColor = Colors.black;

  ///Global components
  ///Text
  static Color textColorOnPrimary = Colors.white;
  static const Color textColor = Color.fromRGBO(57, 62, 70, 1),
    titleColor = Color.fromRGBO(9, 16, 29, 1);
  static double textLargeSize = 26, textMediumSize = 18, textSmallSize = 14;

  ///Durations
  static int animDuration = 250, progressDuration = 500;

  ///Screen
  static const Color screenBackColor = Color.fromRGBO(255, 255, 255, 1),
    screenHintColor = Color.fromRGBO(199, 202, 209, 1);
  static double smallBorderRadius = 10, mediumBorderRadius = 16,
      largeBorderRadius = 24, largePadding = 24, mediumPadding = 16,
      maxBorder = 1000;
  static String backgroundImagePath = 'assets/img/back.png';

  ///Geometric sizes
  static double iconSize = 28, imageHeight = 264, dotSize = 10,
      cardImageLargeSize = 75, cardImageSize = 65;
}
