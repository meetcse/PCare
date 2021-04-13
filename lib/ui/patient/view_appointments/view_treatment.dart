import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pcare/api/patient/treatment/GetFullTreatmentApi.dart';
import 'package:pcare/constants/app_colors.dart';
import 'package:pcare/constants/strings.dart';
import 'package:pcare/flushbar_message/flushbar_message.dart';
import 'package:pcare/models/patient/appointment/treatment/GetFullTreatmentModel.dart';
import 'package:pcare/widgets/back_button_widget.dart';
import 'package:pcare/widgets/custom_progress_indicator_widget.dart';
import 'package:pcare/widgets/main_app_bar_widget.dart';

class ViewTreatment extends StatefulWidget {
  String fullTreatmentId;
  ViewTreatment({@required this.fullTreatmentId});

  @override
  _ViewTreatmentState createState() => _ViewTreatmentState();
}

class _ViewTreatmentState extends State<ViewTreatment> {
  // List<Map<String, dynamic>> _treatmentDetails = [
  //   {
  //     "date": "20-02-2020",
  //     "details": {
  //       "disease": "Cold",
  //       "treatment": "On-Going",
  //       "prescription": "Having improvement",
  //       "special_note": "Take medicines properly"
  //     }
  //   },
  //   {
  //     "date": "15-01-2020",
  //     "details": {
  //       "disease": "COVID",
  //       "treatment": "On-Going",
  //       "prescription": "There are improvements",
  //       "special_note": "Take Nebulizer daily"
  //     }
  //   },
  //   {
  //     "date": "18-12-2020",
  //     "details": {
  //       "disease": "Lung Disorder",
  //       "treatment": "Stopped",
  //       "prescription": "Recovered Fully",
  //       "special_note": "Full Recovery is been observed"
  //     }
  //   }
  // ];

  // Map<String, dynamic> _appointmentDetails = {
  //   "patientName": "Pallav Patel",
  //   "doctorName": "Harsh Trivedi",
  //   "hospitalName": "John Doe Hospital"
  // };

  Future<GetFullTreatmentModel> _fullTreatmentModelFuture;

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

  Widget buildListForTreatmentDetails(List<Treatments> treatments) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: treatments.length,
        itemBuilder: (context, index) {
          Treatments _treatment = treatments[index];
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Expanded(
                      child: Divider(
                    endIndent: 8,
                  )),
                  Text(
                    getDateTimeInStringFromUTC(_treatment.appointmentDate),
                    style: Theme.of(context).textTheme.headline4.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                  Expanded(
                      child: Divider(
                    indent: 8,
                  )),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              buildAppointDetailsRow(
                  "Disease :", _treatment.singleTreatmentId.disease ?? ''),
              SizedBox(height: 10),
              // buildAppointDetailsRow("Treatment :",
              //     _treatment.),
              // SizedBox(height: 10),
              Flexible(
                fit: FlexFit.loose,
                child: buildAppointDetailsRow("Prescription :",
                    _treatment.singleTreatmentId.prescription ?? ''),
              ),
              SizedBox(height: 10),
              buildAppointDetailsRow("Special Note :",
                  _treatment.singleTreatmentId.specialNote ?? ''),
            ],
          );
        });
  }

  Widget buildAppointDetailsRow(String key, String value) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //Location Icon
        Text(
          key,
          style: Theme.of(context).textTheme.headline4.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
        ),

        SizedBox(
          width: 12,
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
            maxLines: 6,
            style: Theme.of(context).textTheme.headline4.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: UniversalColors.black),
          ),
        ),
      ],
    );
  }

  Widget _buildAppBar() {
    return MainAppBarWidget(
      leading: BackButtonWidget(),
      title: UniversalStrings.myTreatment,
    );
  }

  Widget _buildBody() {
    return FutureBuilder(
        future: _fullTreatmentModelFuture,
        builder:
            (context, AsyncSnapshot<GetFullTreatmentModel> fullTreatmentModel) {
          if (!fullTreatmentModel.hasData) {
            return Center(child: CustomProgressIndicatorWidget());
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
                  buildAppointDetailsRow(
                      "Patient :",
                      fullTreatmentModel.data.patientId.user.firstname +
                          " " +
                          fullTreatmentModel.data.patientId.user.lastname),
                  SizedBox(height: 5),
                  Divider(),
                  buildAppointDetailsRow(
                      "Doctor :",
                      fullTreatmentModel.data.doctorId.user.firstname +
                          " " +
                          fullTreatmentModel.data.doctorId.user.lastname),
                  SizedBox(height: 5),
                  Divider(),
                  buildAppointDetailsRow(
                      "Hospital :",
                      fullTreatmentModel
                          .data.doctorId.hospital_id.hospitalName),
                  SizedBox(height: 14),
                  Text(
                    UniversalStrings.yourTreatmentsAccToDate,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headline2
                        .copyWith(fontSize: 22),
                  ),
                  SizedBox(height: 4),
                  buildListForTreatmentDetails(
                      fullTreatmentModel.data.treatments),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _callApi() {
    GetFullTreatmentApi _api = GetFullTreatmentApi();
    _fullTreatmentModelFuture =
        _api.getFullTreatment(widget.fullTreatmentId).catchError((error) {
      print("ERROR in getting full treatment : " + error.toString());
      FlushbarMessage.errorMessage(Get.context, error.toString());
    });
  }

  String getDateTimeInStringFromUTC(String dateTime) {
    DateTime _dateTime = DateTime.parse(dateTime);
    DateTime dateLocal = _dateTime.toLocal();

    String _format = DateFormat("dd-MM-yyyy").format(dateLocal);

    return _format.toString();
  }
}
