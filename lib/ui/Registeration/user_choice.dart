import 'package:flutter/material.dart';
import 'package:pcare/constants/strings.dart';
import 'package:pcare/flushbar_message/flushbar_message.dart';
import 'package:pcare/routes/animation_route.dart';
import 'package:pcare/routes/routes.dart';
import 'package:pcare/widgets/radio_button_widget.dart';
import 'package:pcare/widgets/rectangle_button_widget.dart';

class UserChoice extends StatefulWidget {
  @override
  _UserChoiceState createState() => _UserChoiceState();
}

class _UserChoiceState extends State<UserChoice> {
  bool _patient = true;
  bool _doctor = false;
  bool _receptionist = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Please select any one from below"),
          Padding(padding: EdgeInsets.only(bottom: 15)),
          RadioButtonWidget(
            itemText: 'Patient',
            groupValue: 'yoyo',
            iconSelected: _patient,
            onChanged: (value) {
              setState(() {
                _patient = true;
                _doctor = false;
                _receptionist = false;
              });
            },
          ),
          Padding(padding: EdgeInsets.only(bottom: 5)),
          RadioButtonWidget(
            itemText: 'Doctor',
            groupValue: 'yoyo',
            iconSelected: _doctor,
            onChanged: (value) {
              setState(() {
                _patient = false;
                _doctor = true;
                _receptionist = false;
              });
            },
          ),
          Padding(padding: EdgeInsets.only(bottom: 5)),
          RadioButtonWidget(
            itemText: 'Receptionist',
            groupValue: 'yoyo',
            iconSelected: _receptionist,
            onChanged: (value) {
              setState(() {
                _patient = false;
                _doctor = false;
                _receptionist = true;
              });
            },
          ),
          Padding(padding: EdgeInsets.only(bottom: 15)),
          RectangleButtonWidget(
            childText: "NEXT",
            onPressed: () {
              _patient
                  ? UniversalStrings.userType = "Patient"
                  : _doctor
                      ? UniversalStrings.userType = "Doctor"
                      : UniversalStrings.userType = "Receptionist";
              Navigator.of(context).push(AnimationRoute(builder: (context) {
                return routes['/sign_up'](context);
              }));
            },
          )
        ],
      ),
    ));
  }
}
