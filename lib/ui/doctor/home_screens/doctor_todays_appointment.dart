import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pcare/constants/app_colors.dart';
import 'package:pcare/constants/app_icons.dart';
import 'package:pcare/constants/doctor/doctor_strings.dart';
import 'package:pcare/widgets/custom_progress_indicator_widget.dart';
import 'package:pcare/widgets/doctor/doctor_app_bar_widget.dart';
import 'package:pcare/widgets/main_app_bar_widget.dart';

class DoctorTodaysAppointment extends StatefulWidget {
  @override
  _DoctorTodaysAppointmentState createState() =>
      _DoctorTodaysAppointmentState();
}

class _DoctorTodaysAppointmentState extends State<DoctorTodaysAppointment> {
  Map<String, dynamic> _doctor = {
    "name": "Dr. John Doe",
  };
  Map<String, dynamic> _currentAppointment = {
    "id": "1",
    "patient_name": "Pallav Patel",
    "age": "32",
    "appointment_time": "5:00 PM to 6:00 PM",
    "image":
        "https://images.pexels.com/photos/1080213/pexels-photo-1080213.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
  };

  Map<String, dynamic> _nextAppointment = {
    "id": "2",
    "patient_name": "Gautam Vyas",
    "age": "21",
    "appointment_time": "5:00 PM to 6:00 PM",
    "image":
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSCexMzvTjX8oflMcyjjCL8JaeeKwqsmanIuw&usqp=CAU",
  };

  List<Map<String, dynamic>> _todaysAppointment = [
    {
      "id": "11",
      "patient_name": "Pranav Suthar",
      "age": "28",
      "appointment_time": "5:00 PM to 6:00 PM",
      "image":
          "https://adultballet.com.au/wp-content/uploads/2017/02/unnamed-1.jpg",
    },
    {
      "id": "12",
      "patient_name": "Dipen Biden",
      "age": "24",
      "appointment_time": "5:00 PM to 6:00 PM",
      "image": "https://jooinn.com/images/portrait-of-young-man-2.jpg",
    },
    {
      "id": "13",
      "patient_name": "Ishan Suthar",
      "age": "25",
      "appointment_time": "5:00 PM to 6:00 PM",
      "image":
          "https://t4.ftcdn.net/jpg/02/45/56/35/360_F_245563558_XH9Pe5LJI2kr7VQuzQKAjAbz9PAyejG1.jpg",
    },
    {
      "id": "14",
      "patient_name": "Gautam Suthar",
      "age": "28",
      "appointment_time": "6:00 PM to 7:00 PM",
      "image":
          "https://t4.ftcdn.net/jpg/03/03/54/59/360_F_303545914_XLEAix36kSd78qCl4XYhl2S1iYSA9IyW.jpg",
    },
    {
      "id": "15",
      "patient_name": "Pranav Vyas",
      "age": "34",
      "appointment_time": "6:00 PM to 7:00 PM",
      "image":
          "https://st2.depositphotos.com/4196725/6217/i/950/depositphotos_62170113-stock-photo-young-cool-black-man-no.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildChildWidget(),
      backgroundColor: UniversalColors.whiteColor,
    );
  }

  Widget _buildAppBar() {
    return DoctorAppbarWidget(
      title: _doctor['name'],
    );
  }

  Widget _buildChildWidget() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            //todays appointments
            _todaysAppointmentText(),

            SizedBox(
              height: 20,
            ),

            //running
            _dividerWithText(DoctorUniversalStrings.onGoing),

            SizedBox(
              height: 20,
            ),

            //on going appointments
            _buildonGoingAppointments(_currentAppointment),

            SizedBox(
              height: 20,
            ),

            //next
            _dividerWithText(DoctorUniversalStrings.nextAppointment),

            SizedBox(
              height: 20,
            ),

            _buildNextAppointment(_nextAppointment),

            SizedBox(
              height: 20,
            ),

