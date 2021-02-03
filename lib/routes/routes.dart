import 'package:flutter/material.dart';
import 'package:pcare/ui/patient/HomePage.dart';
import 'package:pcare/ui/Registeration/sign_in.dart';
import 'package:pcare/ui/Registeration/sign_up.dart';

Map<String, WidgetBuilder> routes = {
  '/home_page': (context) => HomePage(),
  '/sign_in': (context) => Signin(),
  '/sign_up': (context) => SignUp(),
};
