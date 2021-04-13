import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:pcare/Utils/AppMethods.dart';
import 'package:pcare/Utils/PageUtils.dart';
import 'package:pcare/api/registration/GetHospitalApi.dart';
import 'package:pcare/api/registration/SearchDoctors.dart';
import 'package:pcare/api/registration/SignupApi.dart';
import 'package:pcare/constants/app_colors.dart';
import 'package:pcare/constants/dimensions.dart';
import 'package:pcare/constants/strings.dart';
import 'package:pcare/flushbar_message/flushbar_message.dart';
import 'package:pcare/models/doctor/DoctorModel.dart';
import 'package:pcare/models/signup/HospitalModel.dart';
import 'package:pcare/models/signup/SignupModel.dart';
import 'package:pcare/store/login/login_controller.dart';
import 'package:pcare/store/login/receptionist_registration_controller.dart';
import 'package:pcare/ui/patient/HomePage.dart';
import 'package:pcare/ui/reception/reception_home_page.dart';
import 'package:pcare/widgets/AppWidgets.dart';
import 'package:pcare/widgets/back_button_widget.dart';
import 'package:pcare/widgets/custom_progress_indicator_widget.dart';
import 'package:pcare/widgets/main_app_bar_widget.dart';
import 'package:pcare/widgets/rectangle_button_widget.dart';
import 'package:pcare/widgets/text_field_widget.dart';

class ReceptionistRegistration extends StatefulWidget {
  SignupModel signupModel;

  ReceptionistRegistration({@required this.signupModel});
  @override
  _ReceptionistRegistrationState createState() =>
      _ReceptionistRegistrationState();
}

class _ReceptionistRegistrationState extends State<ReceptionistRegistration> {
  List<Map<String, dynamic>> _registrationList;
  ReceptionistRegistrationController registrationController =
      Get.put(ReceptionistRegistrationController());

  TextEditingController _doctorNameController = TextEditingController();
  TextEditingController _hospitalNameController = TextEditingController();
  GetHospitalApi _hospitalApi = GetHospitalApi();
  SearchDoctorApi _searchDoctorAPI = SearchDoctorApi();

  String _selectedDoctorId;
  String _selectedHospitalId;
  LoginController _loginController = Get.find<LoginController>();

