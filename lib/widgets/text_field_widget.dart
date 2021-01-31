import 'package:flutter/material.dart';
import 'package:pcare/constants/app_colors.dart';
import 'package:pcare/constants/dimensions.dart';

class TextFieldWidget extends StatelessWidget {
  final String labelText;
  final Function(String) onChanged;
  final TextEditingController textEditingController;
  final String errorText;
  final bool isObscureText;
  final bool isError;
  final TextInputType textInputType;

  TextFieldWidget(
      {@required this.labelText,
      this.onChanged,
      this.textEditingController,
      this.errorText,
      this.isObscureText = false,
      this.isError,
      this.textInputType});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(20),
      child: TextField(
        keyboardType: textInputType,
        onChanged: onChanged,
        obscureText: isObscureText,
        controller: textEditingController,
        decoration: InputDecoration(
          labelText: labelText ?? "",
          labelStyle: Theme.of(context).textTheme.subtitle1,
          errorText: isError ? errorText : null,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: UniversalColors.gradientColorEnd, width: 2.0),
            borderRadius:
                BorderRadius.circular(Dimensions.textfieldBorderRadius),
          ),
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(Dimensions.textfieldBorderRadius),
          ),
        ),
      ),
    );
  }
}
