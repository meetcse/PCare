import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pcare/constants/app_colors.dart';

class CustomProgressIndicatorWidget extends StatelessWidget {
  final double size;

  CustomProgressIndicatorWidget({this.size = 50});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        'assets/videos/loading.json',
        height: Get.height * 0.4,
        width: Get.width * 0.5,
      ),
    );
    // SpinKitFadingFour(
    //   color: UniversalColors.gradientColorStart,
    //   size: size,
    // );
  }
}
