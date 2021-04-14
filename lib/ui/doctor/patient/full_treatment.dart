import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pcare/api/doctor/full_treatment.dart';
import 'package:pcare/constants/app_colors.dart';
import 'package:pcare/constants/strings.dart';
import 'package:pcare/models/doctor/FullTreatmentModel.dart';
import 'package:pcare/widgets/back_button_widget.dart';
import 'package:pcare/widgets/custom_progress_indicator_widget.dart';
import 'package:pcare/widgets/doctor/doctor_app_bar_widget.dart';

class FullTreatment extends StatefulWidget {
  String fullTreatmentId;

  FullTreatment({this.fullTreatmentId});
  @override
  _FullTreatmentState createState() => _FullTreatmentState();
}

class _FullTreatmentState extends State<FullTreatment> {
  Future<FullTreatmentModel> _fullTreatmentModelFuture;

  List<Map<String, dynamic>> treatments = [
    {
      "date": "01-01-2021",
      "time": "12:00 pm",
      "case": "FEVER",
      "observation":
          "nisl nunc mi ipsum faucibus vitae aliquet nec ullamcorper sit",
      "experiments":
          "consequat semper viverra nam libero justo laoreet sit amet cursus",
      "treatment":
          "vitae congue mauris rhoncus aenean vel elit scelerisque mauris pellentesque",
      "prescription":
          "nec sagittis aliquam malesuada bibendum arcu vitae elementum curabitur vitae"
    },
    {
      "date": "02-01-2021",
      "time": "02:00 pm",
      "case": "FEVER",
      "observation":
          "nisl nunc mi ipsum faucibus vitae aliquet nec ullamcorper sit",
      "experiments":
          "consequat semper viverra nam libero justo laoreet sit amet cursus",
      "treatment":
          "vitae congue mauris rhoncus aenean vel elit scelerisque mauris pellentesque",
      "prescription":
          "nec sagittis aliquam malesuada bibendum arcu vitae elementum curabitur vitae"
    },
  ];

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

  Widget _buildAppBar() {
    return DoctorAppbarWidget(
      leading: BackButtonWidget(
        isBlackColor: true,
      ),
      title: UniversalStrings.fullTreatment,
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          _buildTreatmentList(),
          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }

  Widget _buildTreatmentList() {
    return FutureBuilder(
      future: _fullTreatmentModelFuture,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return (snapshot.data == null)
            ? CustomProgressIndicatorWidget()
            : ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data.treatments.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.only(top: 25),
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.date_range,
                                  size: 18,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  snapshot
                                      .data.treatments[index].appointmentDate
                                      .split("T")[0],
                                  style: TextStyle(fontSize: 12),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            SizedBox(width: 10),
                            Row(
                              children: [
                                Icon(
                                  Icons.alarm,
                                  size: 18,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  snapshot.data.treatments[index]
                                      .singleAppointmentId.appointmentTime,
                                  style: TextStyle(fontSize: 12),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            )
                          ],
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                _buildTreatmentField(
                                  "Case",
                                  snapshot.data.treatments[index]
                                      .singleTreatmentId.disease,
                                ),
                                _buildTreatmentField(
                                  "Observation",
                                  snapshot.data.treatments[index]
                                      .singleTreatmentId.observation,
                                ),
                                _buildTreatmentField(
                                  "Experiments",
                                  snapshot.data.treatments[index]
                                      .singleTreatmentId.experiments,
                                ),
                                _buildTreatmentField(
                                  "Treatment",
                                  snapshot.data.treatments[index]
                                      .singleTreatmentId.specialNote,
                                ),
                                _buildTreatmentField(
                                  "Prescription",
                                  snapshot.data.treatments[index]
                                      .singleTreatmentId.prescription,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
      },
    );
  }

  Widget _buildTreatmentField(title, body) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.domain_verification_rounded),
            SizedBox(width: 5),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 30),
            Column(
              children: [
                SizedBox(
                  height: 6,
                ),
                Icon(
                  Icons.circle,
                  size: 8,
                ),
              ],
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                body,
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ],
    );
  }

  //methods and on clicks
  void _callApi() {
    FullTreatmentApi _fullTreatmentApi = FullTreatmentApi();

    try {
      if (widget.fullTreatmentId != null) {
        _fullTreatmentModelFuture = _fullTreatmentApi
            .getFullTreatment(widget.fullTreatmentId)
            .catchError(
          (error) {
            print("Error : " + error);
          },
        );
      } else {
        _fullTreatmentModelFuture = null;
      }
    } catch (error) {
      print("Error " + error);
    }
  }
}
