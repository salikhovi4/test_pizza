
import 'package:flutter/material.dart';

import '../Config.dart';

class CustomGradient extends LinearGradient {
  CustomGradient() : super(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Config.primaryLightColor,
      Config.primaryColor,
    ],
  );
}
