import 'package:flutter/material.dart';
import 'package:pcare/constants/dimensions.dart';

class TextFieldWidget extends StatelessWidget {
  final String labelText;
  final Function(String) onChanged;
  TextFieldWidget({this.labelText, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: labelText ?? "",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimensions.textfieldBorderRadius),
        ),
      ),
    );
  }
}
