import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UniversalColors {
  static const Color gradientColorStart = Color(0xff19769F);
  static const Color gradientColorEnd = Color(0xff35D8A6);
  static const Color whiteColor = Colors.white;
  static const Color gradientColorStart2 = Color(0xffbe93c5);
  // static const Color gradientColorEnd2 = Color(0xff538FFB);
  static const Color gradientColorEnd2 = Color(0xff7bc6cc);

  static const Color lightBlue = Color(0xff5FE5BC);
  static const Color darkBlue = Color(0xff0D47A1);
  static const Color black = Color(0xff3E3E3E);
  static const Color lightGrey = Color(0xffEBEBEB);
  static const Color errorGradientStart = Color(0xffef5350);
  static const Color errorGradientEnd = Color(0xffe53935);
  static const Color red = Colors.red;
  static const Color doctorListBackgroundColor = Color(0xffe0e0e0);
  static const Color specialistColor = Color(0xffffba00);
  static const Color darkBlack = Color(0xff080808);

  static final Gradient primaryGradient = LinearGradient(
      colors: [gradientColorStart, gradientColorEnd],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);

  static final Gradient secondaryGradient = LinearGradient(
    colors: [gradientColorStart, gradientColorEnd2],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static final Gradient errorGradient = LinearGradient(
      colors: [errorGradientStart, errorGradientEnd],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter);
}
