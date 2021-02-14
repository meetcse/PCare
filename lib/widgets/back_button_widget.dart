import 'package:flutter/material.dart';
import 'package:pcare/Utils/PageUtils.dart';
import 'package:pcare/constants/app_colors.dart';
import 'package:pcare/constants/app_icons.dart';
import 'package:pcare/constants/dimensions.dart';

class BackButtonWidget extends StatelessWidget {
  bool isBlackColor;

  /// On using on pressed dont use pop again.
  Function onPressed;
  BackButtonWidget({this.isBlackColor = false, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(
          UniversalIcons.backArrow,
          color: !isBlackColor
              ? UniversalColors.whiteColor
              : UniversalColors.black,
          size: Dimensions.iconSize,
        ),
        onPressed: () {
          if (onPressed != null) {
            onPressed();
          }
          PageUtils.popCurrentPage();
        });
  }
}
