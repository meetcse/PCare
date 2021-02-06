import 'package:flutter/material.dart';
import 'package:pcare/ui/patient/HomePage.dart';
import 'package:pcare/ui/Registeration/sign_in.dart';
import 'package:pcare/ui/patient/appointments/my_appointments.dart';
import 'package:pcare/ui/patient/appointments/search_doctor.dart';
import 'package:pcare/ui/patient/current_treatment.dart';
import 'package:pcare/ui/patient/patient_todos.dart';
import 'package:pcare/ui/patient/wishlist.dart';

Map<String, WidgetBuilder> routes = {
  '/home_page': (context) => HomePage(),
  '/sign_in': (context) => Signin(),
  '/search_doctor': (context) => SearchDoctor(),
  '/my_appointments': (context) => MyAppointments(),
  '/wishlist': (context) => Wishlist(),
  '/current_treatment': (context) => CurrentTreatment(),
  '/patient_todos': (context) => PatientTodos(),
};
