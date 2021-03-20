import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:pcare/constants/app_colors.dart';
import 'package:pcare/constants/strings.dart';

class FlushbarMessage {
  static errorMessage(BuildContext context, String error) {
    return Flushbar(
      title: UniversalStrings.error,
      message: error,
      borderRadius: BorderRadius.circular(20),
      backgroundGradient: UniversalColors.errorGradient,
      margin: EdgeInsets.all(10),
      flushbarPosition: FlushbarPosition.BOTTOM,
      duration: Duration(seconds: 2),
    )..show(context);
  }

  static successMessage(BuildContext context, String message) {
    return Flushbar(
      title: UniversalStrings.success,
      message: message,
      // leftBarIndicatorColor: UniversalColors.gradientColorStart,
      backgroundGradient: UniversalColors.primaryGradient,
      borderRadius: BorderRadius.circular(20),
      margin: EdgeInsets.all(10),
      flushbarPosition: FlushbarPosition.BOTTOM,
      duration: Duration(seconds: 2),
    )..show(context);
  }
}
