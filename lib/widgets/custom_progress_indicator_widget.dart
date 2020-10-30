import 'package:flutter/material.dart';
import 'package:pcare/constants/app_colors.dart';
import 'package:progress_indicators/progress_indicators.dart';

class CustomProgressIndicatorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: JumpingDotsProgressIndicator(
      color: UniversalColors.gradientColorStart,
      dotSpacing: 0.1,
      fontSize: 100,
      milliseconds: 150,
    ));
  }
}
