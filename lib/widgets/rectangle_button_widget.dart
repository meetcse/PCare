import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcare/constants/app_colors.dart';

class RectangleButtonWidget extends StatelessWidget {
  final Function onPressed;
  final String childText;
  final double width;
  final double height;
  final bool isColor;
  final Widget icon;
  final String image;
  RectangleButtonWidget({
    this.onPressed,
    @required this.childText,
    this.width,
    this.image,
    this.height,
    this.isColor = true,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: onPressed,
        child: _buildImageAndText(childText, image: image),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(isColor
              ? UniversalColors.gradientColorStart
              : UniversalColors.whiteColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          minimumSize: MaterialStateProperty.all(
            Size(
              width ?? Get.width * 0.7,
              height ?? 50,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageAndText(String text, {String image}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            image != null
                ? Image(
                    image: AssetImage(image),
                  )
                : Container(),
            icon != null ? icon : Container(),
          ],
        ),
        Expanded(
          child: Center(
            child: Container(
              alignment: Alignment.center,
              child: Text(text,
                  style: isColor
                      ? Theme.of(Get.context).textTheme.button
                      : Theme.of(Get.context).textTheme.button.copyWith(
                            color: UniversalColors.darkBlue,
                            fontWeight: FontWeight.w500,
                          )),
            ),
          ),
        ),
      ],
    );
  }
}
