import 'package:flutter/material.dart';
import 'package:optima_delivery_mobile/common/styles/colors.dart';

class StyleGradients {
  static const purple = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [StyleColors.gradientStart, StyleColors.gradientEnd],
    tileMode: TileMode.clamp,
  );
}
