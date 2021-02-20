import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pcare/constants/app_colors.dart';
import 'package:pcare/constants/strings.dart';
import 'package:pcare/widgets/back_button_widget.dart';
import 'package:pcare/widgets/custom_progress_indicator_widget.dart';
import 'package:pcare/widgets/main_app_bar_widget.dart';
import 'package:pcare/widgets/rectangle_button_widget.dart';

class ViewSingleAppointment extends StatefulWidget {
  Map<String, dynamic> appointment;

  ViewSingleAppointment({this.appointment});

  @override
  _ViewSingleAppointmentState createState() => _ViewSingleAppointmentState();
}

class _ViewSingleAppointmentState extends State<ViewSingleAppointment> {
  Map<String, dynamic> _appointment;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.appointment == null) {
      _addStaticAppointment();
    } else {
      _appointment = widget.appointment;
    }
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
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),

            Center(child: _buildProfileImage(_appointment['profile_image'])),

            SizedBox(height: 20),
            //doc name
            _doctorName(_appointment['doctor_name']),

            SizedBox(height: 10),

            //hospital name and location icon
            _hospitalNameAndIcon(_appointment['hospital_name']),

            SizedBox(height: 10),

            //appointment time
            _appointmentTime(_appointment['appointment_time']),

            SizedBox(height: 10),

            //status
            _appointmetStatus(_appointment['appointment_status']),
            SizedBox(height: 10),

            _bookingTimeAndDate(_appointment['booking_time']),

            SizedBox(
              height: 120,
            ),
            //next button
            _viewTreatmentButton()
          ],
        ),
      ),
    );
  }

  Widget _viewTreatmentButton() {
    return RectangleButtonWidget(
      childText: UniversalStrings.viewTreatment,
      onPressed: () {
        //TODO:
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
  void _addStaticAppointment() {
    _appointment = {
      "id": "1",
      "profile_image":
          "https://cdn.sanity.io/images/0vv8moc6/hcplive/0ebb6a8f0c2850697532805d09d4ff10e838a74b-200x200.jpg?auto=format",
      "doctor_name": "Dr. John Doe",
      "hospital_name": "Global Hospital",
      "appointment_time": "5:00 PM to 6:00 PM",
      "appointment_status": "Confirm",
      "booking_time": "01-02-2021 3:00 PM",
    };
  }
}
