import 'package:flutter/material.dart';
import 'package:pcare/constants/app_colors.dart';

ThemeData appTheme = ThemeData(
  textTheme: TextTheme(
    headline1: TextStyle(
      fontSize: 22,
      color: UniversalColors.whiteColor,
    ),
    headline2: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: UniversalColors.gradientColorStart),
    headline6: TextStyle(
        fontSize: 14,
        // fontWeight: FontWeight.w500,
        color: UniversalColors.black),
    button: TextStyle(
        fontSize: 16,
        // fontWeight: FontWeight.w500,
        color: UniversalColors.whiteColor),
    subtitle1: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: UniversalColors.gradientColorStart),
  ),
);
