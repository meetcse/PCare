import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pcare/constants/app_colors.dart';

class CustomProgressIndicatorWidget extends StatelessWidget {
  final double size;

  CustomProgressIndicatorWidget({this.size = 50});

  @override
  Widget build(BuildContext context) {
    return SpinKitFadingFour(
      color: UniversalColors.gradientColorStart,
      size: size,
    );
  }
}
