import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcare/api/doctor/add_patient_observation.dart';
import 'package:pcare/constants/app_colors.dart';
import 'package:pcare/constants/doctor/doctor_strings.dart';
import 'package:pcare/constants/strings.dart';
import 'package:pcare/flushbar_message/flushbar_message.dart';
import 'package:pcare/models/doctor/UpcomingAppointmentModel.dart';
import 'package:pcare/widgets/custom_progress_indicator_widget.dart';
import 'package:pcare/widgets/rectangle_button_widget.dart';
import 'package:pcare/widgets/text_field_widget.dart';

class AddPatientObservation extends StatefulWidget {
  List<UpcomingAppointmentModel> data;

  AddPatientObservation({this.data});

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

  List<TextEditingController> _controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        body: _buildBody(),
        backgroundColor: UniversalColors.whiteColor,
      ),
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
                buildPatientDetailsCard(context),
                SizedBox(width: 20),
                buildObservationsCard(),
                SizedBox(width: 20),
                buildTodaysAppointmentsCard()
              ],
            ),
    );
  }

  Widget buildPatientDetailsCard(context) {
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
                    imageUrl: widget.data[0].patient_id.user.profilePic,
                    height: 100,
                    width: 100,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "${widget.data[0].patient_id.user.firstname} ${widget.data[0].patient_id.user.lastname}",
                  style: Theme.of(context).textTheme.headline1.copyWith(
                        color: UniversalColors.darkBlue,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                SizedBox(height: 20),
                Text(widget.data[0].patient_id.user.mobilenumber,
                    style: Theme.of(context).textTheme.headline4),
                SizedBox(height: 20),
                Text(
                    "${widget.data[0].patient_id.user.address.houseno}, ${widget.data[0].patient_id.user.address.society}, ${widget.data[0].patient_id.user.address.area}, ${widget.data[0].patient_id.user.address.city}, ${widget.data[0].patient_id.user.address.state}, ${widget.data[0].patient_id.user.address.country}",
                    style: Theme.of(context).textTheme.headline4),
                SizedBox(height: 20),
                Text(widget.data[0].patient_id.user.gender,
                    style: Theme.of(context).textTheme.headline4),
                SizedBox(height: 20),
                Text(widget.data[0].patient_id.user.dob.split("T")[0],
                    style: Theme.of(context).textTheme.headline4),
                SizedBox(height: 20),
                Text(widget.data[0].patient_id.user.age,
                    style: Theme.of(context).textTheme.headline4),
                // SizedBox(height: 20),
                // TextButton(
                //     onPressed: () {
                //       Navigator.pop(context);
                //     },
                //     child: Text(
                //       "Back",
                //       style: TextStyle(fontSize: 20),
                //     ))
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
            TextFieldWidget(
                labelText: "", textEditingController: _controllers[0]),
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
            TextFieldWidget(
                labelText: "", textEditingController: _controllers[1]),
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
            TextFieldWidget(
                labelText: "", textEditingController: _controllers[2]),
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
            TextFieldWidget(
                labelText: "", textEditingController: _controllers[3]),
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
            TextFieldWidget(
                labelText: "", textEditingController: _controllers[4]),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 250),
              child: RectangleButtonWidget(
                onPressed: _callApi,
                childText: UniversalStrings.submit,
                width: double.infinity,
              ),
            ),
            // TextButton(
            //   onPressed: _callApi,
            //   child: Text(
            //     "Submit",
            //     style: TextStyle(
            //       fontSize: 20,
            //     ),
            //   ),
            // )
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
          itemCount: widget.data.length - 1,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 14),
              child: Column(
                children: [
                  Divider(),
                  _appointmentCard(
                    widget.data[index + 1].patient_id.user.profilePic,
                    "${widget.data[index + 1].patient_id.user.firstname} ${widget.data[index + 1].patient_id.user.lastname}",
                    widget.data[index + 1].patient_id.user.age,
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

  void _callApi() {
    try {
      AddPatientObservationApi addPatientObservationApi =
          AddPatientObservationApi();

      Future<String> response = addPatientObservationApi.saveTreatmentDetails(
          widget.data[0].id,
          _controllers[0].text,
          _controllers[1].text,
          _controllers[2].text,
          _controllers[3].text,
          _controllers[4].text);

      response.then(
        (value) {
          if (value.contains("successfully")) {
            Navigator.pop(Get.context);
            FlushbarMessage.successMessage(Get.context, value);
          } else {
            FlushbarMessage.errorMessage(Get.context, value);
          }
        },
      );
    } catch (error) {
      print("Error : " + error);
    }
  }
}
