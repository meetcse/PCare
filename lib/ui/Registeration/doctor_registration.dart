import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcare/Utils/PageUtils.dart';
import 'package:pcare/api/registration/GetHospitalApi.dart';
import 'package:pcare/constants/app_colors.dart';
import 'package:pcare/constants/strings.dart';
import 'package:pcare/flushbar_message/flushbar_message.dart';
import 'package:pcare/models/signup/HospitalModel.dart';
import 'package:pcare/models/signup/SignupModel.dart';
import 'package:pcare/store/login/doctor_registration_controller.dart';
import 'package:pcare/ui/Registeration/doctor_registration_2.dart';
import 'package:pcare/widgets/back_button_widget.dart';
import 'package:pcare/widgets/main_app_bar_widget.dart';
import 'package:pcare/widgets/rectangle_button_widget.dart';
import 'package:pcare/widgets/text_field_widget.dart';

class DoctorRegistration extends StatefulWidget {
  SignupModel signupModel;

  DoctorRegistration({@required this.signupModel});
  @override
  _DoctorRegistrationState createState() => _DoctorRegistrationState();
}

class _DoctorRegistrationState extends State<DoctorRegistration> {
  List<Map<String, dynamic>> _registrationList;
  DoctorRegistrationController registrationController =
      Get.put(DoctorRegistrationController());

  TextEditingController _hospitalNameController = TextEditingController();
  TextEditingController _hospitalAddressController = TextEditingController();
  bool _isCreateNewHospital = false;
  String _selectedHospitalId;

  List<HospitalModel> _hospitalModelList = [];
  GetHospitalApi _hospitalApi = GetHospitalApi();

  loadList() {
    _registrationList = [
      {
        "id": UniversalStrings.firstNameId,
        'text': "MCI ID",
        "read": false,
      },
      {
        "id": UniversalStrings.lastNameId,
        'text': "Hospital Name",
        "read": true,
      },
      {
        "id": "hospital_address",
        'text': "Hospital Address",
        "read": true,
      },
      {
        "id": "doctor_type",
        'text': "Doctor Type",
        "read": false,
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
                        _saveDataToModel();
                        _gotoDoctorRegistration2Screen();
                      }
                      // _openHospitalDialog();
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
                    textEditingController: _registrationList[index]['id'] ==
                            UniversalStrings.lastNameId
                        ? _hospitalNameController
                        : _registrationList[index]['id'] == "hospital_address"
                            ? _hospitalAddressController
                            : null,
                    errorText: _registrationList[index]['id'] ==
                            UniversalStrings.firstNameId
                        ? registrationController.mciIdErrorText.value
                        : null,
                    readOnly: _registrationList[index]['read'] ?? false,
                    onTap: _registrationList[index]['read']
                        ? () {
                            _openHospitalDialog();
                          }
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

  Widget _buildHospitalList() {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: _hospitalModelList?.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              _hospitalModelList[index].hospitalName,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              _hospitalModelList[index].hospitalAddress,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              _saveHospital(_hospitalModelList[index]);
            },
          );
        });
  }

  Widget _buildCreateNewHospitalOption(Function setState) {
    return Container(
      width: Get.width * 0.5,
      child: RectangleButtonWidget(
        childText: 'Add Hospital',
        onPressed: () {
          _changeIsCreateNewHospital(setState);
        },
      ),
    );
  }

  Widget _buildCreateNewHospitalButton(Function setState) {
    return Container(
      width: Get.width * 0.5,
      child: RectangleButtonWidget(
        childText: 'Create Hospital',
        onPressed: () {
          if (_hospitalAddressController.text == null ||
              _hospitalAddressController.text.isEmpty ||
              _hospitalNameController.text == null ||
              _hospitalNameController.text.isEmpty) {
            return null;
          }
          _createNewHospital(setState);
        },
      ),
    );
  }

  void _openHospitalDialog() {
    showDialog(
        context: Get.context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CloseButton(),
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text("Select Hospital",
                                style: Theme.of(context).textTheme.headline2),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFieldWidget(
                      textEditingController: _hospitalNameController,
                      labelText: 'Enter Hospital Name',
                      onChanged: (value) {
                        _callHospitalApi(value, setState);
                      },
                    ),
                    _isCreateNewHospital
                        ? TextFieldWidget(
                            textEditingController: _hospitalAddressController,
                            labelText: 'Enter Hospital Address',
                            onChanged: (value) {
                              //call api
                            },
                          )
                        : Container(),
                    _buildHospitalList(),
                    _hospitalNameController.text.isNotEmpty &&
                            _hospitalModelList.isEmpty &&
                            !_isCreateNewHospital
                        ? _buildCreateNewHospitalOption(setState)
                        : Container(),
                    _isCreateNewHospital
                        ? _buildCreateNewHospitalButton(setState)
                        : Container(),
                    SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }

  //methods and on clicks

  void _changeIsCreateNewHospital(Function setState) {
    _isCreateNewHospital = !_isCreateNewHospital;
    setState(() {});
  }

  void _callHospitalApi(String hospitalName, Function setState) async {
    _hospitalModelList =
        await _hospitalApi.getHospital(hospitalName).catchError((error) {
      print("ERROR IN FINDING HOSPITAL : " + error.toString());
    });

    setState(() {});
  }

  void _createNewHospital(Function setState) async {
    HospitalModel _hospitalModel;
    _hospitalModel = await _hospitalApi
        .createHospital(
            _hospitalNameController.text, _hospitalAddressController.text)
        .catchError((error) {
      FlushbarMessage.errorMessage(context, "Something went wrong");
    });

    if (_hospitalModel != null) {
      _hospitalModelList.clear();
      _hospitalModelList.add(_hospitalModel);
      setState(() {});
    }
  }

  void _saveHospital(HospitalModel hospitalModel) {
    _selectedHospitalId = hospitalModel.id;
    _hospitalAddressController.text = hospitalModel.hospitalAddress;
    _hospitalNameController.text = hospitalModel.hospitalName;
    registrationController.sethospitalAddress(hospitalModel.hospitalAddress);
    registrationController.sethospitalName(hospitalModel.hospitalName);
    _closeDialog();
  }

  void _closeDialog() {
    Get.back();
  }

  void _saveDataToModel() {
    widget.signupModel.mci_id = registrationController.mciId.value;
    widget.signupModel.hospital_id = _selectedHospitalId;
    widget.signupModel.doctor_type = registrationController.doctorType.value;
  }

  void _gotoDoctorRegistration2Screen() {
    PageUtils.pushPage(DoctorRegistration2(signupModel: widget.signupModel));
  }
}
