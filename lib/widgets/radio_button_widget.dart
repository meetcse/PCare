import 'package:flutter/material.dart';
import 'package:pcare/constants/app_colors.dart';

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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                return onChanged(itemText);
              },
              child: Container(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  itemText,
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontSize: 24),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              return onChanged(itemText);
            },
            child: Container(
              padding: EdgeInsets.only(right: 20),
              child: Icon(
                iconSelected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
                color: UniversalColors.gradientColorStart,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
