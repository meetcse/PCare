import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pcare/api/doctor/upcoming_appointments.dart';
import 'package:pcare/constants/app_colors.dart';
import 'package:pcare/constants/doctor/doctor_strings.dart';
import 'package:pcare/models/doctor/UpcomingAppointmentModel.dart';
import 'package:pcare/widgets/back_button_widget.dart';
import 'package:pcare/widgets/custom_progress_indicator_widget.dart';
import 'package:pcare/widgets/doctor/doctor_app_bar_widget.dart';

class UpcomingAppointments extends StatefulWidget {
  @override
  _UpcomingAppointmentsState createState() => _UpcomingAppointmentsState();
}

class _UpcomingAppointmentsState extends State<UpcomingAppointments> {
  Future<List<UpcomingAppointmentModel>> _upcomingAppointmentModelFuture;

  @override
  void initState() {
    super.initState();
    _callApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      backgroundColor: UniversalColors.whiteColor,
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: _buildAppointmentsList(),
    );
  }

  Widget _buildAppointmentsList() {
    return FutureBuilder(
      future: _upcomingAppointmentModelFuture,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return (snapshot.data == null)
            ? Center(
                child: Text("loading..."),
              )
            : _buildAppointmentCard(snapshot.data);
      },
    );
  }

  Widget _buildAppBar() {
    return DoctorAppbarWidget(
      leading: BackButtonWidget(
        isBlackColor: true,
      ),
      title: DoctorUniversalStrings.upcomingAppointments,
    );
  }

  // Widget _buildAppointmentsList() {
  //   return ListView.builder(
  //       shrinkWrap: true,
  //       physics: NeverScrollableScrollPhysics(),
  //       itemCount: _upcoming_appointments.length,
  //       itemBuilder: (context, index) {
  //         return Container(
  //           padding: EdgeInsets.all(20),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 _upcoming_appointments[index]["date"],
  //               ),
  //               _buildAppointmentCard(
  //                   _upcoming_appointments[index]["appointments"]),
  //             ],
  //           ),
  //         );
  //       });
  // }

  Widget _buildAppointmentCard(upcomingAppointmentModelList) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: upcomingAppointmentModelList.length,
      itemBuilder: (context, index) {
        return Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: _appointmentCard(upcomingAppointmentModelList[index]));
      },
    );
  }

  Widget _appointmentCard(UpcomingAppointmentModel upcomingAppointmentModel) {
    return GestureDetector(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //image
          _buildImage(upcomingAppointmentModel.patient_id.user.profilePic),

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
                    upcomingAppointmentModel.patient_id.user.firstname +
                        " " +
                        upcomingAppointmentModel.patient_id.user.lastname,
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
                    DoctorUniversalStrings.age +
                        ' : ' +
                        upcomingAppointmentModel.patient_id.user.age,
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
                        upcomingAppointmentModel.appointment_time,
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(fontSize: 14),
                    maxLines: 2,
                  ),

                  Text(
                    upcomingAppointmentModel.appointment_date,
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(fontSize: 14),
                    maxLines: 2,
                  ),

                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
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
    UpcomingAppointmentsApi _upcomingAppointmentsApi =
        UpcomingAppointmentsApi();

    try {
      _upcomingAppointmentModelFuture =
          _upcomingAppointmentsApi.getUpcomingAppointments();
    } catch (error) {
      print("Error " + error);
    }
  }
}
