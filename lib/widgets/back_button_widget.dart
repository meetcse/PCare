import 'package:flutter/material.dart';
import 'package:pcare/constants/app_colors.dart';
import 'package:pcare/constants/dimensions.dart';

class BackButtonWidget extends StatelessWidget {
  bool isBlackColor;
  BackButtonWidget({this.isBlackColor = false});
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: !isBlackColor
              ? UniversalColors.whiteColor
              : UniversalColors.black,
          size: Dimensions.iconSize,
        ),
        onPressed: () {
          Navigator.pop(context);
        });
  }
}
