import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pcare/constants/app_colors.dart';

class CustomTheme {
  static ThemeData customTheme(BuildContext context) {
    ThemeData appTheme = ThemeData(
      textTheme:
          GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme.copyWith(
                headline1: TextStyle(
                  fontSize: 24,
                  color: UniversalColors.whiteColor,
                ),
                headline2: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: UniversalColors.gradientColorStart),
                headline3: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: UniversalColors.whiteColor),
                headline6: TextStyle(
                    fontSize: 14,
                    // fontWeight: FontWeight.w500,
                    color: UniversalColors.black),
                subtitle1: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: UniversalColors.gradientColorStart),
                button: TextStyle(
                    fontSize: 16,
                    // fontWeight: FontWeight.w500,
                    color: UniversalColors.whiteColor),
              )),
    );
    return appTheme;
  }
}
