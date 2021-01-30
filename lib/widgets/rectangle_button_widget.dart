import 'package:flutter/material.dart';
import 'package:pcare/constants/app_colors.dart';
import 'package:pcare/constants/app_theme.dart';

class RectangleButtonWidget extends StatelessWidget {
  final Function onPressed;
  final String childText;
  final double width;
  final bool isImage;
  final String image;
  final double imageOutsideBorderWidth;
  final double imageInsideWidth;
  RectangleButtonWidget(
      {this.onPressed,
      this.childText,
      this.width = 80,
      this.isImage = false,
      this.image,
      this.imageInsideWidth = 180,
      this.imageOutsideBorderWidth = 200});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: isImage ? imageOutsideBorderWidth : width,
        // color: Colors.red,
        decoration: isImage
            ? BoxDecoration()
            : BoxDecoration(
                gradient: UniversalColors.primaryGradient,
                borderRadius: BorderRadius.circular(4),
              ),
        margin: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Center(
          child: isImage
              ? Container(
                  width: imageInsideWidth,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    border: Border.all(color: UniversalColors.black),
                  ),
                  child: Image(
                    image: AssetImage(image),
                    // size: 30,
                    height: 30,
                  ),
                )
              : Text(
                  childText != null ? childText : "",
                  style: Theme.of(context).textTheme.button,
                ),
        ),
      ),
    );
  }
}
