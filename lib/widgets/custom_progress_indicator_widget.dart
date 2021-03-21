import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pcare/constants/app_colors.dart';

class CustomProgressIndicatorWidget extends StatelessWidget {
  final double size;
  final double height;
  // final double size;

  CustomProgressIndicatorWidget({this.size = 50, this.height});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: Get.height,
          width: Get.width,
          color: UniversalColors.lightGrey.withOpacity(0.1),
        ),
        Center(
          child: Lottie.asset(
            'assets/videos/loading.json',
            height: height ?? Get.height * 0.4,
            width: Get.width * 0.5,
          ),
        ),
      ],
    );
    // SpinKitFadingFour(
    //   color: UniversalColors.gradientColorStart,
    //   size: size,
    // );
  }
}
