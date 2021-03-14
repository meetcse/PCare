import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pcare/constants/app_colors.dart';
import 'package:pcare/constants/doctor/doctor_strings.dart';
import 'package:pcare/widgets/back_button_widget.dart';
import 'package:pcare/widgets/custom_progress_indicator_widget.dart';
import 'package:pcare/widgets/doctor/doctor_app_bar_widget.dart';
import 'package:pcare/widgets/receptionist/receptionist_app_bar_widget.dart';

class UpcomingAppointments extends StatefulWidget {
  @override
  _UpcomingAppointmentsState createState() => _UpcomingAppointmentsState();
}

class _UpcomingAppointmentsState extends State<UpcomingAppointments> {
  List<Map<String, dynamic>> _upcoming_appointments = [
    {
      "date": "01-01-2021",
      "appointments": [
        {
          "id": "1",
          "patient_name": "Dipen Biden",
          "age": "24",
          "appointment_time": "5:00 PM to 6:00 PM",
          "doctor_name": "non consectetur",
          "image": "https://jooinn.com/images/portrait-of-young-man-2.jpg",
        },
        {
          "id": "2",
          "patient_name": "Ishan Suthar",
          "age": "34",
          "appointment_time": "5:00 PM to 6:00 PM",
          "doctor_name": "eleifend mi",
          "image":
              "https://t4.ftcdn.net/jpg/02/45/56/35/360_F_245563558_XH9Pe5LJI2kr7VQuzQKAjAbz9PAyejG1.jpg",
        }
      ]
    },
    {
      "date": "02-01-2021",
      "appointments": [
        {
          "id": "3",
          "patient_name": "Gautam Suthar",
          "age": "24",
          "appointment_time": "5:00 PM to 6:00 PM",
          "doctor_name": "massa ultricies",
          "image":
              "https://st2.depositphotos.com/4196725/6217/i/950/depositphotos_62170113-stock-photo-young-cool-black-man-no.jpg",
        },
        {
          "id": "4",
          "patient_name": "Pranav Vyas",
          "age": "34",
          "appointment_time": "5:00 PM to 6:00 PM",
          "doctor_name": "ipsum dolor",
          "image":
              "https://adultballet.com.au/wp-content/uploads/2017/02/unnamed-1.jpg",
        },
        {
          "id": "5",
          "patient_name": "Meet Prajapati",
          "age": "44",
          "appointment_time": "5:00 PM to 8:00 PM",
          "doctor_name": "lectus urna",
          "image":
              "https://adultballet.com.au/wp-content/uploads/2017/02/unnamed-1.jpg",
        }
      ]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      backgroundColor: Color(0xffF3F6FF).withOpacity(0.134),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: _buildAppointmentsList(),
    );
  }

  Widget _buildAppBar() {
    return ReceptionistAppbarWidget(
      title: DoctorUniversalStrings.upcomingAppointments,
    );
  }

  Widget _buildAppointmentsList() {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _upcoming_appointments.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.date_range,
                      size: 16,
                    ),
                    SizedBox(width: 5),
                    Text(
                      _upcoming_appointments[index]["date"],
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .copyWith(fontSize: 12),
                    ),
                  ],
                ),
                _buildAppointmentCard(
                    _upcoming_appointments[index]["appointments"]),
              ],
            ),
          );
        });
  }

  Widget _buildAppointmentCard(upcoming_appointment) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: upcoming_appointment.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 14),
          child: _appointmentCard(upcoming_appointment[index]),
        );
      },
    );
  }

  Widget _appointmentCard(upcoming_appointment_card) {
    return GestureDetector(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
        elevation: 5,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //image
              _buildImage(upcoming_appointment_card["image"]),

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
                        upcoming_appointment_card["patient_name"],
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
                            upcoming_appointment_card["age"],
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
                            upcoming_appointment_card["appointment_time"],
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(fontSize: 14),
                        maxLines: 2,
                      ),
                      SizedBox(height: 4),
                      //Doctor Name
                      Text(
                        "Doctor Name : " +
                            upcoming_appointment_card["doctor_name"],
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
        ),
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
}
