import 'package:flutter/material.dart';
import 'package:pcare/widgets/main_app_bar_widget.dart';
import 'package:pcare/widgets/patients/patient_drawer_widget.dart';

class SearchDoctor extends StatefulWidget {
  @override
  _SearchDoctorState createState() => _SearchDoctorState();
}

class _SearchDoctorState extends State<SearchDoctor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: PatientDrawerWidget(),
      appBar: MainAppBarWidget(
        //title: ,
      ),
    );
  }
}
