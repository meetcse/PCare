import 'package:flutter/material.dart';
import 'package:pcare/constants/app_colors.dart';
import 'package:pcare/constants/app_theme.dart';

class RadioButtonWidget extends StatelessWidget {
  final String itemText;
  final iconSelected;
  final String groupValue;
  final Function(String) onChanged;

  RadioButtonWidget({
    this.iconSelected = false,
    @required this.itemText,
    @required this.groupValue,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.all(8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              return onChanged(itemText);
            },
            child: Icon(
              iconSelected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: UniversalColors.lightBlue,
            ),
          ),
          GestureDetector(
            onTap: () {
              return onChanged(itemText);
            },
            child: Container(
              padding: EdgeInsets.only(left: 4),
              child: Text(
                itemText,
                style: appTheme.textTheme.headline6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
