import 'package:flutter/material.dart';
import 'package:pcare/constants/dimensions.dart';

class TextFieldWidget extends StatelessWidget {
  final String labelText;
  final Function(String) onChanged;
  final TextEditingController textEditingController;
  final String errorText;
  final bool isObscureText;
  final bool isError;

  TextFieldWidget(
      {@required this.labelText,
      this.onChanged,
      this.textEditingController,
      this.errorText,
      this.isObscureText = false,
      this.isError});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(20),
      child: TextField(
        onChanged: onChanged,
        obscureText: isObscureText,
        controller: textEditingController,
        decoration: InputDecoration(
          labelText: labelText ?? "",
          errorText: isError ? errorText : null,
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(Dimensions.textfieldBorderRadius),
          ),
        ),
      ),
    );
  }
}
