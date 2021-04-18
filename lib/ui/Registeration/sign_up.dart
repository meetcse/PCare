import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pcare/Utils/AppMethods.dart';
import 'package:pcare/Utils/PageUtils.dart';
import 'package:pcare/api/registration/SignupApi.dart';
import 'package:pcare/constants/app_colors.dart';
import 'package:pcare/constants/preferences.dart';
import 'package:pcare/constants/strings.dart';
import 'package:pcare/flushbar_message/flushbar_message.dart';
import 'package:pcare/models/signup/SignupModel.dart';
import 'package:pcare/services/SharedPrefsServices.dart';
import 'package:pcare/store/login/login_controller.dart';
import 'package:pcare/store/login/registration_controller.dart';
import 'package:pcare/ui/Registeration/doctor_registration.dart';
import 'package:pcare/ui/Registeration/receptionist_registration.dart';
import 'package:pcare/ui/patient/HomePage.dart';
import 'package:pcare/widgets/AppWidgets.dart';
import 'package:pcare/widgets/back_button_widget.dart';
import 'package:pcare/widgets/main_app_bar_widget.dart';
import 'package:pcare/widgets/radio_button_widget.dart';
import 'package:pcare/widgets/rectangle_button_widget.dart';
import 'package:pcare/widgets/text_field_widget.dart';

class SignUp extends StatefulWidget {
  SignupModel signupModel;

  SignUp({@required this.signupModel});
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _date;

  List<Map<String, dynamic>> _registrationList;
  String _groupValue = "Gender";
  RegistrationController registrationController =
      Get.put(RegistrationController());
  LoginController _loginController = Get.find<LoginController>();

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
        "read_only": true,
        "required": true,
        "text_editing_controller": true,
        'onTap': 'Yes',
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
          height: 10,
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
                  height: 10,
                ),

                Container(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
                  child: RectangleButtonWidget(
                    childText: widget.signupModel.usertype.toLowerCase() ==
                            UniversalStrings.patientRadioButton.toLowerCase()
                        ? UniversalStrings.register
                        : UniversalStrings.nextButtonText,
                    onPressed: _onButtonPressed,
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
                                ['text_editing_controller'] &&
                            _registrationList[index]['id'] ==
                                UniversalStrings.dob
                        ? new TextEditingController(
                            text: registrationController.dob.value)
                        : _registrationList[index]['text_editing_controller'] &&
                                _registrationList[index]['id'] ==
                                    UniversalStrings.gender
                            ? new TextEditingController(
                                text: registrationController.gender.value)
                            : null,
                    margin: const EdgeInsets.only(
                        left: 12, right: 12, top: 10, bottom: 6),
                    labelText: _registrationList[index]['text'],
                    onTap: _registrationList[index]['onTap'] == "Yes" &&
                            _registrationList[index]['id'] ==
                                UniversalStrings.dob
                        ? () {
                            _selectDate(context);
                          }
                        : _registrationList[index]['onTap'] == "Yes" &&
                                _registrationList[index]['id'] ==
                                    UniversalStrings.gender
                            ? () {
                                _openGenderDialog();
                              }
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

  Widget _buildSelectGenderText() {
    return Container(
      margin: const EdgeInsets.only(left: 12),
      child: Text(
        UniversalStrings.selectGender,
        style: Theme.of(context).textTheme.headline2,
      ),
    );
  }

  Widget _buildSelectionRow() {
    return Obx(
      () => Row(
        children: [
          Expanded(
            flex: 4,
            child: RadioButtonWidget(
              itemText: "Male",
              itemTextStyle:
                  Theme.of(context).textTheme.headline6.copyWith(fontSize: 16),
              groupValue: _groupValue,
              iconSelected:
                  registrationController.gender.value.toLowerCase() == "male",
              onChanged: (value) {
                registrationController.setGender(value);
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Expanded(
            flex: 5,
            child: RadioButtonWidget(
              itemText: "Female",
              itemTextStyle:
                  Theme.of(context).textTheme.headline6.copyWith(fontSize: 16),
              groupValue: _groupValue,
              iconSelected:
                  registrationController.gender.value.toLowerCase() == "female",
              onChanged: (value) {
                registrationController.setGender(value);
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime _date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1960),
      lastDate: DateTime.now(),
    );
    if (_date != null) {
      _saveDate(_date);
    }
  }

  void _openGenderDialog() {
    showDialog(
      context: Get.context,
      barrierDismissible: true,
      useSafeArea: true,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CloseButton(),
                  Container(
                    // margin: const EdgeInsets.only(left: 20),
                    alignment: Alignment.center,
                    child: _buildSelectGenderText(),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              _buildSelectionRow(),
              SizedBox(
                height: 12,
              ),
            ],
          ),
        );
      },
    );
  }

  //methods and on clicks

  void _saveDate(DateTime date) {
    String _date = DateFormat("dd-MM-yyyy").format(date);
    registrationController.setDob(_date);
  }

  void _onButtonPressed() {
    if (!registrationController.validateForm()) {
      FlushbarMessage.errorMessage(
          context, "Please enter every field properly");
    } else {
      SignupModel _signupModel;
      _signupModel = _saveDataToModel();
      if (widget.signupModel.usertype.toLowerCase() ==
          UniversalStrings.patientRadioButton.toLowerCase()) {
        //patient
        _callPatientRegisterAPI(_signupModel);
      } else if (widget.signupModel.usertype.toLowerCase() ==
          UniversalStrings.receptionist.toLowerCase()) {
        //receptionist
        _gotoReceptionistRegisteration(_signupModel);
      } else {
        //doctor
        _gotoDoctorRegisteration(_signupModel);
      }
    }
  }

  void _callPatientRegisterAPI(SignupModel signupModel) async {
    AppWidgets.customProgressDialog();

    SignupApi _signupApi = SignupApi();

    try {
      _loginController.loginModel = await _signupApi.registerUser(signupModel);

      AppMethods.saveLoginDetailsToSharedPrefs(
          _loginController.loginModel.token,
       registrationController.mobileNumber.value,
         registrationController.password.value);
      AppWidgets.closeDialog();
      _gotoPatientHomePage();
    } catch (error) {
      AppWidgets.closeDialog();
      print("ERROR IN Signup : " + error.toString());
      FlushbarMessage.errorMessage(Get.context, "Error in registering");
    }
  }

  SignupModel _saveDataToModel() {
    widget.signupModel.firstname = registrationController.firstName.value;
    widget.signupModel.lastname = registrationController.lastName.value;
    widget.signupModel.mobilenumber = registrationController.mobileNumber.value;
    widget.signupModel.password = registrationController.password.value;
    widget.signupModel.area = registrationController.address.value;
    widget.signupModel.gender = registrationController.gender.value;
    widget.signupModel.dob = registrationController.dob.value;

    return widget.signupModel;
  }

  void _gotoPatientHomePage() {
    PageUtils.pushPageAndRemoveAll(HomePage());
  }

  void _gotoReceptionistRegisteration(SignupModel signupModel) {
    PageUtils.pushPage(ReceptionistRegistration(
      signupModel: signupModel,
    ));
  }

  void _gotoDoctorRegisteration(SignupModel signupModel) {
    PageUtils.pushPage(DoctorRegistration(
      signupModel: signupModel,
    ));
  }
}
