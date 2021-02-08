import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcare/store/login/registration_controller.dart';
import 'package:pcare/widgets/text_field_widget.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String date =
      null; //Always use private variables to save space = declare private variables using underscore
  List<Map<String, String>> list = [
    {'text': 'FirstName'},
    {'text': 'LastName'},
    {'text': 'PassWord', 'textInputType': 'password'},
    {'text': 'Re-Enter PassWord'},
    {'text': 'Address'},
    {'text': 'Gender'},
    {'text': 'Date Of Birth', 'onTap': 'Yes', 'readOnly': 'Yes'},
    {'text': 'Mobile Number'}
  ];
  RegistrationController registrationController =
      Get.put(RegistrationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return GetX<RegistrationController>(builder: (controller) {
              return TextFieldWidget(
                textEditingController:
                    date != null && list[index]['text'] == 'Date Of Birth'
                        ? new TextEditingController(text: date)
                        : null,
                labelText: list[index]['text'],
                onTap: list[index]['onTap'] == "Yes"
                    ? () => {_selectDate(context)}
                    : null,
                readOnly: list[index]['readOnly'] == "Yes",
                isObscureText: list[index]['textInputType'] == "password",
                onChanged: (value) {
                  controller.setPassword(value);
                },
                isError: list[index]['textInputType'] == "password"
                    ? controller.passwordError.value == null ||
                            controller.passwordError.value == ''
                        ? false
                        : true
                    : false,
              );
            });
          }),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime d = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1960),
      lastDate: DateTime.now(),
    );

    setState(() {
      date =
          d.day.toString() + "/" + d.month.toString() + "/" + d.year.toString();
    });
  }
}
