import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcare/Utils/PageUtils.dart';
import 'package:pcare/constants/app_colors.dart';
import 'package:pcare/constants/doctor/doctor_strings.dart';
import 'package:pcare/models/doctor/GetAllPatientsModel.dart';
import 'package:pcare/widgets/back_button_widget.dart';
import 'package:pcare/widgets/custom_progress_indicator_widget.dart';
import 'package:pcare/widgets/doctor/doctor_app_bar_widget.dart';

import 'full_treatment.dart';

class DoctorPatientDetail extends StatefulWidget {
  GetAllPatientsModel patient;

  DoctorPatientDetail(this.patient);

  @override
  _DoctorPatientDetailState createState() => _DoctorPatientDetailState();
}

class _DoctorPatientDetailState extends State<DoctorPatientDetail> {
  GetAllPatientsModel patient;

  List<Map<String, dynamic>> _treatments = [
    {
      "id": "1",
      "started_date": "01-01-2021",
      "case": "Fever",
      "status": "on-going",
      "end-date": "02-01-2021"
    },
    {
      "id": "2",
      "started_date": "01-01-2021",
      "case": "Cold",
      "status": "on-going",
      "end-date": "02-01-2021"
    },
    {
      "id": "3",
      "started_date": "01-01-2021",
      "case": "Cough",
      "status": "on-going",
      "end-date": "02-01-2021"
    },
    {
      "id": "4",
      "started_date": "01-01-2021",
      "case": "Lung Disorder",
      "status": "on-going",
      "end-date": "02-01-2021"
    },
    {
      "id": "5",
      "started_date": "01-01-2021",
      "case": "Heart Problem",
      "status": "on-going",
      "end-date": "02-01-2021"
    },
    {
      "id": "6",
      "started_date": "01-01-2021",
      "case": "Bone Issue",
      "status": "on-going",
    },
    {
      "id": "7",
      "started_date": "01-01-2021",
      "case": "Fracture",
      "status": "completed",
    },
  ];

  @override
  void initState() {
    super.initState();
    patient = widget.patient;
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
      title: DoctorUniversalStrings.patientDetails,
    );
  }

  _buildBody() {
    return SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buidUpperBody(),
            SizedBox(
              height: 25,
            ),
            Divider(),
            buildLowerBody()
          ],
        ));
  }

  Widget buidUpperBody() {
    return Container(
      padding: EdgeInsets.only(top: 15),
      margin: EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: CachedNetworkImage(
              progressIndicatorBuilder: (context, _, __) {
                return CustomProgressIndicatorWidget();
              },
              imageUrl: patient.user.profilePic,
              height: 120,
              width: 120,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                patient.user.firstname + " " + patient.user.lastname,
                style: Theme.of(Get.context).textTheme.headline1.copyWith(
                      color: UniversalColors.gradientColorStart,
                      fontSize: 28,
                    ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                patient.user.age,
                style: Theme.of(Get.context).textTheme.headline5.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildLowerBody() {
    return Column(
      children: [
        Text(
          DoctorUniversalStrings.appointments,
          style: Theme.of(Get.context).textTheme.headline4.copyWith(
              fontSize: 20, color: UniversalColors.gradientColorStart),
        ),
        buildTreatmentDetailsList(),
      ],
    );
  }

  Widget buildStepProgressIndicator() {
    return Container();
  }

  Widget buildTreatmentDetailsList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: patient.appointmentId.length,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTreatmentCard(index),
            SizedBox(height: 10),
            (patient.appointmentId[index].appointment.fullTreatmentId != null)
                ? Container(
                    padding: EdgeInsets.only(left: 20),
                    child: Text("--->"),
                  )
                : Container(),
            (patient.appointmentId[index].appointment.fullTreatmentId != null)
                ? SizedBox(height: 10)
                : Container(),
            Divider(),
          ],
        );
      },
    );
  }

  Widget buildTreatmentCard(int index) {
    return GestureDetector(
      onTap: () => {
        if (patient.appointmentId[index].appointment.fullTreatmentId != null)
          {
            PageUtils.pushPage(
              FullTreatment(
                fullTreatmentId:
                    patient.appointmentId[index].appointment.fullTreatmentId,
              ),
            ),
          }
      },
      child: Container(
        margin: const EdgeInsets.only(
          left: 12,
          right: 12,
          top: 16,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(14),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // (treatment["end-date"] == null
            //     ?
            Row(children: [
              Icon(Icons.date_range),
              SizedBox(width: 5),
              Text(patient.appointmentId[index].appointment.appointmentDate
                  .split("T")[0])
            ]),
            // : Row(
            //     children: [
            //       Icon(Icons.date_range),
            //       SizedBox(width: 5),
            //       Text(treatment["started_date"]),
            //       Expanded(
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Text(DoctorUniversalStrings.to),
            //           ],
            //         ),
            //       ),
            //       Text(treatment["end-date"]),
            //     ],
            //   )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                buildTreamentRow(
                    patient.appointmentId[index].appointment.status, "", true),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTreamentRow(String value, icon, showchip) {
    return Row(
      children: [
        icon != "" ? Icon(icon) : Container(),
        icon != "" ? SizedBox(width: 5) : Container(),
        value == DoctorUniversalStrings.on_Going
            ? Chip(
                label: Text(DoctorUniversalStrings.onGoing),
                backgroundColor: UniversalColors.green,
              )
            : showchip
                ? Chip(
                    label: Text(value.toUpperCase()),
                    backgroundColor: UniversalColors.lightGrey,
                  )
                : Text(
                    value,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 6,
                    style: Theme.of(context).textTheme.headline4.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: UniversalColors.black),
                  ),
      ],
    );
  }
}
