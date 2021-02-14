import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcare/Utils/PageUtils.dart';
import 'package:pcare/constants/strings.dart';
import 'package:pcare/flushbar_message/flushbar_message.dart';
import 'package:pcare/store/login/doctor_registration_controller.dart';
import 'package:pcare/ui/patient/HomePage.dart';
import 'package:pcare/widgets/back_button_widget.dart';
import 'package:pcare/widgets/chip_widget.dart';
import 'package:pcare/widgets/radio_button_widget.dart';
import 'package:pcare/widgets/rectangle_button_widget.dart';
import 'package:pcare/widgets/text_field_widget.dart';

class DoctorRegistration2 extends StatefulWidget {
  // final String text;

  // SignUp({Key key, @required this.text}) : super(key: key);
  @override
  _DoctorRegistrationState2 createState() => _DoctorRegistrationState2();
}

class _DoctorRegistrationState2 extends State<DoctorRegistration2> {
  List<Map<String, dynamic>> _registrationList;
  DoctorRegistrationController registrationController =
      Get.put(DoctorRegistrationController());

  int count = 1;
  List<TextEditingController> controller = [
    new TextEditingController(),
    new TextEditingController()
  ];

  String isSpecialist = "";

  List<String> weekdays = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday"
  ];

  List<int> weekDayNumber = [];
  List<String> finalSelectedWeekDays = [];

  buildWeekDayList(String weekDay) {
    if (weekDay == "Sunday") {
      if (!weekDayNumber.contains(0)) {
        weekDayNumber.add(0);
      } else {
        var index = weekDayNumber.indexOf(0);
        weekDayNumber.removeAt(index);
      }
    } else if (weekDay == "Monday") {
      if (!weekDayNumber.contains(1)) {
        weekDayNumber.add(1);
      } else {
        var index = weekDayNumber.indexOf(1);
        weekDayNumber.removeAt(index);
      }
    } else if (weekDay == "Tuesday") {
      if (!weekDayNumber.contains(2)) {
        weekDayNumber.add(2);
      } else {
        var index = weekDayNumber.indexOf(2);
        weekDayNumber.removeAt(index);
      }
    } else if (weekDay == "Wednesday") {
      if (!weekDayNumber.contains(3)) {
        weekDayNumber.add(3);
      } else {
        var index = weekDayNumber.indexOf(3);
        weekDayNumber.removeAt(index);
      }
    } else if (weekDay == "Thursday") {
      if (!weekDayNumber.contains(4)) {
        weekDayNumber.add(4);
      } else {
        var index = weekDayNumber.indexOf(4);
        weekDayNumber.removeAt(index);
      }
    } else if (weekDay == "Friday") {
      if (!weekDayNumber.contains(5)) {
        weekDayNumber.add(5);
      } else {
        var index = weekDayNumber.indexOf(5);
        weekDayNumber.removeAt(index);
      }
    } else if (weekDay == "Saturday") {
      if (!weekDayNumber.contains(6)) {
        weekDayNumber.add(6);
      } else {
        var index = weekDayNumber.indexOf(6);
        weekDayNumber.removeAt(index);
      }
    }
    weekDayNumber.sort();

//converting number to string weekDay
    finalSelectedWeekDays.clear();
    weekDayNumber.forEach((element) {
      switch (element) {
        case 0:
          finalSelectedWeekDays.add("Sunday");
          break;
        case 1:
          finalSelectedWeekDays.add("Monday");
          break;
        case 2:
          finalSelectedWeekDays.add("Tuesday");
          break;
        case 3:
          finalSelectedWeekDays.add("Wednesday");
          break;
        case 4:
          finalSelectedWeekDays.add("Thursday");
          break;
        case 5:
          finalSelectedWeekDays.add("Friday");
          break;
        case 6:
          finalSelectedWeekDays.add("Saturday");
          break;
      }
    });
  }

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

                SizedBox(
                  height: 15,
                ),

                Container(
                  margin: EdgeInsets.only(top: 0, left: 20),
                  child: Row(
                    children: [
                      Text(
                        "Are You Specialist?",
                        style: Theme.of(context).textTheme.headline2.copyWith(
                              fontSize: 24,
                            ),
                      ),
                    ],
                  ),
                ),

                _buildRadioButton("Yes", null),

                _buildRadioButton("No", null),

                isSpecialist == "Yes"
                    ? TextFieldWidget(labelText: "Type of Specialist")
                    : Container(),

                SizedBox(
                  height: 15,
                ),

                Container(
                  margin: EdgeInsets.only(top: 0, left: 20),
                  child: Row(
                    children: [
                      Text(
                        "What are your Working Days?",
                        style: Theme.of(context).textTheme.headline2.copyWith(
                              fontSize: 24,
                            ),
                      ),
                    ],
                  ),
                ),

                ChipWidget(
                  labelList: weekdays,
                  onChipPressed: (index) {
                    buildWeekDayList(weekdays[index]);
                  },
                ),

                // SizedBox(
                //   height: 12,
                // ),
                //registration list
                // _buildList(),

                SizedBox(
                  height: 15,
                ),

                Container(
                  margin: EdgeInsets.only(top: 0, left: 20),
                  child: Row(
                    children: [
                      Text(
                        "What are your active hours?",
                        style: Theme.of(context).textTheme.headline2.copyWith(
                              fontSize: 24,
                            ),
                      ),
                    ],
                  ),
                ),

                buildTimeFields(),

                SizedBox(
                  height: 10,
                ),

                Container(
                  padding: EdgeInsets.fromLTRB(65, 0, 65, 15),
                  child: RectangleButtonWidget(
                    childText: "Add more time slots",
                    onPressed: () {
                      controller.forEach((element) {
                        print("hi yoyo here " + element.text);
                      });
                      if (controller.length != 6) {
                        controller.add(new TextEditingController());
                        controller.add(new TextEditingController());
                        setState(() {
                          count++;
                        });
                      } else {
                        FlushbarMessage.errorMessage(context,
                            "Sorry you cannot add more than 3 time slots");
                      }
                    },
                    width: Get.width,
                  ),
                ),

                Container(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
                  child: RectangleButtonWidget(
                    childText: "REGISTER",
                    onPressed: () {
                      if (registrationController.isAnyFieldEmpty()) {
                        FlushbarMessage.errorMessage(
                            context, "Please enter your details properly");
                      } else {
                        PageUtils.pushPage(HomePage());
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

  buildTimeFields() {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: count,
        itemBuilder: (context, index) {
          return Obx(() {
            return registrationController.allow.value
                ? Row(
                    children: [
                      TextFieldWidget(
                        textEditingController: controller[index + index],
                        margin: const EdgeInsets.only(
                            left: 12, right: 12, top: 0, bottom: 6),
                        labelText: "From",
                        onTap: () {
                          _generateTimePicker(
                              context, controller[index + index]);
                        },
                        width: Get.width / 2 - 50,
                      ),
                      TextFieldWidget(
                        textEditingController: controller[index + index + 1],
                        margin: const EdgeInsets.only(
                            left: 12, right: 12, top: 0, bottom: 6),
                        labelText: "To",
                        onTap: () {
                          _generateTimePicker(
                              context, controller[index + index + 1]);
                        },
                        width: Get.width / 2 - 50,
                      ),
                    ],
                  )
                : Container();
          });
        });
  }

  Widget _buildRadioButton(String text, String groupValue) {
    return RadioButtonWidget(
      itemText: text,
      groupValue: groupValue,
      iconSelected: isSpecialist.toLowerCase() == text.toLowerCase(),
      onChanged: (value) {
        setState(() {
          isSpecialist = text;
        });
      },
    );
  }

  Future<void> _generateTimePicker(
      BuildContext context, TextEditingController controller) async {
    final TimeOfDay newTime = await showTimePicker(
        context: context, initialTime: TimeOfDay(hour: 00, minute: 00));

    String hour, minute;
    if (newTime.hour < 10) {
      hour = "0" + newTime.hour.toString();
    } else {
      hour = newTime.hour.toString();
    }

    if (newTime.minute < 10) {
      minute = "0" + newTime.minute.toString();
    } else {
      minute = newTime.minute.toString();
    }

    controller.text = hour + ":" + minute;
  }
}
