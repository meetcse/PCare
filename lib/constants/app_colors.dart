import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UniversalColors {
  static const Color gradientColorStart = Color(0xff19769F);
  static const Color gradientColorEnd = Color(0xff35D8A6);
  static const Color whiteColor = Colors.white;

  static const Color lightBlue = Color(0xff5FE5BC);
  static const Color black = Color(0xff3E3E3E);
  static const Color lightGrey = Color(0xffEBEBEB);

  static final Gradient primaryGradient = LinearGradient(
      colors: [gradientColorStart, gradientColorEnd],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);
}
