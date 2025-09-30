import 'package:flutter/material.dart';

///UFF Color Pallete. the alpha parameter can be customized like: ColorPallete.darkBlue(alpha=100).
class AppColors{
  static Color darkBlue({int alpha=255}) => Color.fromARGB(alpha, 29, 50, 78);
  static Color lightBlue({int alpha=255}) => Color.fromARGB(alpha, 204, 229, 255);
  static Color mediumBlue({int alpha=255}) => Color.fromARGB(alpha, 57, 125, 198);
  static Color alternativeDarkBlue({int alpha=255}) => Color.fromARGB(alpha, 33, 59, 79);
  static Color alternativeMediumBlue({int alpha=255}) => Color.fromARGB(alpha, 42, 94, 147);
}