import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcare/constants/reception/reception_strings.dart';
import 'package:pcare/widgets/custom_progress_indicator_widget.dart';
import 'package:pcare/widgets/receptionist/receptionist_app_bar_widget.dart';

class AcceptAppointmentRequest extends StatefulWidget {
  @override
  _AcceptAppointmentRequestState createState() =>
      _AcceptAppointmentRequestState();
}

class _AcceptAppointmentRequestState extends State<AcceptAppointmentRequest> {
  List<Map<String, dynamic>> _pendingAppointments = [
    {
      "id": "1",
      "date": "01-01-2021",
      "patient_name": "Dipen Biden",
      "age": "24",
      "appointment_time": "5:00 PM to 6:00 PM",
      "doctor_name": "non consectetur",
      "image": "https://jooinn.com/images/portrait-of-young-man-2.jpg",
    },
    {
      "id": "2",
      "date": "01-01-2021",
      "patient_name": "Ishan Suthar",
      "age": "34",
      "appointment_time": "5:00 PM to 6:00 PM",
      "doctor_name": "eleifend mi",
      "image":
          "https://t4.ftcdn.net/jpg/02/45/56/35/360_F_245563558_XH9Pe5LJI2kr7VQuzQKAjAbz9PAyejG1.jpg",
    },
    {
      "id": "3",
      "date": "02-01-2021",
      "patient_name": "Gautam Suthar",
      "age": "24",
      "appointment_time": "5:00 PM to 6:00 PM",
      "doctor_name": "massa ultricies",
      "image":
          "https://st2.depositphotos.com/4196725/6217/i/950/depositphotos_62170113-stock-photo-young-cool-black-man-no.jpg",
    },
    {
      "id": "4",
      "date": "02-01-2021",
      "patient_name": "Pranav Vyas",
      "age": "34",
      "appointment_time": "5:00 PM to 6:00 PM",
      "doctor_name": "ipsum dolor",
      "image":
          "https://adultballet.com.au/wp-content/uploads/2017/02/unnamed-1.jpg",
    },
    {
      "id": "5",
      "date": "02-01-2021",
      "patient_name": "Meet Prajapati",
      "age": "44",
      "appointment_time": "5:00 PM to 8:00 PM",
      "doctor_name": "lectus urna",
      "image":
          "https://adultballet.com.au/wp-content/uploads/2017/02/unnamed-1.jpg",
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
      title: ReceptionUniversalStrings.appointmentRequest,
    );
  }

  Widget _buildAppointmentsList() {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _pendingAppointments.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 8,
            child: Column(
              children: [
                buildUpperPart(_pendingAppointments[index]),
                buildMiddlePart(_pendingAppointments[index]),
                buildLowerPart(),
              ],
            ),
          );
        });
  }

  Widget buildUpperPart(pendingAppointment) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color(0xff2C8BFF),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Appointment Request",
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Padding(padding: EdgeInsets.only(top: 5)),
                  Icon(
                    Icons.alarm,
                    color: Colors.white,
                    size: 20,
                  ),
                ],
              ),
              SizedBox(width: 5),
              Expanded(
                flex: 0,
                child: Text(pendingAppointment["date"] + ", ",
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(color: Colors.white)),
              ),
              Expanded(
                child: Text(pendingAppointment["appointment_time"],
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildMiddlePart(pendingAppointment) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: CachedNetworkImage(
              progressIndicatorBuilder: (context, _, __) {
                return CustomProgressIndicatorWidget();
              },
              imageUrl: pendingAppointment["image"],
              height: 80,
              width: 80,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 0,
                      child: Text(
                        "Patient Name :",
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(color: Colors.black),
                      ),
                    ),
                    SizedBox(width: 4),
                    Expanded(child: Text(pendingAppointment["patient_name"])),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 0,
                      child: Text(
                        "Doctor Name :",
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(color: Colors.black),
                      ),
                    ),
                    SizedBox(width: 4),
                    Expanded(child: Text(pendingAppointment["doctor_name"])),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildLowerPart() {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            width: Get.width / 2 - 60,
            child: Center(
              child: Text(
                "ACCEPT",
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: Colors.white),
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xff2C8BFF),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            width: Get.width / 2 - 60,
            child: Center(
              child: Text(
                "DECLINE",
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: Colors.black),
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xffF3F6FF),
            ),
          ),
        ],
      ),
    );
  }
}
