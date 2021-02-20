import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcare/Utils/PageUtils.dart';
import 'package:pcare/constants/strings.dart';
import 'package:pcare/flushbar_message/flushbar_message.dart';
import 'package:pcare/ui/Registeration/sign_up.dart';
import 'package:pcare/widgets/back_button_widget.dart';
import 'package:pcare/widgets/main_app_bar_widget.dart';
import 'package:pcare/widgets/radio_button_widget.dart';
import 'package:pcare/widgets/rectangle_button_widget.dart';

class UserChoice extends StatefulWidget {
  @override
  _UserChoiceState createState() => _UserChoiceState();
}

class _UserChoiceState extends State<UserChoice> {
  String _userType = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBarWidget(
        isColor: false,
        leading: BackButtonWidget(
          isBlackColor: true,
        ),
      ),
      body: _buildChildWidget(),
    );
  }

  Widget _buildChildWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Text(
            "Choose Any One",
            style: Theme.of(context).textTheme.headline2.copyWith(
                  fontSize: 34,
                ),
          ),
        ),
        _cardWidget(
            child: _buildRadioButton(UniversalStrings.patientRadioButton,
                UniversalStrings.groupValue)),
        _cardWidget(
            child: _buildRadioButton(UniversalStrings.doctorRadioButton,
                UniversalStrings.groupValue)),
        _cardWidget(
            child: _buildRadioButton(
                UniversalStrings.receptionist, UniversalStrings.groupValue)),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
                child: RectangleButtonWidget(
                  childText: UniversalStrings.nextButtonText,
                  onPressed: () {
                    if (_userType == "") {
                      FlushbarMessage.errorMessage(
                          context, UniversalStrings.userChoiceErrorMessage);
                    } else {
                      PageUtils.pushPage(SignUp(userType: _userType));
                    }
                  },
                  width: Get.width,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRadioButton(String text, String groupValue) {
    return RadioButtonWidget(
      itemText: text,
      groupValue: groupValue,
      iconSelected: _userType.toLowerCase() == text.toLowerCase(),
      onChanged: (value) {
        setState(() {
          _userType = text;
        });
      },
    );
  }

  Widget _cardWidget({Widget child}) {
    return Card(
      child: child,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
