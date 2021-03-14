import 'package:flutter/material.dart';

class UpcomingAppointments extends StatefulWidget {
  @override
  _UpcomingAppointmentsState createState() => _UpcomingAppointmentsState();
}

class _UpcomingAppointmentsState extends State<UpcomingAppointments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("upcoming appointments"),
      ),
    );
  }
}
