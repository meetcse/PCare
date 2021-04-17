import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcare/Utils/PageUtils.dart';
import 'package:pcare/api/doctor/todays_appointment.dart';
import 'package:pcare/constants/app_colors.dart';
import 'package:pcare/constants/app_icons.dart';
import 'package:pcare/constants/doctor/doctor_strings.dart';
import 'package:pcare/models/doctor/UpcomingAppointmentModel.dart';
import 'package:pcare/store/login/login_controller.dart';
import 'package:pcare/ui/doctor/patient/add_patient_observation.dart';
import 'package:pcare/widgets/custom_progress_indicator_widget.dart';
import 'package:pcare/widgets/doctor/doctor_app_bar_widget.dart';

class DoctorTodaysAppointment extends StatefulWidget {
  @override
  _DoctorTodaysAppointmentState createState() =>
      _DoctorTodaysAppointmentState();
}

class _DoctorTodaysAppointmentState extends State<DoctorTodaysAppointment> {
  Future<List<UpcomingAppointmentModel>> _upcomingAppointmentModelFuture;
  LoginController _loginController = Get.find<LoginController>();
  @override
  void initState() {
    super.initState();
    _callApi();
  }

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
      title: _loginController.loginModel.doctorDetails.user.firstname +
          " " +
          _loginController.loginModel.doctorDetails.user.lastname,
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
            // _todaysAppointmentText(),

            // SizedBox(
            //   height: 20,
            // ),

            // //running
            // _dividerWithText(DoctorUniversalStrings.onGoing),

            // SizedBox(
            //   height: 20,
            // ),

            // //on going appointments
            // _buildonGoingAppointments(_currentAppointment),

            // SizedBox(
            //   height: 20,
            // ),

            // //next
            // _dividerWithText(DoctorUniversalStrings.nextAppointment),

            // SizedBox(
            //   height: 20,
            // ),

            // _buildNextAppointment(_nextAppointment),

            // SizedBox(
            //   height: 20,
            // ),

            //today's
            _dividerWithText(DoctorUniversalStrings.todaysAppointment),
            SizedBox(
              height: 20,
            ),

            _buildTodaysAppointment(),

            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTodaysAppointment() {
    String a = "H";
    a.toLowerCase();
    return FutureBuilder(
      future: _upcomingAppointmentModelFuture,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Container(
            margin: const EdgeInsets.only(top: 120),
            child: CustomProgressIndicatorWidget(),
          );
        }
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 14),
              child: _appointmentCard(
                snapshot.data[index].patient_id.user.profilePic,
                snapshot.data[index].patient_id.user.firstname +
                    " " +
                    snapshot.data[index].patient_id.user.lastname,
                snapshot.data[index].patient_id.user.age,
                (snapshot.data[index].status.toLowerCase() == "pending")
                    ? true
                    : false,
                (snapshot.data[index].status.toLowerCase() == "next")
                    ? true
                    : false,
                snapshot.data[index].appointment_time,
                onPressed: () {
                  if (snapshot.data[index].status.toLowerCase() == "pending") {
                    PageUtils.pushPage(
                        AddPatientObservation(data: snapshot.data));
                  }
                },
              ),
            );
          },
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
      onPressed: () {
        PageUtils.pushPage(AddPatientObservation());
      },
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

  //methods and on clicks
  void _callApi() {
    TodaysAppointmentApi _todaysAppointmentApi = TodaysAppointmentApi();

    try {
      _upcomingAppointmentModelFuture =
          _todaysAppointmentApi.getTodaysAppointment();
    } catch (error) {
      print("Error " + error);
    }
  }
}
