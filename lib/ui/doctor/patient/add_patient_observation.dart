import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pcare/constants/app_colors.dart';
import 'package:pcare/constants/doctor/doctor_strings.dart';
import 'package:pcare/constants/strings.dart';
import 'package:pcare/widgets/custom_progress_indicator_widget.dart';
import 'package:pcare/widgets/text_field_widget.dart';

class AddPatientObservation extends StatefulWidget {
  @override
  _AddPatientObservationState createState() => _AddPatientObservationState();
}

class _AddPatientObservationState extends State<AddPatientObservation> {
  Map<String, dynamic> patientDetails = {
    "image":
        "https://images.theconversation.com/files/304957/original/file-20191203-66986-im7o5.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=1200&h=1200.0&fit=crop",
    "name": "nullam eget",
    "mobileNumber": "1234567890",
    "address":
        "facilisi etiam dignissim diam quis enim lobortis scelerisque fermentum dui",
    "gender": "male",
    "dob": "05-02-2021",
    "age": "26"
  };

  List<Map<String, dynamic>> todaysAppointment = [
    {
      "image":
          "https://images.theconversation.com/files/304957/original/file-20191203-66986-im7o5.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=1200&h=1200.0&fit=crop",
      "patientName": "in nisl",
      "age": "21"
    },
    {
      "image":
          "https://images.theconversation.com/files/304957/original/file-20191203-66986-im7o5.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=1200&h=1200.0&fit=crop",
      "patientName": "diam phasellus",
      "age": "31"
    },
    {
      "image":
          "https://images.theconversation.com/files/304957/original/file-20191203-66986-im7o5.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=1200&h=1200.0&fit=crop",
      "patientName": "lacus laoreet",
      "age": "41"
    },
    {
      "image":
          "https://images.theconversation.com/files/304957/original/file-20191203-66986-im7o5.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=1200&h=1200.0&fit=crop",
      "patientName": "congue quisque",
      "age": "51"
    },
    {
      "image":
          "https://images.theconversation.com/files/304957/original/file-20191203-66986-im7o5.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=1200&h=1200.0&fit=crop",
      "patientName": "interdum velit",
      "age": "61"
    },
    {
      "image":
          "https://images.theconversation.com/files/304957/original/file-20191203-66986-im7o5.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=1200&h=1200.0&fit=crop",
      "patientName": "lectus quam",
      "age": "71"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      backgroundColor: UniversalColors.whiteColor,
    );
  }

  Widget _buildBody() {
    return LayoutBuilder(
      builder: (context, constraint) => constraint.maxWidth < 1104
          ? Center(
              child: Text(
                UniversalStrings.webBrowserError,
                style: Theme.of(context).textTheme.headline1.copyWith(
                      color: UniversalColors.darkBlue,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildPatientDetailsCard(),
                SizedBox(width: 20),
                buildObservationsCard(),
                SizedBox(width: 20),
                buildTodaysAppointmentsCard()
              ],
            ),
    );
  }

  Widget buildPatientDetailsCard() {
    return Expanded(
      child: Card(
        margin: EdgeInsets.only(left: 30, top: 30),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: CachedNetworkImage(
                    progressIndicatorBuilder: (context, _, __) {
                      return CustomProgressIndicatorWidget();
                    },
                    imageUrl: patientDetails["image"],
                    height: 100,
                    width: 100,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  patientDetails["name"],
                  style: Theme.of(context).textTheme.headline1.copyWith(
                        color: UniversalColors.darkBlue,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                SizedBox(height: 20),
                Text(patientDetails["mobileNumber"],
                    style: Theme.of(context).textTheme.headline4),
                SizedBox(height: 20),
                Text(patientDetails["address"],
                    style: Theme.of(context).textTheme.headline4),
                SizedBox(height: 20),
                Text(patientDetails["gender"],
                    style: Theme.of(context).textTheme.headline4),
                SizedBox(height: 20),
                Text(patientDetails["dob"],
                    style: Theme.of(context).textTheme.headline4),
                SizedBox(height: 20),
                Text(patientDetails["age"],
                    style: Theme.of(context).textTheme.headline4)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildObservationsCard() {
    return Expanded(
      flex: 3,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Row(
              children: [
                SizedBox(width: 30),
                Text(DoctorUniversalStrings.enterPrescription,
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(color: UniversalColors.darkBlue)),
              ],
            ),
            TextFieldWidget(labelText: ""),
            SizedBox(height: 10),
            Row(
              children: [
                SizedBox(width: 30),
                Text(DoctorUniversalStrings.enterDisease,
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(color: UniversalColors.darkBlue)),
              ],
            ),
            TextFieldWidget(labelText: ""),
            SizedBox(height: 10),
            Row(
              children: [
                SizedBox(width: 30),
                Text(DoctorUniversalStrings.enterSpecialNote,
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(color: UniversalColors.darkBlue)),
              ],
            ),
            TextFieldWidget(labelText: ""),
            SizedBox(height: 10),
            Row(
              children: [
                SizedBox(width: 30),
                Text(DoctorUniversalStrings.enterExperiments,
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(color: UniversalColors.darkBlue)),
              ],
            ),
            TextFieldWidget(labelText: ""),
            SizedBox(height: 10),
            Row(
              children: [
                SizedBox(width: 30),
                Text(DoctorUniversalStrings.enterObservation,
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(color: UniversalColors.darkBlue)),
              ],
            ),
            TextFieldWidget(labelText: ""),
          ],
        ),
      ),
    );
  }

  Widget buildTodaysAppointmentsCard() {
    return Expanded(
      flex: 1,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        margin: EdgeInsets.only(right: 30, top: 30, bottom: 30),
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              DoctorUniversalStrings.todaysAppointment,
              style:
                  Theme.of(context).textTheme.headline4.copyWith(fontSize: 16),
            ),
            buildAppointmentList(),
          ],
        ),
      ),
    );
  }

  Widget buildAppointmentList() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemCount: todaysAppointment.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 14),
              child: Column(
                children: [
                  Divider(),
                  _appointmentCard(
                    todaysAppointment[index]["image"],
                    todaysAppointment[index]["patientName"],
                    todaysAppointment[index]["age"],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _appointmentCard(
    String imagePath,
    String patientName,
    String age,
  ) {
    return GestureDetector(
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
                  SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
                    decoration: BoxDecoration(
                      color: UniversalColors.yellow,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      DoctorUniversalStrings.nextAppointment,
                      style: Theme.of(context).textTheme.headline5.copyWith(
                            fontSize: 14,
                            color: UniversalColors.whiteColor,
                          ),
                    ),
                  )
                ],
              ),
            ),
          ),
          // Spacer(),
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
        height: 70,
        width: 70,
        fit: BoxFit.fill,
      ),
    );
  }
}
