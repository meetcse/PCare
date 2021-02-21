import 'package:flutter/material.dart';
import 'package:pcare/constants/app_colors.dart';
import 'package:pcare/constants/strings.dart';
import 'package:pcare/widgets/back_button_widget.dart';
import 'package:pcare/widgets/main_app_bar_widget.dart';

class ViewTreatment extends StatefulWidget {
  ViewTreatment();

  @override
  _ViewTreatmentState createState() => _ViewTreatmentState();
}

class _ViewTreatmentState extends State<ViewTreatment> {
  List<Map<String, dynamic>> _treatmentDetails = [
    {
      "date": "20-02-2020",
      "details": {
        "disease": "Cold",
        "treatment": "On-Going",
        "prescription": "Having improvement",
        "special_note": "Take medicines properly"
      }
    },
    {
      "date": "15-01-2020",
      "details": {
        "disease": "COVID",
        "treatment": "On-Going",
        "prescription": "There are improvements",
        "special_note": "Take Nebulizer daily"
      }
    },
    {
      "date": "18-12-2020",
      "details": {
        "disease": "Lung Disorder",
        "treatment": "Stopped",
        "prescription": "Recovered Fully",
        "special_note": "Full Recovery is been observed"
      }
    }
  ];

  Map<String, dynamic> _appointmentDetails = {
    "patientName": "Pallav Patel",
    "doctorName": "Harsh Trivedi",
    "hospitalName": "John Doe Hospital"
  };

  Widget buildListForTreatmentDetails() {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _treatmentDetails.length,
        itemBuilder: (context, index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(child: Divider()),
                  Text(
                    _treatmentDetails[index]["date"],
                    style: Theme.of(context).textTheme.headline4.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              buildAppointDetailsRow(
                  "Disease :", _treatmentDetails[index]["details"]["disease"]),
              SizedBox(height: 10),
              buildAppointDetailsRow("Treatment :",
                  _treatmentDetails[index]["details"]["treatment"]),
              SizedBox(height: 10),
              Flexible(
                fit: FlexFit.loose,
                child: buildAppointDetailsRow("Prescription :",
                    _treatmentDetails[index]["details"]["prescription"]),
              ),
              SizedBox(height: 10),
              buildAppointDetailsRow("Special Note :",
                  _treatmentDetails[index]["details"]["special_note"]),
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
      title: UniversalStrings.myTreatment,
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
            buildAppointDetailsRow(
                "Patient :", _appointmentDetails["patientName"]),
            SizedBox(height: 5),
            Divider(),
            buildAppointDetailsRow(
                "Doctor :", _appointmentDetails["doctorName"]),
            SizedBox(height: 5),
            Divider(),
            buildAppointDetailsRow(
                "Hospital :", _appointmentDetails["hospitalName"]),
            SizedBox(height: 10),
            Text(
              UniversalStrings.yourTreatmentsAccToDate,
              textAlign: TextAlign.center,
              style:
                  Theme.of(context).textTheme.headline2.copyWith(fontSize: 22),
            ),
            SizedBox(height: 10),
            buildListForTreatmentDetails(),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
