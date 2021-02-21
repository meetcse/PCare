import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcare/Utils/PageUtils.dart';
import 'package:pcare/constants/app_colors.dart';
import 'package:pcare/flushbar_message/flushbar_message.dart';
import 'package:pcare/ui/patient/HomePage.dart';
import 'package:pcare/widgets/back_button_widget.dart';
import 'package:pcare/widgets/chip_widget.dart';
import 'package:pcare/widgets/main_app_bar_widget.dart';
import 'package:pcare/widgets/radio_button_widget.dart';
import 'package:pcare/widgets/rectangle_button_widget.dart';
import 'package:pcare/widgets/text_field_widget.dart';

class DoctorRegistration2 extends StatefulWidget {
  @override
  _DoctorRegistrationState2 createState() => _DoctorRegistrationState2();
}

class _DoctorRegistrationState2 extends State<DoctorRegistration2> {
  int count = 1;

  TextEditingController specialistController = new TextEditingController();

  List<TextEditingController> controller = [
    new TextEditingController(),
    new TextEditingController()
  ];

  String isSpecialist = "";

  List<String> selectedDay = List<String>();

  String typeOfSpecialist = "";

  List<String> timings = [];

  List<int> weekDayNumber = [];

  List<String> weekdays = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday"
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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

  buildTimeFields() {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: count,
        itemBuilder: (context, index) {
          return Row(
            children: [
              TextFieldWidget(
                readOnly: true,
                textEditingController: controller[index + index],
                margin: const EdgeInsets.only(
                    left: 12, right: 12, top: 0, bottom: 6),
                labelText: "From",
                onTap: () {
                  _generateTimePicker(context, controller[index + index]);
                },
                width: Get.width / 2 - 50,
              ),
              TextFieldWidget(
                readOnly: true,
                textEditingController: controller[index + index + 1],
                margin: const EdgeInsets.only(
                    left: 12, right: 12, top: 0, bottom: 6),
                labelText: "To",
                onTap: () {
                  _generateTimePicker(context, controller[index + index + 1]);
                },
                width: Get.width / 2 - 50,
              ),
            ],
          );
        });
  }

  buildWeekDayList() {
    print("SELECTED 1: " + selectedDay.toString());
    weekDayNumber.clear();
    selectedDay.forEach((element) {
      if (element == "Sunday") {
        weekDayNumber.add(0);
      } else if (element == "Monday") {
        weekDayNumber.add(1);
      } else if (element == "Tuesday") {
        weekDayNumber.add(2);
      } else if (element == "Wednesday") {
        weekDayNumber.add(3);
      } else if (element == "Thursday") {
        weekDayNumber.add(4);
      } else if (element == "Friday") {
        weekDayNumber.add(5);
      } else if (element == "Saturday") {
        weekDayNumber.add(6);
      }
    });
    weekDayNumber.sort();

//converting number to string weekDay
    print("SELECTED 2: " + selectedDay.toString());
    selectedDay.clear();
    weekDayNumber.forEach((element) {
      switch (element) {
        case 0:
          selectedDay.add("Sunday");
          break;
        case 1:
          selectedDay.add("Monday");
          break;
        case 2:
          selectedDay.add("Tuesday");
          break;
        case 3:
          selectedDay.add("Wednesday");
          break;
        case 4:
          selectedDay.add("Thursday");
          break;
        case 5:
          selectedDay.add("Friday");
          break;
        case 6:
          selectedDay.add("Saturday");
          break;
      }
    });
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
                    ? TextFieldWidget(
                        labelText: "Type of Specialist",
                        textEditingController: specialistController,
                      )
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
                  chipBgColor: UniversalColors.doctorListBackgroundColor,
                  chipSelectedBgColor: UniversalColors.gradientColorStart,
                  selectedLabelStyle:
                      Theme.of(Get.context).textTheme.button.copyWith(
                            fontSize: 14,
                            color: UniversalColors.whiteColor,
                            fontWeight: FontWeight.w300,
                          ),
                  labelStyle:
                      Theme.of(Get.context).textTheme.headline6.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                          ),
                  isCompare: true,
                  compareText: selectedDay.toString(),
                  onChipPressed: (weekDay) {
                    if (selectedDay.contains(weekDay)) {
                      selectedDay.removeWhere((element) => element == weekDay);
                    } else {
                      selectedDay.add(weekDay);
                    }
                    setState(() {});
                  },
                ),

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
                      String fromTime, toTime;
                      int counter = 1;
                      controller.forEach((element) {
                        if (counter != 2) {
                          counter++;
                          fromTime = element.text;
                        } else {
                          toTime = element.text;
                          timings.add(fromTime + " to " + toTime);
                          counter = 1;
                        }
                      });
                      if (isSpecialist == "Yes") {
                        typeOfSpecialist = specialistController.text;
                      }
                      if (selectedDay.length == 0 ||
                              timings.length == 0 ||
                              isSpecialist == "" ||
                              isSpecialist == "Yes"
                          ? typeOfSpecialist == ""
                          : false) {
                        FlushbarMessage.errorMessage(
                            context, "Please enter your details properly");
                      } else {
                        buildWeekDayList();
                        print("selected " + selectedDay.toString());
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
        SizedBox(
          height: 20,
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
}
