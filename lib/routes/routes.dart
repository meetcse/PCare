import 'package:flutter/material.dart';
import 'package:pcare/ui/patient/HomePage.dart';
import 'package:pcare/ui/Registeration/sign_in.dart';

Map<String, WidgetBuilder> routes = {
  '/home_page': (context) => HomePage(),
  '/sign_in': (context) => Signin(),
};
