import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pcare/constants/strings.dart';
import 'package:pcare/store/login/registration_controller.dart';
import 'package:pcare/widgets/back_button_widget.dart';
import 'package:pcare/widgets/text_field_widget.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _date;

  List<Map<String, dynamic>> _registrationList;
  RegistrationController registrationController =
      Get.put(RegistrationController());

  loadList() {
    _registrationList = [
      {
        "id": UniversalStrings.firstNameId,
        'text': UniversalStrings.firstName,
        "input_type": TextInputType.name,
        "error_text": registrationController.firstNameError,
        "obscure": false,
        "read_only": false,
        "required": true,
        "text_editing_controller": false
      },
      {
        "id": UniversalStrings.lastNameId,
        'text': UniversalStrings.lastName,
        "input_type": TextInputType.name,
        "error_text": registrationController.lastNameError,
        "obscure": false,
        "read_only": false,
        "required": true,
        "text_editing_controller": false
      },
      {
        "id": UniversalStrings.mobileNumber,
        'text': UniversalStrings.mobileNumber,
        'input_type': TextInputType.phone,
        "error_text": registrationController.mobileNumberError,
        "obscure": false,
        "read_only": false,
        "required": true,
        "text_editing_controller": false
      },
      {
        "id": UniversalStrings.password,
        'text': UniversalStrings.password,
        'input_type': TextInputType.text,
        "error_text": registrationController.passwordError,
        "obscure": true,
        "read_only": false,
        "required": true,
        "text_editing_controller": false
      },
      {
        "id": UniversalStrings.reEnterPassword,
        'text': UniversalStrings.reEnterPassword,
        'input_type': TextInputType.text,
        "error_text": registrationController.reEnterPasswordError,
        "obscure": true,
        "read_only": false,
        "required": true,
        "text_editing_controller": false
      },
      {
        "id": UniversalStrings.address,
        'text': UniversalStrings.address,
        'input_type': TextInputType.streetAddress,
        "error_text": registrationController.addressError,
        "obscure": false,
        "read_only": false,
        "required": true,
        "text_editing_controller": false
      },
      {
        "id": UniversalStrings.gender,
        'text': UniversalStrings.gender,
        'input_type': TextInputType.text,
        "error_text": registrationController.genderError,
        "obscure": false,
        "read_only": false,
        "required": true,
        "text_editing_controller": false
      },
      {
        "id": UniversalStrings.dob,
        'text': UniversalStrings.dob,
        'onTap': 'Yes',
        'input_type': TextInputType.datetime,
        "error_text": registrationController.dobError,
        "obscure": false,
        "read_only": true,
        "required": true,
        "text_editing_controller": true
      },
    ];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildChildWidget(),
    );
  }

  Widget _buildChildWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        Container(
          margin: const EdgeInsets.only(left: 8),
          child: BackButtonWidget(
            isBlackColor: true,
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: 8,
                ),

                //sign up text
                _buildSignUpText(),

                // SizedBox(
                //   height: 12,
                // ),
                //registration list
                _buildList(),

                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpText() {
    return Container(
      margin: EdgeInsets.only(top: 0, left: 20),
      child: Row(
        children: [
          Text(
            UniversalStrings.signUp,
            style: Theme.of(context).textTheme.headline2.copyWith(
                  fontSize: 44,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildList() {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _registrationList.length,
        itemBuilder: (context, index) {
          return Obx(() {
            return registrationController.allow.value
                ? TextFieldWidget(
                    textEditingController: _registrationList[index]
                            ['text_editing_controller']
                        ? new TextEditingController(
                            text: registrationController.dob.value)
                        : null,
                    margin: const EdgeInsets.only(
                        left: 12, right: 12, top: 10, bottom: 6),
                    labelText: _registrationList[index]['text'],
                    onTap: _registrationList[index]['onTap'] == "Yes"
                        ? () => {_selectDate(context)}
                        : null,
                    readOnly: _registrationList[index]['read_only'],
                    isObscureText: _registrationList[index]['obscure'],
                    onChanged: (value) {
                      if (_registrationList[index]['id'] ==
                          UniversalStrings.firstNameId) {
                        registrationController.setFirstName(value);
                      } else if (_registrationList[index]['id'] ==
                          UniversalStrings.lastNameId) {
                        registrationController.setLastName(value);
                      } else if (_registrationList[index]['id'] ==
                          UniversalStrings.mobileNumber) {
                        registrationController.setMobileNumber(value);
                      } else if (_registrationList[index]['id'] ==
                          UniversalStrings.password) {
                        registrationController.setPassword(value);
                      } else if (_registrationList[index]['id'] ==
                          UniversalStrings.reEnterPassword) {
                        registrationController.setReenterPassword(value);
                      } else if (_registrationList[index]['id'] ==
                          UniversalStrings.address) {
                        registrationController.setAddress(value);
                      } else if (_registrationList[index]['id'] ==
                          UniversalStrings.gender) {
                        registrationController.setGender(value);
                      } else if (_registrationList[index]['id'] ==
                          UniversalStrings.dob) {
                        registrationController.setDob(value);
                      }
                    },
                    isError: _registrationList[index]['error_text'].value ==
                                '' ||
                            _registrationList[index]['error_text'].value == null
                        ? false
                        : true,
                    errorText: _registrationList[index]['error_text'].value,
                    textInputType: _registrationList[index]['input_type'],
                    textInputFormatter: _registrationList[index]['id'] ==
                            UniversalStrings.mobileNumber
                        ? [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10),
                          ]
                        : null,
                  )
                : Container();
          });
        });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime d = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1960),
      lastDate: DateTime.now(),
    );

    registrationController.setDob(
        d.day.toString() + "/" + d.month.toString() + "/" + d.year.toString());
  }
}