            //today's
            _dividerWithText(DoctorUniversalStrings.todaysAppointment),
            SizedBox(
              height: 20,
            ),

            _buildTodaysAppointment(_todaysAppointment),

            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTodaysAppointment(List<Map<String, dynamic>> todaysAppointment) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: todaysAppointment.length,
      itemBuilder: (context, index) {
        Map<String, dynamic> _appointment = todaysAppointment[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 14),
          child: _appointmentCard(
            _appointment['image'],
            _appointment['patient_name'],
            _appointment['age'],
            false,
            false,
            _appointment['appointment_time'],
          ),
        );
      },
    );
  }

  Widget _buildNextAppointment(Map<String, dynamic> nextAppointment) {
    return _appointmentCard(
      nextAppointment['image'],
      nextAppointment['patient_name'],
      nextAppointment['age'],
      false,
      true,
      nextAppointment['appointment_time'],
    );
  }

  Widget _buildonGoingAppointments(Map<String, dynamic> currentAppointment) {
    return _appointmentCard(
      currentAppointment['image'],
      currentAppointment['patient_name'],
      currentAppointment['age'],
      true,
      false,
      currentAppointment['appointment_time'],
    );
  }

  Widget _appointmentCard(String imagePath, String patientName, String age,
      bool isRunning, bool isNext, String appointmentTime,
      {Function onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //image
          _buildImage(imagePath),

          SizedBox(
            width: 12,
          ),

          //details
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(right: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    patientName,
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(fontSize: 16),
                  ),

                  SizedBox(
                    height: 4,
                  ),

                  //age
                  Text(
                    DoctorUniversalStrings.age + ' : ' + age,
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(fontSize: 14),
                  ),

                  SizedBox(
                    height: 4,
                  ),
                  //Appointment time
                  Text(
                    DoctorUniversalStrings.appointTime +
                        ' : ' +
                        appointmentTime,
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(fontSize: 14),
                    maxLines: 2,
                  ),

                  SizedBox(
                    height: 8,
                  ),

                  isRunning
                      ? Container(
                          padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
                          decoration: BoxDecoration(
                            color: UniversalColors.green,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            DoctorUniversalStrings.onGoing,
                            style:
                                Theme.of(context).textTheme.headline5.copyWith(
                                      fontSize: 14,
                                      color: UniversalColors.whiteColor,
                                    ),
                          ),
                        )
                      : isNext
                          ? Container(
                              padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
                              decoration: BoxDecoration(
                                color: UniversalColors.yellow,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                DoctorUniversalStrings.nextAppointment,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    .copyWith(
                                      fontSize: 14,
                                      color: UniversalColors.whiteColor,
                                    ),
                              ),
                            )
                          : Container(),

                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          ),
          // Spacer(),

          isRunning
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    _buildForwardIcon(),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _todaysAppointmentText() {
    return Text(
      DoctorUniversalStrings.todaysAppointment,
      style: Theme.of(context).textTheme.headline4.copyWith(
            color: UniversalColors.black,
          ),
    );
  }

  Widget _buildForwardIcon() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: UniversalColors.gradientColorStart,
        shape: BoxShape.circle,
      ),
      child: Icon(
        UniversalIcons.forwardArrow,
        color: UniversalColors.whiteColor,
      ),
    );
  }

  Widget _dividerWithText(String text) {
    return Row(
      children: [
        SizedBox(
          width: 40,
          child: Divider(
            endIndent: 6,
          ),
        ),

        //text
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(fontWeight: FontWeight.w700),
        ),

        Expanded(
            child: Divider(
          indent: 6,
        )),
      ],
    );
  }

  Widget _buildImage(String imagePath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: CachedNetworkImage(
        progressIndicatorBuilder: (context, _, __) {
          return CustomProgressIndicatorWidget();
        },
        imageUrl: imagePath,
        height: 100,
        width: 100,
        fit: BoxFit.fill,
      ),
    );
  }
}
