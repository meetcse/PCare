import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcare/Utils/PageUtils.dart';
import 'package:pcare/constants/strings.dart';
import 'package:pcare/flushbar_message/flushbar_message.dart';
import 'package:pcare/store/login/doctor_registration_controller.dart';
import 'package:pcare/ui/Registeration/doctor_registration_2.dart';
import 'package:pcare/widgets/back_button_widget.dart';
import 'package:pcare/widgets/rectangle_button_widget.dart';
import 'package:pcare/widgets/text_field_widget.dart';

class DoctorRegistration extends StatefulWidget {
  @override
  _DoctorRegistrationState createState() => _DoctorRegistrationState();
}

class _DoctorRegistrationState extends State<DoctorRegistration> {
  List<Map<String, dynamic>> _registrationList;
  DoctorRegistrationController registrationController =
      Get.put(DoctorRegistrationController());

  loadList() {
    _registrationList = [
      {
        "id": UniversalStrings.firstNameId,
        'text': "MCI ID",
      },
      {
        "id": UniversalStrings.lastNameId,
        'text': "Hospital Name",
      },
      {
        "id": "hospital_address",
        'text': "Hospital Address",
      },
      {
        "id": "doctor_type",
        'text': "Doctor Type",
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

                Container(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
                  child: RectangleButtonWidget(
                    childText: UniversalStrings.nextButtonText,
                    onPressed: () {
                      if (registrationController.isAnyFieldEmpty()) {
                        FlushbarMessage.errorMessage(
                            context, "Please enter your details properly");
                      } else {
                        PageUtils.pushPage(DoctorRegistration2());
                      }
                    },
                    width: Get.width,
                  ),
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
            "Doctor Details",
            style: Theme.of(context).textTheme.headline2.copyWith(
                  fontSize: 34,
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
                    isError: registrationController.mciIdErrorText.value == ''
                        ? false
                        : true,
                    errorText: _registrationList[index]['id'] ==
                            UniversalStrings.firstNameId
                        ? registrationController.mciIdErrorText.value
                        : null,
                    margin: const EdgeInsets.only(
                        left: 12, right: 12, top: 10, bottom: 6),
                    labelText: _registrationList[index]['text'],
                    onChanged: (value) {
                      if (_registrationList[index]['id'] ==
                          UniversalStrings.firstNameId) {
                        registrationController.setmciid(value);
                      } else if (_registrationList[index]['id'] ==
                          UniversalStrings.lastNameId) {
                        registrationController.sethospitalName(value);
                      } else if (_registrationList[index]['id'] ==
                          "hospital_address") {
                        registrationController.sethospitalAddress(value);
                      } else if (_registrationList[index]['id'] ==
                          "doctor_type") {
                        registrationController.setdoctorType(value);
                      }
                    },
                  )
                : Container();
          });
        });
  }
}
