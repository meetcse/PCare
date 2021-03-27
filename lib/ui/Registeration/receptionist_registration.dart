import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcare/Utils/PageUtils.dart';
import 'package:pcare/constants/app_colors.dart';
import 'package:pcare/constants/strings.dart';
import 'package:pcare/flushbar_message/flushbar_message.dart';
import 'package:pcare/models/user/user_model.dart';
import 'package:pcare/store/login/receptionist_registration_controller.dart';
import 'package:pcare/ui/patient/HomePage.dart';
import 'package:pcare/ui/reception/reception_home_page.dart';
import 'package:pcare/widgets/back_button_widget.dart';
import 'package:pcare/widgets/main_app_bar_widget.dart';
import 'package:pcare/widgets/rectangle_button_widget.dart';
import 'package:pcare/widgets/text_field_widget.dart';

class ReceptionistRegistration extends StatefulWidget {
  UserModel userModel;

  ReceptionistRegistration({@required this.userModel});
  @override
  _ReceptionistRegistrationState createState() =>
      _ReceptionistRegistrationState();
}

class _ReceptionistRegistrationState extends State<ReceptionistRegistration> {
  UserModel userModel;

  List<Map<String, dynamic>> _registrationList;
  ReceptionistRegistrationController registrationController =
      Get.put(ReceptionistRegistrationController());

  loadList() {
    _registrationList = [
      {
        "id": UniversalStrings.firstNameId,
        'text': "Doctor Name",
      },
      {
        "id": UniversalStrings.lastNameId,
        'text': "Hospital Name",
      },
    ];
  }

  @override
  void initState() {
    userModel = widget.userModel;
    loadList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UniversalColors.whiteColor,
      appBar: MainAppBarWidget(
        appBarColorWhenIsColorFalse: UniversalColors.whiteColor,
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
        SizedBox(
          height: 8,
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

                SizedBox(
                  height: 20,
                ),
                //registration list
                _buildList(),

                SizedBox(
                  height: 30,
                ),

                Container(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
                  child: RectangleButtonWidget(
                    childText: "REGISTER",
                    onPressed: () {
                      if (registrationController.doctorName.value == "" ||
                          registrationController.hospitalName.value == "") {
                        FlushbarMessage.errorMessage(
                            context, "Please enter every field");
                      } else {
                        PageUtils.pushPage(ReceptionHomePage());
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
            "Receptionist Details",
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
                    margin: const EdgeInsets.only(
                        left: 12, right: 12, top: 10, bottom: 6),
                    labelText: _registrationList[index]['text'],
                    onChanged: (value) {
                      if (_registrationList[index]['id'] ==
                          UniversalStrings.firstNameId) {
                        registrationController.setdoctorName(value);
                      } else if (_registrationList[index]['id'] ==
                          UniversalStrings.lastNameId) {
                        registrationController.sethospitalName(value);
                      }
                    },
                  )
                : Container();
          });
        });
  }
}
