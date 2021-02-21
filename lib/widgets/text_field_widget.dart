import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pcare/constants/app_colors.dart';
import 'package:pcare/constants/dimensions.dart';

class TextFieldWidget extends StatelessWidget {
  final String labelText;
  final Function(String) onChanged;
  final Function() onTap;
  final bool readOnly;
  final TextEditingController textEditingController;
  final String errorText;
  final bool isObscureText;
  final bool isError;
  final TextInputType textInputType;
  final List<TextInputFormatter> textInputFormatter;
  final EdgeInsets margin;
  final double width;
  final Widget prefixIcon;

  TextFieldWidget(
      {@required this.labelText,
      this.onChanged,
      this.textEditingController,
      this.errorText,
      this.isObscureText = false,
      this.isError = false,
      this.textInputType,
      this.textInputFormatter,
      this.margin,
      this.onTap,
      this.readOnly = false,
      this.width,
      this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width != null ? width : MediaQuery.of(context).size.width,
      margin: margin != null ? margin : EdgeInsets.all(20),
      child: TextField(
        keyboardType: textInputType,
        onChanged: onChanged,
        obscureText: isObscureText,
        onTap: onTap,
        readOnly: readOnly,
        controller: textEditingController,
        inputFormatters: textInputFormatter != null ? textInputFormatter : null,
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
            prefixIcon: prefixIcon),
      ),
    );
  }
}
