import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcare/constants/app_colors.dart';

class ChipWidget extends StatelessWidget {
  final List<String> labelList;
  final TextStyle labelStyle;
  final TextStyle selectedLabelStyle;

  final Color chipBgColor;
  bool isCompare;
  final String compareText;
  final Color chipSelectedBgColor;
  final Widget leadingWidget;
  final Function(String) onChipPressed;

  ChipWidget({
    @required this.labelList,
    this.labelStyle,
    this.chipBgColor,
    this.leadingWidget,
    this.onChipPressed,
    this.isCompare = false,
    this.chipSelectedBgColor,
    this.selectedLabelStyle,
    this.compareText,
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
            bool isSelectd = false;
            if (isCompare != null && isCompare) {
              if (compareText == '' || compareText == null) {
                isSelectd = false;
              } else {
                isSelectd = compareText
                    .toLowerCase()
                    .contains(labelList[index].toLowerCase());
              }
            } else {
              isSelectd = false;
            }
            return GestureDetector(
              onTap: () {
                return onChipPressed(labelList[index]);
              },
              child: AnimatedSwitcher(
                switchInCurve: Curves.easeIn,
                switchOutCurve: Curves.linear,
                duration: Duration(milliseconds: 150),
                child: isSelectd
                    ? _buildChip(
                        labelList[index],
                        isSelectd,
                      )
                    : _buildChip(
                        labelList[index],
                        isSelectd,
                      ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildChip(String label, bool isSelected) {
    return Chip(
      key: isSelected ? Key("0") : Key("1"),
      label: Text(
        label,
        style: isSelected != null && isSelected
            ? selectedLabelStyle
            : labelStyle ??
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
      backgroundColor: isSelected != null && isSelected
          ? chipSelectedBgColor
          : chipBgColor ?? UniversalColors.gradientColorStart,
    );
  }
}
