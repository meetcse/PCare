import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pcare/Utils/PageUtils.dart';
import 'package:pcare/api/patient/appointment/GetCurrentAppointmentAPI.dart';
import 'package:pcare/constants/app_colors.dart';
import 'package:pcare/constants/strings.dart';
import 'package:pcare/flushbar_message/flushbar_message.dart';
import 'package:pcare/models/patient/appointment/AppointmentModel.dart';
import 'package:pcare/ui/patient/view_appointments/view_treatment.dart';
import 'package:pcare/widgets/back_button_widget.dart';
import 'package:pcare/widgets/custom_progress_indicator_widget.dart';
import 'package:pcare/widgets/main_app_bar_widget.dart';
import 'package:pcare/widgets/rectangle_button_widget.dart';

class ViewSingleAppointment extends StatefulWidget {
  @override
  _ViewSingleAppointmentState createState() => _ViewSingleAppointmentState();
}

class _ViewSingleAppointmentState extends State<ViewSingleAppointment> {
  Future<AppointmentModel> _appointmentModelFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _callApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildAppBar() {
    return MainAppBarWidget(
      leading: BackButtonWidget(),
      title: UniversalStrings.yourAppointment,
    );
  }

  Widget _buildBody() {
    return FutureBuilder(
        future: _appointmentModelFuture,
        builder: (context, AsyncSnapshot<AppointmentModel> appointmentModel) {
          if (!appointmentModel.hasData) {
            return CustomProgressIndicatorWidget();
          }

          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),

                  Center(
                      child: _buildProfileImage(
                          appointmentModel.data.doctorId.user.profilePic)),

                  SizedBox(height: 20),
                  //doc name
                  _doctorName(appointmentModel.data.doctorId.user.firstname +
                      " " +
                      appointmentModel.data.doctorId.user.lastname),

                  SizedBox(height: 10),

                  //hospital name and location icon
                  _hospitalNameAndIcon(
                      appointmentModel.data.doctorId.hospital_id.hospitalName),

                  SizedBox(height: 10),

                  //appointment time
                  _appointmentTime(appointmentModel.data.appointmentTime),

                  SizedBox(height: 10),

                  //status
                  _appointmetStatus(appointmentModel.data.status),
                  SizedBox(height: 10),

                  _bookingTimeAndDate(getDateTimeInStringFromUTC(
                      appointmentModel.data.createddate)),

                  SizedBox(
                    height: 120,
                  ),
                  //next button
                  (appointmentModel.data.full_treatment_id != null &&
                          appointmentModel.data.full_treatment_id.isNotEmpty)
                      ? _viewTreatmentButton(
                          appointmentModel.data.full_treatment_id)
                      : Container(),
                ],
              ),
            ),
          );
        });
  }

  Widget _viewTreatmentButton(String fullTreatmentId) {
    return RectangleButtonWidget(
      childText: UniversalStrings.viewTreatment,
      onPressed: () {
        _gotoViewTreatmentScreen(fullTreatmentId);
      },
    );
  }

  Widget _buildProfileImage(String imagePath) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: UniversalColors.gradientColorStart,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(100),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: CachedNetworkImage(
          progressIndicatorBuilder: (context, _, __) {
            return CustomProgressIndicatorWidget();
          },
          imageUrl: imagePath,
          height: 150,
          width: 150,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _doctorName(
    String doctorName,
  ) {
    return Text(
      doctorName,
      style: Theme.of(context).textTheme.headline2.copyWith(fontSize: 28),
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _hospitalNameAndIcon(String hospitalName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          hospitalName,
          style: Theme.of(context).textTheme.headline5,
          overflow: TextOverflow.ellipsis,
        ),

        //icon
        Container(
          // padding: const EdgeInsets.all(4),
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(4),
          //   color: UniversalColors.yellow,
          // ),
          child: Icon(
            Icons.location_on_outlined,
            // color: UniversalColors.gradientColorStart,
            size: 24,
          ),
        ),
      ],
    );
  }

  Widget _bookingTimeAndDate(String bookingTime) {
    return Text(
      UniversalStrings.bookedOn + ' ' + bookingTime,
      style: Theme.of(context).textTheme.headline5,
    );
  }

  Widget _appointmentTime(String appointmentTime) {
    return Text(
      UniversalStrings.yourAppointmentTime + ' ' + appointmentTime,
      style: Theme.of(context).textTheme.headline5,
    );
  }

  Widget _appointmetStatus(String status) {
    if (status.toLowerCase().contains('confirm')) {
      return Text.rich(
        TextSpan(
            text: UniversalStrings.yourAppointmentIs + ' ',
            style: Theme.of(context).textTheme.headline5,
            children: [
              TextSpan(
                text: status,
                style: Theme.of(context).textTheme.headline5.copyWith(
                      color: Colors.green[700],
                      decoration: TextDecoration.underline,
                      fontStyle: FontStyle.italic,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ]),
      );
    } else if (status.toLowerCase().contains('ongoing')) {
      return Text.rich(
        TextSpan(
            text: UniversalStrings.yourAppointmentIs + ' ',
            style: Theme.of(context).textTheme.headline5,
            children: [
              TextSpan(
                text: status,
                style: Theme.of(context).textTheme.headline5.copyWith(
                      color: UniversalColors.green,
                      decoration: TextDecoration.underline,
                      fontStyle: FontStyle.italic,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ]),
      );
    } else if (status.toLowerCase().contains('process')) {
      return Text.rich(
        TextSpan(
            text: UniversalStrings.yourAppointmentIs + ' ',
            style: Theme.of(context).textTheme.headline5,
            children: [
              TextSpan(
                text: status,
                style: Theme.of(context).textTheme.headline5.copyWith(
                      color: UniversalColors.yellow,
                      decoration: TextDecoration.underline,
                      fontStyle: FontStyle.italic,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ]),
      );
    } else if (status.toLowerCase().contains('complete')) {
      return Text.rich(
        TextSpan(
            text: UniversalStrings.yourAppointmentIs + ' ',
            style: Theme.of(context).textTheme.headline5,
            children: [
              TextSpan(
                text: status,
                style: Theme.of(context).textTheme.headline5.copyWith(
                      color: UniversalColors.black,
                      // decoration: TextDecoration.underline,
                      // fontStyle: FontStyle.italic,

                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ]),
      );
    } else {
      return Text.rich(
        TextSpan(
            text: UniversalStrings.yourAppointmentIs + ' ',
            style: Theme.of(context).textTheme.headline5,
            children: [
              TextSpan(
                text: status,
                style: Theme.of(context).textTheme.headline5.copyWith(
                      color: UniversalColors.black,
                      // decoration: TextDecoration.underline,
                      // fontStyle: FontStyle.italic,

                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ]),
      );
    }
  }

//methods and on clicks
  void _callApi() {
    GetCurrentAppointmentAPI _api = GetCurrentAppointmentAPI();
    _appointmentModelFuture = _api.getCurrentAppointment().catchError((error) {
      print("ERROR IN GETTING APPOINTMENT : " + error.toString());
      FlushbarMessage.errorMessage(Get.context, error.toString());
    });
  }

  String getDateTimeInStringFromUTC(String dateTime) {
    DateTime _dateTime = DateTime.parse(dateTime);
    DateTime dateLocal = _dateTime.toLocal();

    String _format = DateFormat("dd-MM-yyyy hh:mm a").format(dateLocal);

    return _format.toString();
  }

  void _gotoViewTreatmentScreen(String fullTreatmentId) {
    PageUtils.pushPage(ViewTreatment(
      fullTreatmentId: fullTreatmentId,
    ));
  }
}