  loadList() {
    _registrationList = [
      {
        "id": UniversalStrings.firstNameId,
        'text': "Doctor Name",
        "controller": _doctorNameController,
      },
      {
        "id": UniversalStrings.lastNameId,
        'text': "Hospital Name",
        "controller": _hospitalNameController,
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
                    onPressed: _onRegisterPressed,
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
                ? Container(
                    margin: const EdgeInsets.only(
                        left: 12, right: 12, top: 10, bottom: 6),
                    child: TypeAheadFormField(
                      textFieldConfiguration: TextFieldConfiguration(
                        controller: _registrationList[index]['controller'],
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: UniversalColors.gradientColorEnd,
                                width: 2.0),
                            borderRadius: BorderRadius.circular(
                                Dimensions.textfieldBorderRadius),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                Dimensions.textfieldBorderRadius),
                          ),
                          labelStyle: Theme.of(context).textTheme.subtitle1,
                          labelText: _registrationList[index]['text'],
                        ),
                      ),
                      suggestionsCallback: (pattern) async {
                        if (_registrationList[index]['id'] ==
                            UniversalStrings.firstNameId) {
                          registrationController.setdoctorName(pattern);
                          return await _getSearchDoctors(pattern);
                        } else {
                          registrationController.sethospitalName(pattern);
                          return await _callHospitalsAPI(pattern);
                        }
                      },
                      hideOnEmpty: true,
                      hideOnError: true,
                      // hideOnLoading: true,
                      keepSuggestionsOnLoading: false,
                      loadingBuilder: (context) {
                        return Container(
                          child: CustomProgressIndicatorWidget(
                            height: 4,
                            size: 4,
                          ),
                        );
                      },
                      itemBuilder: (context, suggestion) {
                        if (_registrationList[index]['id'] ==
                            UniversalStrings.firstNameId) {
                          DoctorDetailsModel _doctor;
                          _doctor = suggestion;

                          return ListTile(
                            title: Text(
                              (_doctor.user.firstname +
                                      " " +
                                      _doctor.user.lastname) ??
                                  '',
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2
                                  .copyWith(fontSize: 14),
                            ),
                            subtitle: Text(
                              _doctor.hospital_id.hospitalName ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        } else {
                          HospitalModel _hospitalModel;
                          _hospitalModel = suggestion;
                          return ListTile(
                            title: Text(
                              (_hospitalModel.hospitalName) ?? '',
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2
                                  .copyWith(fontSize: 14),
                            ),
                            subtitle: Text(
                              _hospitalModel.hospitalAddress ?? '',
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(fontSize: 12),
                            ),
                          );
                        }
                      },
                      transitionBuilder: (context, suggestionsBox, controller) {
                        return suggestionsBox;
                      },
                      onSuggestionSelected: (suggestion) {
                        if (_registrationList[index]['id'] ==
                            UniversalStrings.firstNameId) {
                          //doctor
                          //
                          DoctorDetailsModel _doctor;
                          _doctor = suggestion;
                          _doctorNameController.text = _doctor.user.firstname +
                              " " +
                              _doctor.user.lastname;
                          _selectedDoctorId = _doctor.sId;
                        } else if (_registrationList[index]['id'] ==
                            UniversalStrings.lastNameId) {
//hospital
                          HospitalModel _hospitalModel;
                          _hospitalModel = suggestion;
                          _hospitalNameController.text =
                              _hospitalModel.hospitalName;
                          _selectedHospitalId = _hospitalModel.id;
                        }
                      },
                    ),
                  )
                : Container();
          });
        });
  }

  //methods and on clicks

  Future<List<DoctorDetailsModel>> _getSearchDoctors(String doctorName) async {
    List<DoctorDetailsModel> _doctorsList;
    if (doctorName.isEmpty) {
      return [];
    }
    _doctorsList =
        await _searchDoctorAPI.searchDoctors(doctorName).catchError((error) {
      print("ERROR IN FINDING Doctors : " + error.toString());
    });
    return _doctorsList;
  }

  Future<List<HospitalModel>> _callHospitalsAPI(String hospitalName) async {
    List<HospitalModel> _hospitalModelList;
    if (hospitalName.isEmpty) {
      return [];
    }
    _hospitalModelList =
        await _hospitalApi.getHospital(hospitalName).catchError((error) {
      print("ERROR IN FINDING HOSPITAL : " + error.toString());
    });

    return _hospitalModelList;
  }

  void _onRegisterPressed() {
    if (registrationController.doctorName.value == "" ||
        registrationController.hospitalName.value == "") {
      FlushbarMessage.errorMessage(context, "Please enter every field");
    } else {
      _callRegisterReceptionist();
    }
  }

  void _callRegisterReceptionist() async {
    AppWidgets.customProgressDialog();
    _saveDataToModel();
    SignupApi _signupApi = SignupApi();

    try {
      _loginController.loginModel =
          await _signupApi.registerUser(widget.signupModel);

      AppMethods.saveLoginDetailsToSharedPrefs(
          _loginController.loginModel.token,
          widget.signupModel.mobilenumber,
          widget.signupModel.password);
      AppWidgets.closeDialog();
      _gotoReceptionistHomePage();
    } catch (error) {
      AppWidgets.closeDialog();
      print("ERROR IN Signup : " + error.toString());
      FlushbarMessage.errorMessage(Get.context, "Error in registering");
    }
  }

  void _saveDataToModel() {
    widget.signupModel.hospital_id = _selectedHospitalId;
    widget.signupModel.doctor_id = _selectedDoctorId;
  }

  void _gotoReceptionistHomePage() {
    PageUtils.pushPageAndRemoveAll(ReceptionHomePage());
  }
}
