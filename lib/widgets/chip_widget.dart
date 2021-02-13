import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcare/constants/app_colors.dart';

class ChipWidget extends StatelessWidget {
  final List<String> labelList;
  final TextStyle labelStyle;
  final Color chipBgColor;
  final Widget leadingWidget;
  final Function onChipPressed;

  ChipWidget({
    @required this.labelList,
    this.labelStyle,
    this.chipBgColor,
    this.leadingWidget,
    this.onChipPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        runSpacing: 10,
        spacing: 10,
        children: List.generate(
          labelList.length,
          (index) {
            return GestureDetector(
              onTap: () {
                return onChipPressed();
              },
              child: _buildChip(
                labelList[index],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildChip(String label) {
    return Chip(
      label: Text(
        label,
        style: labelStyle ??
            Theme.of(Get.context).textTheme.button.copyWith(
                  fontSize: 12,
                ),
      ),
      elevation: 2,
      labelPadding: const EdgeInsets.only(
        left: 8,
        right: 8,
        top: 2,
        bottom: 2,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          30,
        ),
      ),
      avatar: leadingWidget ?? null,
      backgroundColor: chipBgColor ?? UniversalColors.gradientColorStart,
    );
  }
}
