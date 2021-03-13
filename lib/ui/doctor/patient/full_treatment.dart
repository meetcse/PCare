import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pcare/constants/app_colors.dart';
import 'package:pcare/constants/doctor/doctor_strings.dart';
import 'package:pcare/widgets/back_button_widget.dart';
import 'package:pcare/widgets/doctor/doctor_app_bar_widget.dart';

class FullTreatment extends StatefulWidget {
  @override
  _FullTreatmentState createState() => _FullTreatmentState();
}

class _FullTreatmentState extends State<FullTreatment> {
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
      title: /*TODO: replace it with variable later*/ 'FEVER',
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: _buildTreatmentList(),
    );
  }

  Widget _buildTreatmentList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: treatments.length,
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
                        treatments[index]["date"],
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.alarm,
                        size: 18,
                      ),
                      SizedBox(width: 5),
                      Text(
                        treatments[index]["time"],
                        style: TextStyle(fontSize: 12),
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
                        treatments[index]["case"],
                      ),
                      _buildTreatmentField(
                        "Observation",
                        treatments[index]["observation"],
                      ),
                      _buildTreatmentField(
                        "Experiments",
                        treatments[index]["experiments"],
                      ),
                      _buildTreatmentField(
                        "Treatment",
                        treatments[index]["treatment"],
                      ),
                      _buildTreatmentField(
                        "Prescription",
                        treatments[index]["prescription"],
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
}
